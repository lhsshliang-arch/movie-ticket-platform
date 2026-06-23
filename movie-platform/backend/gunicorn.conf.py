"""
Gunicorn 生产环境配置文件
启动命令: gunicorn -c gunicorn.conf.py backend.wsgi:application
"""

import multiprocessing
import os

# 绑定地址和端口
bind = "127.0.0.1:8000"

# Worker 进程数（一般为 CPU 核数 × 2 + 1）
workers = multiprocessing.cpu_count() * 2 + 1

# Worker 类型
worker_class = "sync"

# 每个 worker 的线程数
threads = 2

# 最大请求数（处理这么多请求后重启 worker，防止内存泄漏）
max_requests = 1000
max_requests_jitter = 50

# 超时设置（秒）
timeout = 30
graceful_timeout = 30
keepalive = 5

# 日志
accesslog = os.path.join(os.path.dirname(__file__), "logs", "gunicorn_access.log")
errorlog = os.path.join(os.path.dirname(__file__), "logs", "gunicorn_error.log")
loglevel = "info"

# 以守护进程运行（systemd 管理时设为 False）
daemon = False

# PID 文件
pidfile = os.path.join(os.path.dirname(__file__), "gunicorn.pid")

# 环境变量
raw_env = [
    f"DJANGO_SETTINGS_MODULE=backend.settings",
]
