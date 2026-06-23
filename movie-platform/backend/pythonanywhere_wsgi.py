"""
PythonAnywhere WSGI 配置文件

在 PythonAnywhere Web 选项卡中，将 WSGI configuration file 指向此文件。

工作原理:
    PythonAnywhere 会自动设置 virtualenv，然后 import 这个文件。
    此文件负责加载 .env 环境变量并启动 Django WSGI application。
"""

import os
import sys

# --- 项目路径（按实际修改）---
project_home = '/home/你的PA用户名/movie-platform/backend'
if project_home not in sys.path:
    sys.path.insert(0, project_home)

# --- 加载 .env 环境变量 ---
# PythonAnywhere 环境变量也可以在 Web 选项卡的 "Environment variables" 中直接设置
env_path = os.path.join(project_home, '.env')
if os.path.exists(env_path):
    with open(env_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                # 去掉引号和两端空格
                value = value.strip().strip('"').strip("'")
                os.environ.setdefault(key, value)

# --- Django 初始化 ---
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
