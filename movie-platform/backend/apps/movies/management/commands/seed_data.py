import random
import uuid
from datetime import date, datetime, timedelta
from decimal import Decimal
from django.core.management.base import BaseCommand
from django.utils import timezone
from django.utils.timezone import make_aware
from apps.movies.models import Movie, Hall, Session
from apps.orders.models import Order
from apps.users.models import User


class Command(BaseCommand):
    help = '为已有电影补充场次和订单（不创建影院/分类/电影）'

    def handle(self, *args, **options):
        halls = list(Hall.objects.all())
        if not halls:
            self.stdout.write(self.style.ERROR('没有影厅，请先手动添加'))
            return

        movies = list(Movie.objects.all())
        if not movies:
            self.stdout.write(self.style.ERROR('没有电影，请先手动添加'))
            return

        self.stdout.write(f'影厅: {len(halls)}  电影: {len(movies)}')

        # ===== 场次 =====
        session_count = 0
        today = date.today()
        for movie in movies:
            if movie.status == 'hot':
                for offset in range(-2, 5):
                    target_date = today + timedelta(days=offset)
                    for _ in range(random.randint(1, 3)):
                        hall = random.choice(halls)
                        hour = random.randint(9, 22)
                        minute = random.choice([0, 15, 30, 45])
                        dt = make_aware(datetime(target_date.year, target_date.month, target_date.day, hour, minute))
                        if dt > timezone.now() - timedelta(hours=2):
                            price = Decimal(str(random.choice([29.9, 39.9, 49.9, 59.9, 69.9])))
                            total = hall.capacity
                            sold = random.randint(int(total * 0.3), int(total * 0.95))
                            _, created = Session.objects.get_or_create(
                                movie=movie,
                                hall=hall,
                                start_time=dt,
                                defaults={'price': price, 'total_tickets': total, 'sold_tickets': sold}
                            )
                            if created:
                                session_count += 1
            else:
                for offset in range(random.randint(5, 15), random.randint(18, 30)):
                    target_date = today + timedelta(days=offset)
                    hall = random.choice(halls)
                    dt = make_aware(datetime(target_date.year, target_date.month, target_date.day, random.choice([10, 14, 16, 19, 20])))
                    price = Decimal(str(random.choice([29.9, 39.9, 49.9])))
                    _, created = Session.objects.get_or_create(
                        movie=movie,
                        hall=hall,
                        start_time=dt,
                        defaults={'price': price, 'total_tickets': hall.capacity, 'sold_tickets': 0}
                    )
                    if created:
                        session_count += 1
        self.stdout.write(f'  新增场次: {session_count}')

        # ===== 订单 =====
        admin_user = User.objects.filter(is_staff=True).first()
        if not admin_user:
            self.stdout.write(self.style.WARNING('没有管理员用户，跳过订单'))
            return

        # 找过去的场次
        past_sessions = list(Session.objects.filter(
            start_time__lt=timezone.now()
        ).select_related('movie', 'hall')[:30])

        if not past_sessions:
            self.stdout.write('  没有过去的场次可生成订单')
            return

        order_count = 0
        for s in past_sessions[:12]:
            qty = random.randint(1, 3)
            status = random.choice(['paid', 'paid', 'paid', 'paid', 'pending', 'cancelled'])
            defaults = {
                'total_price': s.price * qty,
                'status': status,
                'order_no': uuid.uuid4().hex[:20].upper(),
            }
            if status == 'paid':
                defaults['paid_at'] = s.start_time - timedelta(hours=random.randint(1, 48))
            elif status == 'cancelled':
                defaults['cancelled_at'] = timezone.now() - timedelta(hours=random.randint(1, 5))

            _, created = Order.objects.get_or_create(
                session=s,
                user=admin_user,
                quantity=qty,
                defaults=defaults
            )
            if created:
                order_count += 1

        self.stdout.write(f'  新增订单: {order_count}（归属 {admin_user.username}）')
        self.stdout.write(self.style.SUCCESS('\n完成！'))
