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
        """不传 start/end 则默认最近7天"""
        end = self._parse_date(request.query_params.get('end'))
        start = self._parse_date(request.query_params.get('start'))
        if not end:
            end = timezone.now().date()
        if not start:
            start = end - timedelta(days=6)
        return start, end


class OverviewView(BaseStatsView):
    """今日概览卡片：订单数、票房、场次、在映电影"""

    def get(self, request):
        today = timezone.now().date()

        order_count = Order.objects.filter(created_at__date=today).count()

        box_office = Order.objects.filter(
            status='paid', paid_at__date=today,
        ).aggregate(total=Sum('total_price'))['total'] or 0

        session_count = Session.objects.filter(start_time__date=today).count()
        active_movie_count = Movie.objects.filter(status='hot').count()

        return Response({
            'order_count': order_count,
            'box_office': float(box_office),
            'session_count': session_count,
            'active_movie_count': active_movie_count,
        })


class CategoryOrdersView(BaseStatsView):
    """各分类订单统计（饼图）"""

    def get(self, request):
        start, end = self._get_date_range(request)

        data = Order.objects.filter(
            status='paid',
            paid_at__date__gte=start,
            paid_at__date__lte=end,
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
        start, end = self._get_date_range(request)

        data = Order.objects.filter(
            status='paid',
            paid_at__date__gte=start,
            paid_at__date__lte=end,
        ).values('paid_at__date').annotate(
            value=Sum('total_price'),
        ).order_by('paid_at__date')

        return Response([
            {'date': str(item['paid_at__date']), 'value': float(item['value'])}
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
