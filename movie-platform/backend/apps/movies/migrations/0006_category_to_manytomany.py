from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('movies', '0005_remove_movie_actors_movie_country_movie_language'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='movie',
            name='category',
        ),
        migrations.AddField(
            model_name='movie',
            name='categories',
            field=models.ManyToManyField(
                to='movies.Category',
                related_name='movies',
            ),
        ),
    ]
