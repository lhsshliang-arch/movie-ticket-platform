from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):

    phone = models.CharField(
        max_length=11,
        blank=True,
        null=True
    )

    avatar = models.ImageField(
        upload_to='avatars/',
        blank=True,
        null=True
    )

    want_to_see = models.ManyToManyField(
        'movies.Movie',
        through='movies.WantRecord',
        related_name='interested_users',
        blank=True
    )

    def __str__(self):
        return self.username