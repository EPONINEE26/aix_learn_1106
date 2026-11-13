from django.shortcuts import render
from board.models import Board

# 전체 영화 12개 목록
def mlist(request):
    qs = Board.objects.all()
    context = {'list':qs}
    return render(request, 'mlist.html', context)


# 액션 영화 3개
def action(request):
    qs = Board.objects.filter(genre='액션')[:3]
    context = {'list':qs}
    return render(request, 'mlist.html', context)


# 드라마 영화 3개
def drama(request):
    qs = Board.objects.filter(genre='드라마')[:3]
    context = {'list':qs}
    return render(request, 'mlist.html', context)


# 스릴러 영화 3개
def thriller(request):
    qs = Board.objects.filter(genre='스릴러')[:3]
    context = {'list':qs}
    return render(request, 'mlist.html', context)


# 코믹 영화 3개
def comedy(request):
    qs = Board.objects.filter(genre='코믹')[:3]
    context = {'list':qs}
    return render(request, 'mlist.html', context)


# 영화 상세 정보
def mview(request, mno):
    qs = Board.objects.get(mno=mno)
    context = {'movie':qs}
    return render(request, 'mview.html', context)
