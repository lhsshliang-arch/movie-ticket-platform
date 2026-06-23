#!/bin/bash
# =====================
# 电影票务平台 - 一键部署脚本
# 适用: Ubuntu 20.04 / 22.04
# 使用方法:
#   1. 复制整个 movie-platform 目录到服务器 /home/ubuntu/
#   2. chmod +x deploy.sh
#   3. sudo ./deploy.sh
# =====================

set -e  # 遇到错误立即退出

echo "========================================="
echo "  电影票务平台 - 开始部署"
echo "========================================="

# ---------- 配置变量（按实际情况修改）----------
PROJECT_DIR="/home/ubuntu/movie-platform"
BACKEND_DIR="$PROJECT_DIR/backend"
FRONTEND_DIR="$PROJECT_DIR/frontend"
# ------------------------------------------------

# 1. 安装系统依赖
echo ""
echo "[1/8] 安装系统依赖..."
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip python3-venv nginx mysql-server libmysqlclient-dev nodejs npm

# 2. 创建项目目录
echo ""
echo "[2/8] 创建项目目录结构..."
mkdir -p "$BACKEND_DIR/logs"
mkdir -p "$BACKEND_DIR/media/avatars"
mkdir -p "$BACKEND_DIR/media/posters"

# 3. 配置 Python 虚拟环境
echo ""
echo "[3/8] 配置 Python 虚拟环境..."
cd "$BACKEND_DIR"
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 4. 配置 MySQL 数据库
echo ""
echo "[4/8] 配置 MySQL 数据库..."
echo "请输入 MySQL root 密码（首次安装直接回车）："
sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS movie_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'movie_user'@'localhost' IDENTIFIED BY 'MoviePlatForm@2026!';
GRANT ALL PRIVILEGES ON movie_platform.* TO 'movie_user'@'localhost';
FLUSH PRIVILEGES;
EOF

# 5. 创建 .env 环境变量文件
echo ""
echo "[5/8] 创建生产环境配置文件..."
if [ ! -f "$BACKEND_DIR/.env" ]; then
    # 生成随机 SECRET_KEY
    SECRET_KEY=$(python3 -c "import secrets; print(secrets.token_urlsafe(64))")

    cat > "$BACKEND_DIR/.env" <<ENVEOF
DJANGO_SECRET_KEY=$SECRET_KEY
DJANGO_DEBUG=False
DJANGO_ALLOWED_HOSTS=$(curl -s ifconfig.me 2>/dev/null || echo '你的服务器IP'),localhost,127.0.0.1
DB_NAME=movie_platform
DB_USER=movie_user
DB_PASSWORD=MoviePlatForm@2026!
DB_HOST=127.0.0.1
DB_PORT=3306
CORS_ALLOWED_ORIGINS=http://$(curl -s ifconfig.me 2>/dev/null || echo '你的服务器IP'),http://localhost:8080
CSRF_TRUSTED_ORIGINS=http://$(curl -s ifconfig.me 2>/dev/null || echo '你的服务器IP'),http://localhost:8080
SECURE_SSL_REDIRECT=False
SECURE_HSTS_SECONDS=0
ENVEOF

    echo "  已生成 $BACKEND_DIR/.env"
else
    echo "  .env 文件已存在，跳过"
fi

# 6. Django 迁移和静态文件
echo ""
echo "[6/8] Django 数据库迁移 & 收集静态文件..."
cd "$BACKEND_DIR"
source venv/bin/activate
python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --noinput

# 创建 Django 超级管理员
echo ""
read -p "是否创建管理员账户？(y/n): " CREATE_ADMIN
if [ "$CREATE_ADMIN" = "y" ]; then
    python manage.py createsuperuser
fi

# 7. 构建前端
echo ""
echo "[7/8] 构建前端..."
cd "$FRONTEND_DIR"
if ! command -v npm &> /dev/null; then
    echo "  未找到 npm，正在安装 Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi
npm install
npm run build
echo "  前端构建完成 -> $FRONTEND_DIR/dist/"

# 8. 配置 Nginx
echo ""
echo "[8/8] 配置 Nginx 和 systemd 服务..."

# 获取服务器 IP 用于 Nginx 配置
SERVER_IP=$(curl -s ifconfig.me 2>/dev/null || echo '你的服务器IP')

# Nginx
sudo cp "$PROJECT_DIR/nginx.conf" /etc/nginx/sites-available/movie-platform
sudo sed -i "s/你的域名或IP/$SERVER_IP/g" /etc/nginx/sites-available/movie-platform
sudo ln -sf /etc/nginx/sites-available/movie-platform /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx

# 修改 Nginx 用户与项目目录权限
sudo chown -R www-data:www-data "$BACKEND_DIR/media"
sudo chmod -R 755 "$BACKEND_DIR/media"

# systemd 服务
sudo cp "$BACKEND_DIR/movie-platform.service" /etc/systemd/system/
sudo systemctl daemon-reload

# 9. 配置定时任务（订单超时取消）
echo ""
echo "配置订单超时取消定时任务（每分钟执行）..."
(crontab -l 2>/dev/null; echo "* * * * * cd $BACKEND_DIR && $BACKEND_DIR/venv/bin/python manage.py cancel_expired_orders >> $BACKEND_DIR/logs/cron.log 2>&1") | crontab -

# 完成
echo ""
echo "========================================="
echo "  部署完成！"
echo "========================================="
echo ""
echo "  访问地址: http://$SERVER_IP"
echo ""
echo "  后续管理命令:"
echo "    启动后端:    sudo systemctl start movie-platform"
echo "    停止后端:    sudo systemctl stop movie-platform"
echo "    重启后端:    sudo systemctl restart movie-platform"
echo "    查看状态:    sudo systemctl status movie-platform"
echo "    查看日志:    sudo journalctl -u movie-platform -f"
echo "    重启 Nginx:  sudo systemctl restart nginx"
echo ""
echo "  启动后端服务:"
echo "    sudo systemctl start movie-platform"
echo "    sudo systemctl enable movie-platform  # 开机自启"
echo ""
