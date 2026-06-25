# 电影票务平台 — CentOS 虚拟机部署详细教程

> 适用平台：CentOS 7 / CentOS Stream 8/9  
> 预计耗时：1-2 小时  
> 环境：Python 3.9+ / MySQL 8.0 / Nginx / Gunicorn

---

## 为什么选虚拟机？

| 对比 | 云服务器（腾讯云/阿里云） | 本地虚拟机 |
|------|---------------------------|-----------|
| 费用 | 最低 ¥50-100/年 | **免费** |
| 环境 | 远程 SSH | **本地 / 局域网访问** |
| 学习价值 | 一键部署面板 | **完整 Linux 运维体验** |
| 外网访问 | 公网 IP | 局域网内访问 |

---

## 一、部署架构图

```
用户浏览器（宿主机或局域网）
    │
    ▼
┌──────────────────────────────┐
│        Nginx (80端口)         │
│                               │
│  /api/*    → Gunicorn (8000) │
│  /admin/*  → Gunicorn (8000) │
│  /static/* → staticfiles/    │
│  /media/*  → media/          │
│  /*        → Vue dist/       │
└──────────┬───────────────────┘
           │
           ▼
┌──────────────────────┐
│  Gunicorn (8000端口)  │
│  Django REST API     │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│  MySQL (3306端口)     │
└──────────────────────┘
```

---

## 二、准备工作

### 2.1 虚拟机环境

- **VirtualBox** 或 **VMware** 安装 CentOS 7/8
- 虚拟机网络设置为 **桥接模式** 或 **NAT + 端口转发**
- 记录虚拟机 IP（`ip addr` 查看）

### 2.2 确认 .gitignore 已配置

项目根目录已创建好 `.gitignore`，敏感文件不会上传到 GitHub：

| 被忽略的内容 | 原因 |
|-------------|------|
| `.env` | 包含 SECRET_KEY、数据库密码 |
| `db.sqlite3` | 本地测试数据 |
| `node_modules/` | 太大 |
| `venv/`、`.virtualenvs/` | 虚拟环境 |
| `__pycache__/`、`*.pyc` | Python 缓存 |
| `media/avatars/*`、`media/posters/*` | 本地测试图片 |

### 2.3 本地构建 Vue 前端

```powershell
cd d:\DRFVUE\movie-platform\frontend
npm install              # 首次安装依赖
npm run build            # 构建 dist/
dir dist                 # 确认: index.html  js/  fonts/  favicon.ico
```

---

## 三、推送项目到 GitHub

```bash
cd d:\DRFVUE\movie-platform
git init
git add .
git commit -m "feat: 电影票务平台"

# 在 GitHub 创建私有仓库 movie-platform 后：
git remote add origin https://github.com/你的用户名/movie-platform.git
git branch -M main
git push -u origin main
```

---

## 四、CentOS 基础环境配置

> 以下所有命令在虚拟机 CentOS 终端（root 或 sudo 用户）执行。

### 4.1 更新系统 & 安装基础工具

```bash
sudo yum update -y
sudo yum install -y git wget curl vim net-tools
```

### 4.2 安装 Python 3.9+

CentOS 7 默认 Python 较低，需要安装高版本：

```bash
# CentOS 7
sudo yum install -y centos-release-scl
sudo yum install -y rh-python39 rh-python39-python-devel
scl enable rh-python39 bash

# CentOS Stream 8/9 直接装
sudo dnf install -y python3 python3-devel python3-pip
```

验证：

```bash
python3 --version     # 应 >= 3.9
```

### 4.3 安装 MySQL 8.0

```bash
# 添加 MySQL 官方仓库
sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm

# 安装 MySQL
sudo yum install -y mysql-community-server

# 启动 & 开机自启
sudo systemctl start mysqld
sudo systemctl enable mysqld

# 获取临时密码
sudo grep 'temporary password' /var/log/mysqld.log
```

登录并配置数据库：

```bash
mysql -u root -p
# 输入上面获取的临时密码

# 修改 root 密码（注意 MySQL 8.0 密码策略要求大小写+数字+特殊字符）
ALTER USER 'root'@'localhost' IDENTIFIED BY '你的新密码如 Root@123456';

# 创建项目数据库
CREATE DATABASE movie_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 创建项目专用用户（可选，更安全）
CREATE USER 'movie'@'localhost' IDENTIFIED BY 'Movie@123456';
GRANT ALL PRIVILEGES ON movie_platform.* TO 'movie'@'localhost';
FLUSH PRIVILEGES;

EXIT;
```

### 4.4 安装 Nginx

