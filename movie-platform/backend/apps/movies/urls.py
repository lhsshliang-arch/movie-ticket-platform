from django.urls import path
from .views import (
      MovieListAPIView,
      MovieDetailView,
      MovieSessionListView,
      AdminMovieCreateView,
      AdminMovieUpdateView,
      AdminMovieDeleteView,
      HallListCreateView,
      HallDetailView,
      HallUpdateView,
      HallDeleteView,
      SessionListCreateView,
      SessionDetailView,
      SessionUpdateView,
      SessionDeleteView,
      CategoryListView,
      ToggleWantView,
      WantListView,
      RecommendView,
      CinemaListCreateView,
      CinemaUpdateView,
      CinemaDeleteView,
  )

urlpatterns = [
      # 用户端
      path('', MovieListAPIView.as_view()),
      path('recommend/', RecommendView.as_view()),
      path('<int:pk>/', MovieDetailView.as_view()),
      path('<int:pk>/sessions/', MovieSessionListView.as_view()),
      path('sessions/<int:pk>/', SessionDetailView.as_view()),

      # 管理员 - 电影
      path('admin/create/', AdminMovieCreateView.as_view()),
      path('admin/update/<int:pk>/', AdminMovieUpdateView.as_view()),
      path('admin/delete/<int:pk>/', AdminMovieDeleteView.as_view()),

      # 管理员 - 影厅
      path('admin/halls/', HallListCreateView.as_view()),
      path('admin/halls/<int:pk>/', HallDetailView.as_view()),
      path('admin/halls/update/<int:pk>/', HallUpdateView.as_view()),
      path('admin/halls/delete/<int:pk>/', HallDeleteView.as_view()),

      # 管理员 - 场次
      path('admin/sessions/', SessionListCreateView.as_view()),
      path('admin/sessions/<int:pk>/', SessionDetailView.as_view()),
      path('admin/sessions/update/<int:pk>/', SessionUpdateView.as_view()),
      path('admin/sessions/delete/<int:pk>/', SessionDeleteView.as_view()),

      # 管理员 - 影院
      path('admin/cinemas/', CinemaListCreateView.as_view()),
      path('admin/cinemas/update/<int:pk>/', CinemaUpdateView.as_view()),
      path('admin/cinemas/delete/<int:pk>/', CinemaDeleteView.as_view()),

      # 想看
      path('wanted/', WantListView.as_view()),
      path('<int:pk>/want/', ToggleWantView.as_view()),

      # 公共数据
      path('categories/', CategoryListView.as_view()),
  ]