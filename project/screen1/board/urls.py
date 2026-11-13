from django.urls import path, include
from.import views

app_name = 'board'
urlpatterns = [
    # 전체 영화 12개 목록 연결
    path('list/', views.mlist, name='mlist'),

    # 장르별 영화 3개 목록 연결
    path('action/', views.action, name='action'),
    path('drama/', views.drama, name='drama'),
    path('thriller/', views.thriller, name='thriller'),
    path('comedy/', views.comedy, name='comedy'),

    # 영화 번호를 전달하여 상세 페이지 연결
    path('view/<int:mno>/', views.mview, name='mview'),
]