```bash
sudo yum install -y epel-release
sudo yum install -y nginx

sudo systemctl start nginx
sudo systemctl enable nginx
```

宿主机浏览器访问 `http://虚拟机IP`，看到 Nginx 欢迎页即安装成功。

---

## 五、拉取项目 & 配置环境

### 5.1 克隆仓库

```bash
cd /home
sudo mkdir -p /web
sudo chown $USER:$USER /web
cd /web

git clone https://github.com/你的用户名/movie-platform.git
cd movie-platform
```

### 5.2 创建 Python 虚拟环境

```bash
cd /web/movie-platform/backend

python3 -m venv venv
source venv/bin/activate

# 安装依赖
pip install --upgrade pip
pip install -r requirements.txt
# 安装 Gunicorn（生产环境 WSGI 服务器）
pip install gunicorn
```

### 5.3 创建 .env 环境变量

```bash
cd /web/movie-platform/backend

# 生成 SECRET_KEY
python3 -c "import secrets; print(secrets.token_urlsafe(64))"
# 复制输出

vim .env
```

填入：

```ini
DJANGO_SECRET_KEY=上面生成的随机字符串粘贴到这里
DJANGO_DEBUG=False
DJANGO_ALLOWED_HOSTS=虚拟机IP,localhost,127.0.0.1
DB_NAME=movie_platform
DB_USER=movie
DB_PASSWORD=Movie@123456
DB_HOST=127.0.0.1
DB_PORT=3306
CORS_ALLOWED_ORIGINS=http://虚拟机IP,http://localhost
```

> IP 示例：`192.168.1.100`。如果 NAT 模式，填 `localhost` 即可。

### 5.4 Django 初始化

```bash
cd /web/movie-platform/backend
source venv/bin/activate

python manage.py makemigrations users movies orders stats
python manage.py migrate
python manage.py collectstatic --noinput

# 创建管理员
python manage.py createsuperuser
```

---

## 六、配置 Gunicorn

### 6.1 测试 Gunicorn 能否启动

```bash
cd /web/movie-platform/backend
source venv/bin/activate

gunicorn --bind 0.0.0.0:8000 backend.wsgi:application
# Ctrl+C 停止，确认能正常启动即可
```

### 6.2 创建 systemd 服务（开机自启）

```bash
sudo vim /etc/systemd/system/movie-gunicorn.service
```

填入：

```ini
[Unit]
Description=Movie Platform Gunicorn
After=network.target mysqld.service
Wants=mysqld.service

[Service]
User=你的Linux用户名
Group=你的Linux用户组
WorkingDirectory=/web/movie-platform/backend
EnvironmentFile=/web/movie-platform/backend/.env
ExecStart=/web/movie-platform/backend/venv/bin/gunicorn \
    --workers 3 \
    --bind 127.0.0.1:8000 \
    --access-logfile /var/log/movie/gunicorn-access.log \
    --error-logfile /var/log/movie/gunicorn-error.log \
    backend.wsgi:application

[Install]
WantedBy=multi-user.target
```

启动服务：

```bash
sudo mkdir -p /var/log/movie
sudo chown $USER:$USER /var/log/movie

sudo systemctl daemon-reload
sudo systemctl start movie-gunicorn
sudo systemctl enable movie-gunicorn

# 检查状态
sudo systemctl status movie-gunicorn
# 看到 active (running) 即成功
```

---

## 七、配置 Nginx

### 7.1 创建 Nginx 配置文件

```bash
sudo vim /etc/nginx/conf.d/movie-platform.conf
```

填入（**把 `虚拟机IP` 和项目路径改成实际值**）：

```nginx
server {
    listen 80;
    server_name 虚拟机IP localhost;

    # 日志
    access_log /var/log/nginx/movie-access.log;
    error_log  /var/log/nginx/movie-error.log;

    # Vue 前端静态文件
    root /web/movie-platform/frontend/dist;
    index index.html;

    # Django Admin 静态文件
    location /static/ {
        alias /web/movie-platform/backend/staticfiles/;
    }

    # 上传的媒体文件（电影海报、头像）
    location /media/ {
        alias /web/movie-platform/backend/media/;
    }

    # API 请求 → Gunicorn（^~ 确保优先于 SPA 兜底）
    location ^~ /api/ {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Django Admin → Gunicorn（^~ 确保优先于 SPA 兜底）
    location ^~ /admin/ {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Vue SPA 兜底：仅前端路由返回 index.html
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 7.2 检查并重载 Nginx

```bash
sudo nginx -t                # 检查配置语法
sudo systemctl reload nginx
```

---

## 八、配置防火墙

```bash
# 开放 HTTP 端口
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# 如果没有 firewalld，用 iptables：
# sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
# sudo service iptables save
```

> ⚠️ 虚拟机 NAT 模式下，需要在 VirtualBox/VMware 设置中做端口转发（宿主机端口 → 虚拟机 80 端口）。

---

## 九、配置定时任务（订单超时取消）

```bash
crontab -e
```

添加一行（每 15 分钟执行一次）：

```cron
*/15 * * * * cd /web/movie-platform/backend && /web/movie-platform/backend/venv/bin/python manage.py cancel_expired_orders >> /var/log/movie/cron.log 2>&1
```

---

## 十、设置 SELinux（如果开启）

如果 SELinux 处于 enforcing 模式，需要允许 Nginx 访问项目文件：

```bash
# 检查 SELinux 状态
getenforce

