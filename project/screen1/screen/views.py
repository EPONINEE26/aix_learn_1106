from django.shortcuts import render
from django.db.models import Q
from board.models import Board

# 장르별 검색
def genre(request):
    word = request.GET.get('word', '')
    qs = Board.objects.filter(genre=word)
    context = {'list':qs}
    return render(request, 'search.html', context)


# 영화 제목 검색
def title(request):
    word = request.GET.get('word', '')
    qs = Board.objects.filter(title__icontains=word)
    context = {'list':qs}
    return render(request, 'search.html', context)


# 영화 줄거리 검색
def story(request):
    word = request.GET.get('word', '')
    qs = Board.objects.filter(story__icontains=word)
    context = {'list':qs}
    return render(request, 'search.html', context)

# 전체 검색
def search(request):
    word = request.GET.get('word', '')
    qs = Board.objects.filter(
        Q(genre__icontains=word) |
        Q(title__icontains=word) |
        Q(story__icontains=word)
    )
    context = {'list':qs}
    return render(request, 'search.html', context)