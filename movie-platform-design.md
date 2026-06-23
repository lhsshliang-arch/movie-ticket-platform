# 电影票务平台 - 系统设计文档

> 日期：2026-05-19
> 技术栈：Django REST Framework + Vue2 + Element UI + MySQL

---

## 一、项目概述

前后端分离的在线电影票务平台。用户浏览电影、查看场次、下单购票；管理员通过独立后台管理电影、影厅、场次、订单，并通过 ECharts 图表查看销售统计数据。

---

## 二、用户角色

| 角色 | 权限 |
|------|------|
| 普通用户 | 浏览电影、查看场次、下单购票、查看我的订单、管理个人资料 |
| 管理员 | 以上全部 + 后台管理（电影/影厅/场次/订单 CRUD + 数据统计） |

---

## 三、功能模块

### 3.1 用户端

- 注册/登录（JWT 认证）
- 首页电影列表（分类筛选、热映/即将上映切换、搜索）
- 电影详情页（海报、简介、时长、评分、场次列表）
- 下单购票（选择场次 + 数量 → 模拟支付）
- 15 分钟支付倒计时（超时自动取消）
- 我的订单（按状态筛选、分页）
- 个人中心（头像上传、修改密码）

### 3.2 管理后台

- 电影管理（CRUD + 海报上传）
- 影厅管理（名称、容量）
- 场次管理（选择电影+影厅+时间+票价+票数）
- 订单管理（查看/筛选/状态变更）
- 数据统计（ECharts）：
  - 今日概览卡片（订单数、票房、场次、在映电影数）
  - 电影类型下单统计（饼图）
  - 每日票房趋势（折线图，支持时间范围筛选）
  - 热映电影销量排行（横向柱状图）

---

## 四、数据模型

### User（扩展 Django AbstractUser）

| 字段 | 类型 | 说明 |
|------|------|------|
| username | CharField | 用户名 |
| email | EmailField | 邮箱 |
| phone | CharField(11) | 手机号（可选） |
| avatar | ImageField | 头像（upload_to='avatars/'） |
| is_admin | BooleanField | 是否管理员（is_staff） |

### Category

| 字段 | 类型 | 说明 |
|------|------|------|
| name | CharField(50) | 分类名（动作/喜剧/科幻…） |

### Movie

| 字段 | 类型 | 说明 |
|------|------|------|
| title | CharField(200) | 片名 |
| description | TextField | 简介 |
| poster | ImageField | 海报 |
| duration | IntegerField | 时长（分钟） |
| category | FK(Category) | 分类 |
| release_date | DateField | 上映日期 |
| rating | FloatField(default=0) | 评分（0-10） |
| status | CharField | 状态: 热映/即将上映/下架 |

### Hall

| 字段 | 类型 | 说明 |
|------|------|------|
| name | CharField(50) | 影厅名（如"1号厅"） |
| capacity | IntegerField | 容量（座位数） |
| description | CharField(200) | 备注（可选） |

### Session（场次）

| 字段 | 类型 | 说明 |
|------|------|------|
| movie | FK(Movie) | 关联电影 |
| hall | FK(Hall) | 关联影厅 |
| start_time | DateTimeField | 放映时间 |
| price | DecimalField(10,2) | 票价 |
| total_tickets | IntegerField | 总票数 |
| sold_tickets | IntegerField | 已售票数（默认0） |

> **约束：** `unique_together(movie, hall, start_time)` — 同一影厅同一时间不能有两场

### Order

| 字段 | 类型 | 说明 |
|------|------|------|
| order_no | CharField(20) | 订单号（自动生成） |
| user | FK(User) | 用户 |
| session | FK(Session) | 场次 |
| quantity | IntegerField | 购买数量 |
| total_price | DecimalField(10,2) | 总价 |
| status | CharField | 状态: 待支付/已支付/已取消 |
| created_at | DateTimeField | 创建时间 |
| paid_at | DateTimeField | 支付时间（nullable） |
| cancelled_at | DateTimeField | 取消时间（nullable） |

---

## 五、API 设计

### 5.1 认证 `/api/auth/`

| 方法 | 端点 | 说明 | 认证 |
|------|------|------|------|
| POST | `/register/` | 注册 | 否 |
| POST | `/login/` | 登录，返回 access + refresh token | 否 |
| POST | `/refresh/` | 刷新 token | 否 |
| GET | `/profile/` | 获取当前用户信息 | 是 |
| PATCH | `/profile/` | 更新个人资料（含头像） | 是 |

### 5.2 电影 `/api/movies/`

