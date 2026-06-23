from rest_framework.generics import (
    ListAPIView, ListCreateAPIView, CreateAPIView,
    RetrieveAPIView, UpdateAPIView, DestroyAPIView,
)
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.filters import SearchFilter, OrderingFilter
from django.shortcuts import get_object_or_404
from collections import defaultdict

from apps.orders.models import Order
from .models import Category, Movie, Cinema, Hall, Session, BrowseHistory, WantRecord
from .serializers import (
    CategorySerializer,
    MovieReadSerializer, MovieWriteSerializer,
    CinemaSerializer, HallSerializer,
    SessionReadSerializer, SessionWriteSerializer,
)


class MovieListAPIView(ListAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieReadSerializer
    filter_backends = [SearchFilter, OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['score', 'release_time', 'created_time']

    def get_queryset(self):
        qs = Movie.objects.all().prefetch_related('categories')
        status = self.request.query_params.get('status')
        category = self.request.query_params.get('category')
        if status:
            qs = qs.filter(status=status)
        if category:
            qs = qs.filter(categories__id=category)
        return qs


class MovieDetailView(RetrieveAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieReadSerializer

    def retrieve(self, request, *args, **kwargs):
        response = super().retrieve(request, *args, **kwargs)
        # 已登录用户自动记录浏览历史
        if request.user.is_authenticated:
            movie = self.get_object()
            BrowseHistory.objects.create(user=request.user, movie=movie)
        return response


class MovieSessionListView(ListAPIView):
    """某电影的全部场次"""
    serializer_class = SessionReadSerializer

    def get_queryset(self):
        movie_id = self.kwargs['pk']
        return Session.objects.filter(movie_id=movie_id) \
            .select_related('hall__cinema', 'movie') \
            .prefetch_related('movie__categories') \
            .order_by('start_time')


# ========== 电影 - 管理员端 ==========

class AdminMovieCreateView(CreateAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieWriteSerializer
    permission_classes = [IsAdminUser]


class AdminMovieUpdateView(UpdateAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieWriteSerializer
    permission_classes = [IsAdminUser]


class AdminMovieDeleteView(DestroyAPIView):
    queryset = Movie.objects.all()
    serializer_class = MovieWriteSerializer
    permission_classes = [IsAdminUser]


# ========== 影厅 - 管理员端 ==========

class HallListCreateView(ListCreateAPIView):
    queryset = Hall.objects.all()
    serializer_class = HallSerializer

    def get_permissions(self):
        if self.request.method == 'GET':
            return []
        return [IsAdminUser()]


class HallDetailView(RetrieveAPIView):
    queryset = Hall.objects.all()
    serializer_class = HallSerializer


class HallUpdateView(UpdateAPIView):
    queryset = Hall.objects.all()
    serializer_class = HallSerializer
    permission_classes = [IsAdminUser]


class HallDeleteView(DestroyAPIView):
    queryset = Hall.objects.all()
    serializer_class = HallSerializer
    permission_classes = [IsAdminUser]


# ========== 场次 - 管理员端 ==========

class SessionListCreateView(ListCreateAPIView):
    queryset = Session.objects.all()

    def get_permissions(self):
        if self.request.method == 'GET':
            return []
        return [IsAdminUser()]

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return SessionWriteSerializer
        return SessionReadSerializer


class SessionDetailView(RetrieveAPIView):
    queryset = Session.objects.all()
    serializer_class = SessionReadSerializer


class SessionUpdateView(UpdateAPIView):
    queryset = Session.objects.all()
    serializer_class = SessionWriteSerializer
    permission_classes = [IsAdminUser]


class SessionDeleteView(DestroyAPIView):
    queryset = Session.objects.all()
    serializer_class = SessionWriteSerializer
    permission_classes = [IsAdminUser]


# ========== 公共数据 ==========

class CategoryListView(ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = []


# ========== 想看 ==========

class ToggleWantView(APIView):
    """切换想看状态：已想看则取消，未想看则添加"""
    permission_classes = [IsAuthenticated]

    def post(self, request, pk):
        movie = get_object_or_404(Movie, pk=pk)
        user = request.user
        if user.want_to_see.filter(pk=movie.pk).exists():
            user.want_to_see.remove(movie)
            return Response({'wanted': False})
        else:
            user.want_to_see.add(movie)
            return Response({'wanted': True})


class WantListView(ListAPIView):
    """我看过的电影列表"""
    permission_classes = [IsAuthenticated]
    serializer_class = MovieReadSerializer

    def get_queryset(self):
        return self.request.user.want_to_see.all().prefetch_related('categories')


# ========== 推荐 ==========

def _split_names(value):
    """分割 country / language 中的多值字段，如 '中国大陆 / 中国香港'"""
    if not value:
        return set()
    parts = value.replace('、', '/').replace(';', '/').split('/')
    return {p.strip() for p in parts if p.strip()}


class RecommendView(APIView):
    """基于多维度统计的个性化推荐（分类 + 国家 + 语言）"""

    def get(self, request):
        user = request.user

        if not user.is_authenticated:
            movies = Movie.objects.filter(status='hot').order_by('-score')[:4]
            serializer = MovieReadSerializer(movies, many=True)
            return Response(serializer.data)

        cat_weight = defaultdict(float)
        country_weight = defaultdict(float)
        lang_weight = defaultdict(float)
        interacted_ids = set()

        def add_interaction(movie, w):
            interacted_ids.add(movie.id)
            for cat in movie.categories.all():
                cat_weight[cat.id] += w
            for c in _split_names(movie.country):
                country_weight[c] += w
            for l in _split_names(movie.language):
                lang_weight[l] += w

        # 已支付订单 - 权重 3
        for order in Order.objects.filter(user=user, status='paid').select_related('session__movie'):
            add_interaction(order.session.movie, 3)

        # 想看记录 - 权重 2
        for wr in WantRecord.objects.filter(user=user).select_related('movie'):
            add_interaction(wr.movie, 2)

        # 浏览记录 - 权重 1
        for br in BrowseHistory.objects.filter(user=user).select_related('movie'):
            add_interaction(br.movie, 1)

        if not cat_weight and not country_weight:
            movies = Movie.objects.filter(status='hot').order_by('-score')[:4]
        else:
            max_cat = max(cat_weight.values()) if cat_weight else 1
            max_country = max(country_weight.values()) if country_weight else 1
            max_lang = max(lang_weight.values()) if lang_weight else 1

            # 自适应系数：用户偏好分类少 → 高系数(允许探索)；分类多 → 低系数(聚焦偏好)
            num_cats = len([w for w in cat_weight.values() if w > 0])
            boost_floor = 0.6 if num_cats <= 2 else 0.2

            hot_movies = Movie.objects.filter(status='hot').prefetch_related('categories')
            movie_scores = {}

            for movie in hot_movies:
                if movie.id in interacted_ids:
                    continue

                # 分类匹配 — 幂次归一化，压制弱信号
                cat_raw = sum(cat_weight.get(cat.id, 0) for cat in movie.categories.all())
                cat_ratio = cat_raw / max_cat
                cat_score = cat_ratio ** 2 * 10

                # 国家/语言加分按分类匹配度缩放（带自适应下限）
                boost = max(cat_ratio, boost_floor)

                movie_countries = _split_names(movie.country)
                country_score = 0
                if movie_countries and country_weight:
                    country_score = max(
                        (country_weight.get(c, 0) for c in movie_countries),
                        default=0
                    )
                country_score = (country_score / max_country) * 8 * boost

                movie_langs = _split_names(movie.language)
                lang_score = 0
                if movie_langs and lang_weight:
                    lang_score = max(
                        (lang_weight.get(l, 0) for l in movie_langs),
                        default=0
                    )
                lang_score = (lang_score / max_lang) * 4 * boost

                movie_scores[movie.id] = cat_score + country_score + lang_score + movie.score

            sorted_ids = sorted(movie_scores, key=movie_scores.get, reverse=True)[:4]
            movies = list(Movie.objects.filter(id__in=sorted_ids))
            movies.sort(key=lambda m: sorted_ids.index(m.id))

        serializer = MovieReadSerializer(movies, many=True)
        return Response(serializer.data)


# ========== 影院 - 管理员端 ==========

class CinemaListCreateView(ListCreateAPIView):
    queryset = Cinema.objects.all()
    serializer_class = CinemaSerializer

    def get_permissions(self):
        if self.request.method == 'GET':
            return []
        return [IsAdminUser()]


class CinemaUpdateView(UpdateAPIView):
    queryset = Cinema.objects.all()
    serializer_class = CinemaSerializer
    permission_classes = [IsAdminUser]


class CinemaDeleteView(DestroyAPIView):
    queryset = Cinema.objects.all()
    serializer_class = CinemaSerializer
    permission_classes = [IsAdminUser]