# 如果是 Enforcing，执行以下命令
sudo setsebool -P httpd_can_network_connect on
sudo chcon -R -t httpd_sys_content_t /web/movie-platform/frontend/dist/
sudo chcon -R -t httpd_sys_content_t /web/movie-platform/backend/staticfiles/
sudo chcon -R -t httpd_sys_rw_content_t /web/movie-platform/backend/media/
```

---

## 十一、验证部署

宿主机浏览器访问：`http://虚拟机IP`

### 测试清单

| 测试项 | 地址 | 预期结果 |
|--------|------|----------|
| 首页 | `/` | 电影卡片列表 |
| 电影详情 | `/movie/1` | 详情 + 场次列表 |
| 登录 | `/login` | 登录/注册页面 |
| 后台管理 | `/admin/` | Django Admin 登录 |
| API | `/api/movies/` | JSON 格式电影数据 |
| 静态文件 | `/static/admin/css/base.css` | CSS 正常加载 |

### 排查命令

```bash
# 查看 Nginx 错误日志
sudo tail -f /var/log/nginx/movie-error.log

# 查看 Gunicorn 日志
tail -f /var/log/movie/gunicorn-error.log

# 检查 Gunicorn 是否运行
sudo systemctl status movie-gunicorn

# 检查 Nginx 是否运行
sudo systemctl status nginx

# 检查端口监听
sudo netstat -tlnp | grep -E '80|8000'
```

---

## 十二、日常维护命令速查

```bash
# 更新代码
cd /web/movie-platform
git pull
cd backend
source venv/bin/activate
python manage.py migrate
python manage.py collectstatic --noinput
sudo systemctl restart movie-gunicorn

# 查看实时日志
sudo tail -f /var/log/nginx/movie-access.log

# 重启服务
sudo systemctl restart movie-gunicorn
sudo systemctl restart nginx

# MySQL 登录
mysql -u root -p movie_platform

# Django shell
cd /web/movie-platform/backend
source venv/bin/activate
python manage.py shell
```

---

## 附录：文件对照表

| 文件/目录 | 路径 | 作用 |
|-----------|------|------|
| `.env` | `backend/.env` | 环境变量（密钥、数据库配置） |
| `venv/` | `backend/venv/` | Python 虚拟环境 |
| `dist/` | `frontend/dist/` | Vue 前端构建产物 |
| `staticfiles/` | `backend/staticfiles/` | Django Admin 静态文件 |
| `media/` | `backend/media/` | 上传的海报、头像 |
| Nginx 配置 | `/etc/nginx/conf.d/movie-platform.conf` | 反向代理 & 静态文件 |
| Gunicorn 配置 | `/etc/systemd/system/movie-gunicorn.service` | 后端进程管理 |
| 定时任务 | `crontab -e` | 订单超时取消 |

---

## 附录：常见问题

### Q1：访问显示 502 Bad Gateway

Gunicorn 没启动或挂了。检查：

```bash
sudo systemctl status movie-gunicorn
sudo journalctl -u movie-gunicorn -n 50
```

### Q2：页面白屏，控制台报 JS 404

检查 Nginx 配置中 `root` 路径是否正确指向 `frontend/dist/`。

### Q3：图片上传后不显示

1. 确认 `media/` 目录存在且有写入权限
2. 确认 Nginx 中 `/media/` 的 `alias` 路径正确
3. `sudo chmod -R 755 /web/movie-platform/backend/media/`

### Q4：MySQL 连接被拒绝

1. 检查 MySQL 是否运行：`sudo systemctl status mysqld`
2. 检查 `.env` 中数据库密码是否正确
3. 确认用户权限：`SELECT user,host FROM mysql.user;`

### Q5：静态文件 404

```bash
cd /web/movie-platform/backend
source venv/bin/activate
python manage.py collectstatic --noinput
sudo systemctl restart nginx
```
