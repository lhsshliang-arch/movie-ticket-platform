# 电影票务平台 — PythonAnywhere 部署详细教程

> 适用平台：PythonAnywhere.com  
> 预计耗时：30-40 分钟  
> 费用：免费版够用（Hacker 计划 $5/月可选 MySQL）

---

## 为什么选 PythonAnywhere？

| 对比 | 云服务器（腾讯云/阿里云） | PythonAnywhere |
|------|---------------------------|----------------|
| 费用 | 最低 ¥50-100/年 | **免费版可用** |
| 环境配置 | 手动装 Nginx/Gunicorn/MySQL | **平台已配好** |
| 命令行 | SSH | **网页终端** |
| 域名 | 需购买 | **免费 `xxx.pythonanywhere.com`** |
| 适合人群 | 有运维经验 | **零基础也能部署** |

---

## 一、部署架构图（PythonAnywhere 版）

```
用户浏览器
    │
    ▼
┌─────────────────────────────────────┐
│      PythonAnywhere Web 服务         │
│                                      │
│  静态文件映射:                        │
│    /js/*      → dist/js/             │
│    /fonts/*   → dist/fonts/          │
│    /favicon.ico → dist/favicon.ico   │
│    /static/*  → staticfiles/         │
│    /media/*   → media/               │
│                                      │
│  WSGI 应用 (Django):                 │
│    /api/*     → Django REST API      │
│    /admin/*   → Django Admin         │
│    /*         → Vue SPA index.html   │
└──────────────┬──────────────────────┘
               │
               ▼
┌──────────────────────┐
│  SQLite（免费版）     │
│  或 MySQL（付费版）   │
└──────────────────────┘
```

---

## 二、准备工作（本地操作）

### 2.1 注册

- **GitHub**：https://github.com → 注册账号（已有则跳过）
- **PythonAnywhere**：https://www.pythonanywhere.com → 点击 **"Create a Beginner account"**

> PA 免费版限制：
> - 只能用 SQLite（本项目已支持切换）
> - 一个 web app
> - 域名固定为 `你的PA用户名.pythonanywhere.com`

### 2.2 确认 .gitignore 已配置

项目根目录已创建好 `.gitignore`，**以下文件不会被上传到 GitHub**（保护敏感信息）：

| 被忽略的内容 | 原因 |
|-------------|------|
| `.env` | 包含 SECRET_KEY、数据库密码 |
| `db.sqlite3`、`*.sqlite3` | 本地测试数据 |
| `node_modules/` | 太大，npm install 即可 |
| `venv/`、`.virtualenvs/` | 虚拟环境 |
| `__pycache__/`、`*.pyc` | Python 缓存 |
| `staticfiles/` | 部署时重新 collectstatic |
| `media/avatars/*`、`media/posters/*` | 本地测试图片 |
| `frontend/dist/` | 部署前本地构建即可 |
| `.idea/`、`.vscode/` | IDE 配置 |

你可以查看 `movie-platform/.gitignore` 确认。

### 2.3 本地构建 Vue 前端

`.gitignore` 已经配置好，`frontend/dist/` **不会被忽略**，本地构建后直接提交即可。

在 PowerShell（或 Git Bash）中：

```powershell
cd d:\DRFVUE\movie-platform\frontend

# 如果之前没装过依赖
npm install

# 构建生产版本
npm run build

# 确认产物
dir dist
# 应该看到: index.html  js/  fonts/  favicon.ico
```

> 构建完 `dist/` 就留在那里，后面跟着代码一起 `git push`。

---

## 三、推送项目到 GitHub（本地操作）

### 3.1 初始化 Git 仓库

打开 Git Bash（或 PowerShell），执行：

```bash
cd d:\DRFVUE\movie-platform

# 初始化 Git 仓库
git init

# 添加所有文件（.gitignore 会自动过滤敏感文件）
git add .

# 检查有没有不该提交的文件
git status

# 首次提交
git commit -m "feat: 电影票务平台 - 初始化项目"
```

### 3.2 创建 GitHub 远程仓库

