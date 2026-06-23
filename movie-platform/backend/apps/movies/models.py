from django.db import models


class Category(models.Model):

    name = models.CharField(
        max_length=50,
        unique=True
    )

    def __str__(self):
        return self.name




class Movie(models.Model):

    STATUS_CHOICES = (
        ('hot', '热映'),
        ('coming', '即将上映'),
        ('offline', '已下架'),
    )

    name = models.CharField(
        max_length=100
    )

    description = models.TextField()

    poster = models.ImageField(
        upload_to='movies/'
    )

    score = models.FloatField(
        default=0
    )

    duration = models.IntegerField()

    release_time = models.DateField()

    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='coming'
    )

    categories = models.ManyToManyField(
        Category,
        related_name='movies'
    )

    country = models.CharField(max_length=50, default='')
    language = models.CharField(max_length=50, default='')

    created_time = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.name

class Cinema(models.Model):
    name = models.CharField(max_length=100)
    address = models.CharField(max_length=200)
    phone = models.CharField(max_length=20)

    def __str__(self):
        return self.name


class Hall(models.Model):
    cinema = models.ForeignKey(
        Cinema,
        on_delete=models.CASCADE,
        related_name='halls',
        null=True,
        blank=True
    )
    name = models.CharField(max_length=50, default='')
    capacity = models.IntegerField()
    description = models.CharField(
        max_length=200,
        blank=True,
        null=True
    )

    def __str__(self):
        if self.cinema:
            return f'{self.cinema.name} - {self.name}'
        return self.name or f'Hall #{self.id}'

class Session(models.Model):
    movie = models.ForeignKey(
        Movie,
        on_delete=models.CASCADE,
        related_name='sessions'
    )
    hall = models.ForeignKey(
        Hall,
        on_delete=models.CASCADE,
        related_name='sessions'
    )
    start_time = models.DateTimeField()
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2
    )
    total_tickets = models.IntegerField()
    sold_tickets = models.IntegerField(default=0)
    class Meta:
        unique_together = ('movie', 'hall', 'start_time')

    def __str__(self):
        return f'{self.movie.name} {self.hall.name}{self.start_time}'


class WantRecord(models.Model):
    """想看记录 - 带时间戳的 through 模型"""
    user = models.ForeignKey(
        'users.User',
        on_delete=models.CASCADE,
        related_name='want_records'
    )
    movie = models.ForeignKey(
        Movie,
        on_delete=models.CASCADE,
        related_name='want_records'
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'movie')

    def __str__(self):
        return f'{self.user.username} → {self.movie.name}'


class BrowseHistory(models.Model):
    """浏览记录 - 后台记录，前端不展示"""
    user = models.ForeignKey(
        'users.User',
        on_delete=models.CASCADE,
        related_name='browse_history'
    )
    movie = models.ForeignKey(
        Movie,
        on_delete=models.CASCADE,
        related_name='browse_history'
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.user.username} 浏览 {self.movie.name} @ {self.created_at}'