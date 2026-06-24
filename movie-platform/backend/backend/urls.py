from django.contrib import admin
from django.urls import path, include, re_path
from django.views.generic import TemplateView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('apps.users.urls')),
    path('api/movies/', include('apps.movies.urls')),
    path('api/orders/', include('apps.orders.urls')),
    path('api/admin/stats/', include('apps.stats.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Vue SPA 入口 — 所有非 API/非 Admin/非静态文件路由返回 index.html（必须在 static() 之后）
urlpatterns.append(
    re_path(r'^(?!api/|admin/|media/|static/).*$', TemplateView.as_view(template_name='index.html'))
)