1. 打开 https://github.com ，登录
2. 点击右上角 **+** → **New repository**
3. 仓库名填写：`movie-platform`
4. **⚠️ 选择 Private（私有仓库）** — 保护你的代码
5. **不要**勾选 "Add a README file"（本地已有）
6. 点击 **Create repository**

### 3.3 推送代码

GitHub 创建完仓库后会显示命令，复制并执行：

```bash
git remote add origin https://github.com/你的用户名/movie-platform.git
git branch -M main
git push -u origin main
```

> 如果弹窗要求登录 GitHub，用浏览器授权即可。或者用 **Personal Access Token**：
> GitHub → Settings → Developer settings → Personal access tokens → Generate new token（勾选 `repo` 权限），然后把 token 当密码用。

### 3.4 验证

浏览器打开 `https://github.com/你的用户名/movie-platform`，确认所有文件都推上去了。

---

## 四、PythonAnywhere 拉取项目

### 4.1 打开 PA 终端

1. 登录 https://www.pythonanywhere.com
2. 点击顶部 **Consoles** 标签
3. 点击 **Bash** — 会打开一个网页版终端

### 4.2 克隆仓库

```bash
cd /home/你的PA用户名

# 克隆你的私有仓库
git clone https://github.com/你的GitHub用户名/movie-platform.git

# 确认文件已拉取
ls movie-platform/
# 应该看到: backend/  frontend/  .gitignore  DEPLOY.md
ls movie-platform/frontend/dist/
# 应该看到: index.html  js/  fonts/  favicon.ico
```

### 4.3 以后更新代码

```bash
cd /home/你的PA用户名/movie-platform

# 每次本地改完代码 push 后，在 PA 上拉取
git pull

# 如果有数据库变更
cd backend
source /home/你的PA用户名/.virtualenvs/movie-env/bin/activate
python manage.py migrate
python manage.py collectstatic --noinput

# 然后去 PA Web 标签页 → Reload
```

---

## 五、配置环境变量

### 5.1 生成 SECRET_KEY

在 PA 的 Bash 终端：

```bash
python3 -c "import secrets; print(secrets.token_urlsafe(64))"
# 复制输出结果（一长串字符）
```

### 5.2 创建 .env 文件

在 PA 的 Bash 终端：

```bash
cd /home/你的用户名/movie-platform/backend
nano .env
```

粘贴以下内容（**把 `<>` 部分改成你自己的**）：

```ini
DJANGO_SECRET_KEY=<刚才生成的随机字符串>
DJANGO_DEBUG=False
DJANGO_ALLOWED_HOSTS=你的用户名.pythonanywhere.com,localhost,127.0.0.1
DB_ENGINE=sqlite
DB_NAME=/home/你的用户名/movie-platform/backend/db.sqlite3
CORS_ALLOWED_ORIGINS=https://你的用户名.pythonanywhere.com
CSRF_TRUSTED_ORIGINS=https://你的用户名.pythonanywhere.com
SECURE_SSL_REDIRECT=False
SECURE_HSTS_SECONDS=0
```

> **按 `Ctrl+O`** 保存，**`Ctrl+X`** 退出。

> 💡 **提示**：PA 免费版用 SQLite。如果以后升级到 Hacker 计划（$5/月），改成：
> ```ini
> DB_ENGINE=mysql
> DB_NAME=你的用户名$数据库名
> DB_USER=你的用户名
> DB_PASSWORD=你的MySQL密码
> DB_HOST=你的用户名.mysql.pythonanywhere-services.com
> DB_PORT=3306
> ```

---

## 六、设置虚拟环境 & 安装依赖

在 PA 的 **Consoles** → Bash 终端：

```bash
cd /home/你的用户名/movie-platform/backend

# 创建虚拟环境
mkvirtualenv --python=/usr/bin/python3.11 movie-env

# 激活虚拟环境（mkvirtualenv 已自动激活）
# 以后每次使用: workon movie-env

# 安装依赖
pip install -r requirements_pa.txt
```

> **注意**：PA 的虚拟环境命令是 `mkvirtualenv`，不是 `python -m venv`。

