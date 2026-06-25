import random
import io
import uuid
from PIL import Image, ImageDraw, ImageFont
from rest_framework.generics import CreateAPIView, UpdateAPIView
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from django.core.cache import cache
from django.http import HttpResponse

from .models import User
from .serializers import RegisterSerializer, UserSerializer


class CaptchaView(APIView):
    """生成图形验证码"""

    def get(self, request):
        key = request.query_params.get('key', uuid.uuid4().hex)
        code = ''.join(random.choices('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', k=4))
        cache.set(f'captcha_{key}', code, 300)

        w, h = 160, 60
        img = Image.new('RGB', (w, h), color=(240, 245, 250))
        draw = ImageDraw.Draw(img)

        # 背景噪点
        for _ in range(100):
            x, y = random.randint(0, w - 1), random.randint(0, h - 1)
            c = random.randint(150, 220)
            draw.point((x, y), fill=(c, c, c))

        # 干扰线
        for _ in range(3):
            x1 = random.randint(0, w // 3)
            y1 = random.randint(0, h)
            x2 = random.randint(w * 2 // 3, w)
            y2 = random.randint(0, h)
            draw.line((x1, y1, x2, y2), fill=(random.randint(100, 180), random.randint(100, 180), random.randint(100, 180)), width=2)

        # 字体（Windows + Linux 兼容）
        font_paths = [
            'consolab.ttf', 'comicbd.ttf', 'impact.ttf', 'courbd.ttf',           # Windows
            '/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf',                        # CentOS
            '/usr/share/fonts/liberation/LiberationSans-Bold.ttf',                # CentOS 备用
            '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',                   # Debian/Ubuntu
            '/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf',   # Debian 备用
        ]
        font = None
        for fp in font_paths:
            try:
                font = ImageFont.truetype(fp, 36)
                break
            except Exception:
                continue
        if font is None:
            font = ImageFont.load_default()

        # 画字符（每个字符随机旋转和偏移）
        for i, ch in enumerate(code):
            char_img = Image.new('RGBA', (40, 50), (0, 0, 0, 0))
            char_draw = ImageDraw.Draw(char_img)
            r = random.randint(0, 80)
            g = random.randint(0, 80)
            b = random.randint(0, 180)
            char_draw.text((2, 0), ch, fill=(r, g, b), font=font)

            # 旋转
            angle = random.randint(-30, 30)
            char_img = char_img.rotate(angle, expand=False, fillcolor=(0, 0, 0, 0))

            # 位置偏移
            x = 10 + i * 36 + random.randint(-4, 4)
            y = random.randint(2, 10)
            img.paste(char_img, (x, y), char_img)

        buf = io.BytesIO()
        img.save(buf, 'PNG')
        return HttpResponse(buf.getvalue(), content_type='image/png')


class RegisterView(CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer

    def create(self, request, *args, **kwargs):
        # 验证验证码
        captcha_key = request.data.get('captcha_key')
        captcha_code = request.data.get('captcha_code', '').upper()
        cached = cache.get(f'captcha_{captcha_key}') if captcha_key else None
        if cached is None:
            return Response({'captcha_code': '验证码已过期，请刷新重试'}, status=400)
        if cached != captcha_code:
            return Response({'captcha_code': '验证码错误'}, status=400)
        cache.delete(f'captcha_{captcha_key}')  # 一次性使用

        # 调用父类创建用户
        response = super().create(request, *args, **kwargs)
        user = User.objects.get(username=request.data['username'])
        # 生成 JWT
        refresh = RefreshToken.for_user(user)
        response.data['access'] = str(refresh.access_token)
        response.data['refresh'] = str(refresh)
        return response


class ProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = UserSerializer(request.user)
        return Response(serializer.data)

    def patch(self, request):
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class ChangePasswordView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        old_password = request.data.get('old_password')
        new_password = request.data.get('new_password')

        if not old_password or not new_password:
            return Response({'error': '请提供旧密码和新密码'}, status=400)
        if len(new_password) < 6:
            return Response({'error': '新密码至少6位'}, status=400)
        if not request.user.check_password(old_password):
            return Response({'error': '旧密码错误'}, status=400)

        request.user.set_password(new_password)
        request.user.save()
        return Response({'message': '密码修改成功'})
