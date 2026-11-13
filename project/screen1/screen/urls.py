from django.urls import path
from . import views

urlpatterns = [
    path('genre/', views.genre, name='genre'),
    path('title/', views.title, name='title'),
    path('story/', views.story, name='story'),
    path('search/', views.search, name='search'),
]