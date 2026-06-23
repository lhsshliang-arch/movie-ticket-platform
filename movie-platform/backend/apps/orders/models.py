import uuid
from django.db import models
from django.conf import settings


class Order(models.Model):
    STATUS_CHOICES = (
        ('pending', '待支付'),
        ('paid', '已支付'),
        ('cancelled', '已取消'),
    )

    order_no = models.CharField(max_length=20, unique=True)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='orders'
    )
    session = models.ForeignKey(
        'movies.Session',
        on_delete=models.CASCADE,
        related_name='orders'
    )
    quantity = models.IntegerField()
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='pending'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    paid_at = models.DateTimeField(null=True, blank=True)
    cancelled_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        try:
            return f'{self.order_no} - {self.user.username}'
        except Exception:
            return self.order_no

    def save(self, *args, **kwargs):
        # 新建时自动生成订单号
        if not self.order_no:
            self.order_no = uuid.uuid4().hex[:20].upper()
        super().save(*args, **kwargs)