---

## 七、Django 初始配置

在 PA 的 Bash 终端（确保虚拟环境已激活）：

```bash
cd /home/你的用户名/movie-platform/backend

# 生成迁移文件
python manage.py makemigrations users movies orders stats

# 执行迁移
python manage.py migrate

# 收集静态文件（Django Admin 的 CSS/JS）
python manage.py collectstatic --noinput

# 创建管理员账户
python manage.py createsuperuser
# 输入用户名、邮箱、密码
```

---

## 八、配置 Web 应用

这是最关键的一步！

### 8.1 进入 Web 选项卡

1. 点击 PythonAnywhere 顶部的 **Web** 标签
2. 点击 **Add a new web app**
3. 选择 **Manual configuration**（不要选 Django 自动配置）
4. 选择 **Python 3.11**

### 8.2 配置虚拟环境

在 Web 选项卡中，找到 **Virtualenv** 部分，填入：

```
/home/你的用户名/.virtualenvs/movie-env
```

（或直接点击旁边的小箭头从下拉选择）

### 8.3 配置 WSGI 文件

在 Web 选项卡的 **Code** 部分：

- 点击 **WSGI configuration file** 后面的链接（类似 `/var/www/你的用户名_pythonanywhere_com_wsgi.py`）

**删除文件中的全部内容**，替换为以下内容（**把 `你的用户名` 改为你的 PA 用户名**）：

```python
import os
import sys

# 项目路径
project_home = '/home/你的用户名/movie-platform/backend'
if project_home not in sys.path:
    sys.path.insert(0, project_home)

# 加载 .env 环境变量
env_path = os.path.join(project_home, '.env')
if os.path.exists(env_path):
    with open(env_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                value = value.strip().strip('"').strip("'")
                os.environ.setdefault(key, value)

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
```

点击 **Save** 保存。

### 8.4 配置静态文件映射

在 Web 选项卡的 **Static files** 部分，添加以下映射：

| URL | Directory | 说明 |
|-----|-----------|------|
| `/static/` | `/home/你的用户名/movie-platform/backend/staticfiles/` | Django Admin 静态文件 |
| `/media/` | `/home/你的用户名/movie-platform/backend/media/` | 上传的头像/海报 |
| `/js/` | `/home/你的用户名/movie-platform/frontend/dist/js/` | Vue 前端 JS |
| `/fonts/` | `/home/你的用户名/movie-platform/frontend/dist/fonts/` | 图标字体 |
| `/favicon.ico` | `/home/你的用户名/movie-platform/frontend/dist/favicon.ico` | 网站图标 |

> 每添加一行点击一次 ✅ 确认。共 5 条映射。

### 8.5 点击 Reload

在 Web 选项卡顶部，点击绿色的 **Reload** 按钮。

---

## 九、配置定时任务（订单超时取消）

在 PA 的 **Tasks** 标签页：

- **Hourly task**: 填入执行时间（如 `:00` 表示每小时整点）

或者设置 **Always-on task**（需要付费版）。免费版可以配置 **Scheduled task**：

在 **Scheduled tasks** 部分：
1. 选择执行频率：**Hourly**
2. 时间：`:00`
3. 命令：
```
cd /home/你的用户名/movie-platform/backend && /home/你的用户名/.virtualenvs/movie-env/bin/python manage.py cancel_expired_orders
```
4. 点击 **Create**

> 💡 免费版的定时任务每小时执行一次。VPS 版可以每分钟执行。这个小差异影响不大——用户端倒计时 15 分钟后订单失效，最坏情况是 1 小时内自动取消。

---

## 十、验证部署

打开浏览器，访问：

```
https://你的用户名.pythonanywhere.com
```

你应该看到电影票务平台的首页！

### 测试清单

| 测试项 | 地址 | 预期结果 |
|--------|------|----------|
| 首页 | `/` | 电影卡片列表 |
| 电影详情 | `/movie/1` | 详情 + 场次列表 |
| 登录 | `/login` | 登录/注册页面 |
| 后台管理 | `/admin/` | Django Admin 登录 |
| API 测试 | `/api/movies/` | JSON 格式电影数据 |
| 静态文件 | `/static/admin/css/base.css` | 应该正常加载 |

