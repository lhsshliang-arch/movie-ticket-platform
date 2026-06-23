from django.urls import path
from .views import (
    OverviewView,
    CategoryOrdersView,
    DailyBoxOfficeView,
    MovieRankingView,
)

urlpatterns = [
    path('overview/', OverviewView.as_view()),
    path('category-orders/', CategoryOrdersView.as_view()),
    path('daily-box-office/', DailyBoxOfficeView.as_view()),
    path('movie-ranking/', MovieRankingView.as_view()),
]
