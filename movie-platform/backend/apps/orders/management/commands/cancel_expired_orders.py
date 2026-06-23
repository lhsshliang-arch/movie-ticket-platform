from django.core.management.base import BaseCommand
from django.utils import timezone
from datetime import timedelta

from apps.orders.models import Order


class Command(BaseCommand):
    help = '取消超过15分钟未支付的订单，并退还票数'

    def handle(self, *args, **options):
        deadline = timezone.now() - timedelta(minutes=15)
        expired_orders = Order.objects.filter(
            status='pending',
            created_at__lt=deadline,
        )

        count = 0
        for order in expired_orders:
            order.status = 'cancelled'
            order.cancelled_at = timezone.now()
            order.save(update_fields=['status', 'cancelled_at'])

            # 退还票数
            session = order.session
            session.sold_tickets = max(session.sold_tickets - order.quantity, 0)
            session.save(update_fields=['sold_tickets'])

            count += 1

        self.stdout.write(
            self.style.SUCCESS(f'成功取消 {count} 个过期订单')
        )
