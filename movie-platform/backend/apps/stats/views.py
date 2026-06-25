from rest_framework.views import APIView
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from django.db.models import Sum, Count
from django.utils import timezone
from datetime import datetime, timedelta

from apps.orders.models import Order
from apps.movies.models import Movie, Session


class BaseStatsView(APIView):
    """统计基类：管理员权限 + 日期参数解析"""
    permission_classes = [IsAdminUser]

    def _parse_date(self, date_str):
        if not date_str:
            return None
        try:
            return datetime.strptime(date_str, '%Y-%m-%d').date()
        except ValueError:
            return None

    def _get_date_range(self, request):
        """不传 start/end 则默认最近90天，返回时区感知的 datetime"""
        end = self._parse_date(request.query_params.get('end'))
        start = self._parse_date(request.query_params.get('start'))
        if not end:
            end = timezone.now().date()
        if not start:
            start = end - timedelta(days=89)
        # 转为时区感知的 datetime 范围（避免 MySQL 时区表缺失导致 __date 查询失败）
        tz = timezone.get_current_timezone()
        start_dt = timezone.make_aware(datetime.combine(start, datetime.min.time()), tz)
        end_dt = timezone.make_aware(datetime.combine(end, datetime.max.time()), tz)
        return start_dt, end_dt


class OverviewView(BaseStatsView):
    """概览卡片：累计订单、累计票房、在映电影、总场次"""

    def get(self, request):
        order_count = Order.objects.count()
        box_office = Order.objects.filter(status='paid').aggregate(
            total=Sum('total_price')
        )['total'] or 0
        active_movie_count = Movie.objects.filter(status='hot').count()
        session_count = Session.objects.count()

        return Response({
            'order_count': order_count,
            'box_office': float(box_office),
            'session_count': session_count,
            'active_movie_count': active_movie_count,
        })


class CategoryOrdersView(BaseStatsView):
    """各分类订单统计（饼图）"""

    def get(self, request):
        start_dt, end_dt = self._get_date_range(request)

        data = Order.objects.filter(
            status='paid',
            paid_at__gte=start_dt,
            paid_at__lte=end_dt,
        ).values('session__movie__categories__name').annotate(
            value=Count('id'),
        ).order_by('-value')

        return Response([
            {'name': item['session__movie__categories__name'] or '未分类', 'value': item['value']}
            for item in data
        ])


class DailyBoxOfficeView(BaseStatsView):
    """每日票房趋势（折线图）"""

    def get(self, request):
        start_dt, end_dt = self._get_date_range(request)

        # 用 raw queryset 手动分组，因为 MySQL 时区表缺失 __date 不可用
        data = Order.objects.filter(
            status='paid',
            paid_at__gte=start_dt,
            paid_at__lte=end_dt,
        ).extra(
            select={'paid_date': 'DATE(paid_at)'}
        ).values('paid_date').annotate(
            value=Sum('total_price'),
        ).order_by('paid_date')

        return Response([
            {'date': str(item['paid_date']), 'value': float(item['value'])}
            for item in data
        ])


class MovieRankingView(BaseStatsView):
    """热映电影销量排行（横向柱状图）"""

    def get(self, request):
        try:
            limit = int(request.query_params.get('limit', 10))
        except ValueError:
            limit = 10

        data = Order.objects.filter(
            status='paid',
            session__movie__status='hot',
        ).values('session__movie__name').annotate(
            value=Sum('quantity'),
        ).order_by('-value')[:limit]

        return Response([
            {'name': item['session__movie__name'], 'value': item['value']}
            for item in data
        ])