| 方法 | 端点 | 说明 | 认证 |
|------|------|------|------|
| GET | `/` | 电影列表（分页、按分类/状态筛选、搜索） | 否 |
| GET | `/:id/` | 电影详情 | 否 |
| GET | `/:id/sessions/` | 某电影当天场次列表 | 否 |

### 5.3 订单 `/api/orders/`（需登录）

| 方法 | 端点 | 说明 |
|------|------|------|
| POST | `/` | 创建订单（扣减 sold_tickets） |
| GET | `/` | 我的订单列表（分页、按状态筛选） |
| GET | `/:id/` | 订单详情 |
| PATCH | `/:id/cancel/` | 取消订单（退还 sold_tickets） |
| PATCH | `/:id/pay/` | 模拟支付 |

### 5.4 管理员 API `/api/admin/`（需管理员权限）

| 方法 | 端点 | 说明 |
|------|------|------|
| CRUD | `/movies/` | 电影管理 |
| CRUD | `/halls/` | 影厅管理 |
| CRUD | `/sessions/` | 场次管理 |
| GET/PATCH | `/orders/` | 订单管理（列表+状态变更） |

### 5.5 统计数据 `/api/admin/stats/`（需管理员权限）

| 方法 | 端点 | 参数 | 说明 |
|------|------|------|------|
| GET | `/overview/` | - | 今日订单数、票房、场次、在映电影数 |
| GET | `/category-orders/` | start, end | 各分类订单数量（饼图数据） |
| GET | `/daily-box-office/` | start, end | 每日票房（折线图数据） |
| GET | `/movie-ranking/` | limit(默认10) | 热映电影销量排行 |

---

## 六、订单超时取消机制

### 6.1 策略

- 前端倒计时：下单后展示 15 分钟环形倒计时，倒计时结束提示用户
- 后端定时任务：每分钟执行 Django management command，扫描 `待支付 + created_at > 15分钟` 的订单，自动标记已取消并退还票数
- 查询场次剩余票数时，**排除已取消订单**所占的票数

### 6.2 定时任务命令

```bash
python manage.py cancel_expired_orders
```

部署时使用系统 crontab（Linux）或 Windows 计划任务每分钟执行一次。

---

## 七、前端路由

| 路径 | 页面 | 需登录 |
|------|------|--------|
| `/` | 首页（电影列表） | 否 |
| `/movie/:id` | 电影详情 + 场次 | 否 |
| `/order/:sessionId` | 确认下单 | 是 |
| `/orders` | 我的订单 | 是 |
| `/profile` | 个人中心 | 是 |
| `/login` | 登录/注册 | 否 |
| `/admin/dashboard` | 管理后台 - 概览 | 是(管理员) |
| `/admin/movies` | 管理后台 - 电影管理 | 是(管理员) |
| `/admin/halls` | 管理后台 - 影厅管理 | 是(管理员) |
| `/admin/sessions` | 管理后台 - 场次管理 | 是(管理员) |
| `/admin/orders` | 管理后台 - 订单管理 | 是(管理员) |
| `/admin/stats` | 管理后台 - 数据统计 | 是(管理员) |

---

## 八、前端页面结构

### 8.1 用户端布局

```
┌─────────────────────────────────────────────┐
│  Logo    搜索框             头像/用户名/登录  │  ← Navbar
├─────────────────────────────────────────────┤
│                                             │
│              <router-view>                  │  ← 页面内容
│                                             │
└─────────────────────────────────────────────┘
```

### 8.2 管理后台布局

```
┌──────┬──────────────────────────────────────┐
│ Side  │  面包屑导航                          │
│ Bar   ├──────────────────────────────────────┤
│       │                                      │
│ 概览   │         <router-view>               │
│ 电影   │                                      │
│ 影厅   │                                      │
│ 场次   │                                      │
│ 订单   │                                      │
│ 统计   │                                      │
└──────┴──────────────────────────────────────┘
```

### 8.3 关键页面描述

**首页** — 顶部导航 + 分类标签（热映/即将上映/各分类）+ 电影卡片网格 + 分页

**电影详情页** — 左侧海报 + 右侧信息（片名/评分/时长/类型/简介）+ 下方场次列表（影厅/时间/票价/余票/购票按钮）

**下单确认页** — 订单信息确认（电影/场次/单价）+ 数量步进器 + 15分钟倒计时 + 合计价格 + 确认支付按钮

**我的订单页** — 状态 Tab 切换（全部/待支付/已支付/已取消）+ 订单卡片列表 + 分页

**统计页** — 顶部 4 个概览卡片 + 下方左侧饼图（类型统计）+ 右侧折线图（每日票房）+ 底部横向柱状图（电影销量排行）

---

## 九、技术选型

