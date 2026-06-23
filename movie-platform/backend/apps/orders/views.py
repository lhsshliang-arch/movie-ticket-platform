from rest_framework.generics import (
    ListCreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView
)
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework.response import Response
from rest_framework import status
from rest_framework.filters import OrderingFilter
from django.utils import timezone
from django.db import transaction

from .models import Order
from .serializers import OrderSerializer, CreateOrderSerializer


class OrderListCreateView(ListCreateAPIView):
    """我的订单列表 + 创建订单"""
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        qs = Order.objects.filter(user=self.request.user) \
            .select_related('session__movie', 'session__hall__cinema')
        status_param = self.request.query_params.get('status')
        if status_param:
            qs = qs.filter(status=status_param)
        return qs.order_by('-created_at')

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return CreateOrderSerializer
        return OrderSerializer


class OrderDetailView(RetrieveAPIView):
    """订单详情"""
    permission_classes = [IsAuthenticated]
    serializer_class = OrderSerializer

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user)


class PayOrderView(UpdateAPIView):
    """模拟支付 - 将订单状态改为已支付"""
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user, status='pending')

    def partial_update(self, request, *args, **kwargs):
        order = self.get_object()
        order.status = 'paid'
        order.paid_at = timezone.now()
        order.save(update_fields=['status', 'paid_at'])
        return Response(OrderSerializer(order).data)


class CancelOrderView(UpdateAPIView):
    """取消订单 - 退还票数（带事务和行锁）"""
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user, status='pending') \
            .select_related('session')

    @transaction.atomic
    def partial_update(self, request, *args, **kwargs):
        order = self.get_object()
        order.status = 'cancelled'
        order.cancelled_at = timezone.now()
        order.save(update_fields=['status', 'cancelled_at'])

        # 行级锁防竞态
        session = order.session.__class__.objects.select_for_update().get(pk=order.session_id)
        session.sold_tickets -= order.quantity
        if session.sold_tickets < 0:
            session.sold_tickets = 0
        session.save(update_fields=['sold_tickets'])

        return Response(OrderSerializer(order).data)


class AdminOrderListView(ListAPIView):
    """管理员 - 查看所有订单"""
    permission_classes = [IsAdminUser]
    serializer_class = OrderSerializer
    filter_backends = [OrderingFilter]
    ordering_fields = ['created_at', 'total_price', 'status']

    def get_queryset(self):
        qs = Order.objects.select_related('user', 'session__movie', 'session__hall__cinema')
        status_param = self.request.query_params.get('status')
        if status_param:
            qs = qs.filter(status=status_param)
        return qs.order_by('-created_at')
