from rest_framework import serializers
from django.db import transaction
from .models import Order
from apps.movies.models import Session


class OrderSerializer(serializers.ModelSerializer):
    """读取用 - 嵌套场次和电影信息"""
    from apps.movies.serializers import SessionReadSerializer
    session_info = SessionReadSerializer(source='session', read_only=True)
    username = serializers.SerializerMethodField()

    def get_username(self, obj):
        try:
            return obj.user.username
        except Exception:
            return '已删除用户'

    class Meta:
        model = Order
        fields = [
            'id', 'order_no', 'user', 'username', 'session', 'session_info',
            'quantity', 'total_price', 'status',
            'created_at', 'paid_at', 'cancelled_at',
        ]
        read_only_fields = ['id', 'order_no', 'user', 'username', 'created_at', 'paid_at', 'cancelled_at']


class CreateOrderSerializer(serializers.ModelSerializer):
    """创建订单 - 只需传场次ID和数量，返回完整订单信息"""

    class Meta:
        model = Order
        fields = ['id', 'order_no', 'session', 'quantity', 'total_price', 'status', 'created_at']
        read_only_fields = ['id', 'order_no', 'total_price', 'status', 'created_at']

    def validate_quantity(self, value):
        if value <= 0:
            raise serializers.ValidationError('购买数量必须大于0')
        return value

    def validate(self, attrs):
        session = attrs['session']
        quantity = attrs['quantity']

        # 计算剩余票数
        remaining = session.total_tickets - session.sold_tickets
        if remaining < quantity:
            raise serializers.ValidationError(
                f'余票不足：剩余 {remaining} 张，您需要 {quantity} 张'
            )
        return attrs

    @transaction.atomic
    def create(self, validated_data):
        session = validated_data['session']
        quantity = validated_data['quantity']

        # select_for_update 行级锁，防止并发超卖
        session = Session.objects.select_for_update().get(pk=session.pk)

        remaining = session.total_tickets - session.sold_tickets
        if remaining < quantity:
            raise serializers.ValidationError('余票不足')

        # 扣减票数
        session.sold_tickets += quantity
        session.save(update_fields=['sold_tickets'])

        # 计算总价
        total_price = session.price * quantity

        order = Order.objects.create(
            user=self.context['request'].user,
            session=session,
            quantity=quantity,
            total_price=total_price,
        )
        return order