| 层 | 技术 | 版本 |
|----|------|------|
| 后端框架 | Django + DRF | 3.2+ / 3.12+ |
| 数据库 | MySQL | 8.0 |
| 认证 | djangorestframework-simplejwt | latest |
| 跨域 | django-cors-headers | latest |
| 图片处理 | Pillow | latest |
| 定时任务 | django-crontab 或 APScheduler | latest |
| 前端框架 | Vue 2 | 2.x |
| UI 组件库 | Element UI | 2.x |
| 图表 | ECharts (echarts npm) | 5.x |
| HTTP 客户端 | Axios | latest |
| 状态管理 | Vuex | 3.x |
| 路由 | Vue Router | 3.x |
| 头像裁剪 | vue-cropper 或 cropperjs | latest |
| 构建工具 | Vue CLI | 4.x+ |

---

## 十、项目目录结构

```
movie-platform/
├── backend/                      # Django 项目
│   ├── movie_platform/           # 项目配置
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── wsgi.py
│   ├── apps/
│   │   ├── users/                # 用户模块
│   │   │   ├── models.py         # User 扩展
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   └── urls.py
│   │   ├── movies/               # 电影模块
│   │   │   ├── models.py         # Category, Movie, Hall, Session
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   └── urls.py
│   │   ├── orders/               # 订单模块
│   │   │   ├── models.py         # Order
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   └── management/
│   │   │       └── commands/
│   │   │           └── cancel_expired_orders.py
│   │   └── stats/                # 统计模块
│   │       ├── views.py
│   │       └── urls.py
│   ├── media/
│   │   ├── avatars/
│   │   └── posters/
│   ├── manage.py
│   └── requirements.txt
├── frontend/                      # Vue2 项目
│   ├── public/
│   ├── src/
│   │   ├── api/                   # Axios 封装 + 接口定义
│   │   │   ├── index.js           # Axios 实例 + 拦截器
│   │   │   ├── auth.js
│   │   │   ├── movies.js
│   │   │   ├── orders.js
│   │   │   └── admin.js
│   │   ├── views/                 # 页面组件
│   │   │   ├── Home.vue
│   │   │   ├── MovieDetail.vue
│   │   │   ├── OrderConfirm.vue
│   │   │   ├── MyOrders.vue
│   │   │   ├── Profile.vue
│   │   │   ├── Login.vue
│   │   │   └── admin/
│   │   │       ├── Dashboard.vue
│   │   │       ├── MovieManage.vue
│   │   │       ├── HallManage.vue
│   │   │       ├── SessionManage.vue
│   │   │       ├── OrderManage.vue
│   │   │       └── Stats.vue
│   │   ├── components/            # 通用组件
│   │   │   ├── Navbar.vue
│   │   │   ├── MovieCard.vue
│   │   │   ├── Countdown.vue      # 15分钟倒计时
│   │   │   ├── AvatarUpload.vue
│   │   │   └── charts/
│   │   │       ├── PieChart.vue
│   │   │       ├── LineChart.vue
│   │   │       └── BarChart.vue
│   │   ├── store/                 # Vuex
│   │   │   ├── index.js
│   │   │   └── modules/
│   │   │       ├── user.js
│   │   │       └── cart.js
│   │   ├── router/
│   │   │   └── index.js
│   │   ├── utils/
│   │   │   └── auth.js            # token 工具函数
│   │   ├── App.vue
│   │   └── main.js
│   ├── package.json
│   └── vue.config.js              # 代理配置
└── docs/
    └── movie-platform-design.md   # 本文档
```

---

## 十一、安全与边界处理

- 密码使用 Django 内置 PBKDF2 加密
- JWT token 过期时间：access 30min, refresh 7d
- 前端 Axios 拦截器自动注入 Authorization header，401 时自动刷新 token
- 下单时使用 `select_for_update` 行级锁防止超卖
- 文件上传限制：头像 ≤2MB，海报 ≤5MB，仅允许 jpg/png
- CORS 白名单仅允许前端域名
- 管理员 API 通过 `IsAdminUser` 权限类保护

---

## 十二、开发顺序建议

| 阶段 | 内容 |
|------|------|
| 1 | 后端项目初始化 + User 模块 + JWT 认证 |
| 2 | 后端电影/影厅/场次 CRUD |
| 3 | 后端订单模块 + 模拟支付 + 超时取消 |
| 4 | 后端统计 API |
| 5 | 前端项目初始化 + 路由 + 布局 |
| 6 | 前端登录/注册 + 首页 + 电影详情 |
| 7 | 前端下单 + 订单列表 + 个人中心 |
| 8 | 前端管理后台 + ECharts 图表 |
| 9 | 联调测试 + 细节打磨 |
