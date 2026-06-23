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
    # Vue SPA 入口 — 所有非 API/非 Admin 路由返回 index.html
    re_path(r'^.*$', TemplateView.as_view(template_name='index.html')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
