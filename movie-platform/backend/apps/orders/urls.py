from django.urls import path
from .views import (
    OrderListCreateView,
    OrderDetailView,
    PayOrderView,
    CancelOrderView,
    AdminOrderListView,
)

urlpatterns = [
    path('', OrderListCreateView.as_view()),
    path('<int:pk>/', OrderDetailView.as_view()),
    path('<int:pk>/pay/', PayOrderView.as_view()),
    path('<int:pk>/cancel/', CancelOrderView.as_view()),
    path('all/', AdminOrderListView.as_view()),
]
