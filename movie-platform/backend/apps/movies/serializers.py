from rest_framework import serializers

from .models import (Category,
                     Movie,
                     Cinema,
                     Hall,
                     Session)

class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = Category
        fields = '__all__'


class MovieReadSerializer(serializers.ModelSerializer):

    categories = CategorySerializer(many=True, read_only=True)

    class Meta:
        model = Movie

        fields = [
            'id',
            'name',
            'description',
            'poster',
            'score',
            'duration',
            'release_time',
            'status',
            'categories',
            'country',
            'language',
            'created_time',
        ]

class MovieWriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Movie
        fields = [ 'id',
                   'name',
                   'description',
                   'poster',
                   'score',
                   'duration',
                   'release_time',
                   'status',
                   'categories',
                   'country',
                   'language',]

class CinemaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cinema
        fields = '__all__'


class HallSerializer(serializers.ModelSerializer):
    cinema_info = CinemaSerializer(source='cinema', read_only=True)

    class Meta:
        model = Hall
        fields = ['id', 'name', 'cinema', 'cinema_info', 'capacity', 'description']

class SessionReadSerializer(serializers.ModelSerializer):
    movie = MovieReadSerializer(read_only=True)
    hall = HallSerializer(read_only=True)
    remaining_tickets = serializers.SerializerMethodField()

    def get_remaining_tickets(self, obj):
        return obj.total_tickets - obj.sold_tickets

    class Meta:
        model = Session
        fields = ['id',
                  'movie',
                  'hall',
                  'start_time',
                  'price',
                  'total_tickets',
                  'sold_tickets',
                  'remaining_tickets']

class SessionWriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Session
        fields = '__all__'