### 如果首页白屏

在 PA 的 **Web** 标签页点击 **Reload**，然后看错误日志（Web 标签页上方有错误日志链接）。

常见原因：
- `.env` 文件中 `DJANGO_ALLOWED_HOSTS` 域名写错了
- 静态文件映射路径不对
- 虚拟环境没选对

---

## 十一、免费版 vs 付费版对比

| 功能 | 免费版 (Beginner) | 付费版 (Hacker $5/月) |
|------|-------------------|------------------------|
| 数据库 | SQLite | **MySQL** |
| 定时任务 | 每小时一次 | **每分钟** |
| 自定义域名 | ❌ | ✅ |
| 静态文件 | ✅ | ✅ |
| HTTPS | ✅（自动） | ✅ |
| Web App 数量 | 1 | 无限 |
| CPU / 内存 | 基础 | 更多 |
| 外网访问 | 受限白名单 | 无限制 |

---

## 十二、常见问题排查

### 问题 1：访问显示 "Something went wrong"

在 Web 标签页点击 **Error log**，查看具体报错。最常见的情况：

- 数据库未迁移 → 在 Bash 终端执行 `python manage.py migrate`
- `.env` 文件不存在或路径错误
- 缺少 Python 包 → `pip install -r requirements_pa.txt`

### 问题 2：页面加载了但样式全没了

检查静态文件映射是否正确配置。访问 `/static/admin/css/base.css` 测试。

### 问题 3：CORS 报错

确认 `.env` 中的 `CORS_ALLOWED_ORIGINS` 包含 `https://你的用户名.pythonanywhere.com`，**注意是 https**。

### 问题 4：图片上传后不显示

1. 确认 `/media/` 静态映射正确
2. 确认 `media/` 目录存在：`mkdir -p /home/你的用户名/movie-platform/backend/media`
3. 每次重新部署后需要 **Reload** web app

### 问题 5：修改代码后如何生效

```bash
# 在 PA 的 Bash 终端
cd /home/你的用户名/movie-platform
git pull                         # 拉取最新代码
cd backend
workon movie-env
python manage.py migrate         # 如果有数据库变更
python manage.py collectstatic --noinput
```

然后点击 Web 标签页的 **Reload**。

### 问题 6：修改了代码怎么更新到线上

```bash
# 步骤 1：在本地修改代码，构建前端，然后推送
cd d:\DRFVUE\movie-platform
git add .
git commit -m "描述你的改动"
git push

# 步骤 2：在 PA 的 Bash 终端拉取更新
cd /home/你的用户名/movie-platform
git pull
cd backend
workon movie-env
python manage.py migrate          # 如果有数据库变更
python manage.py collectstatic --noinput

# 步骤 3：点击 PA Web 标签页的绿色 Reload 按钮
```

---

## 十三、日常维护命令速查

```bash
# SSH 到 PA（不需要！直接在网页 Bash 终端操作）

# 激活虚拟环境
workon movie-env

# 查看生产环境日志
# Web 标签页 → Error log 链接（或 Access log）

# Django shell
cd /home/你的用户名/movie-platform/backend
python manage.py shell

# 创建管理员
python manage.py createsuperuser

# 查看数据库
python manage.py dbshell
```

---

## 附录：文件对照表

| 文件 | 位置 | 作用 |
|------|------|------|
| `requirements_pa.txt` | `backend/` | PA 专用 Python 依赖 |
| `.env` | `backend/` | 环境变量（SECRET_KEY, DB 配置等） |
| `pythonanywhere_wsgi.py` | `backend/` | PA WSGI 入口（参考用，实际用 Web 标签页中的） |
| `dist/` | `frontend/` | Vue 前端构建产物 |
| `staticfiles/` | `backend/` | `collectstatic` 后 Django Admin 静态文件 |
| `media/` | `backend/` | 用户上传的电影海报、头像 |
