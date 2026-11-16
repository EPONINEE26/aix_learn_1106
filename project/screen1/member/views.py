from django.shortcuts import render
import os
from pathlib import Path
from member.models import Member
from django.views.decorators.csrf import csrf_exempt                        

def logout(request):
    request.session.clear()
    context = {'temp':2}
    return render(request,'login.html',context)


def login(request):
    if request.method == 'GET':
        return render(request,'login.html')
    
    elif request.method == 'POST':
        id = request.POST.get('id')
        pw = request.POST.get('pw')
        qs = Member.objects.filter(id=id,pw=pw) # blank -> [0]
        if qs:
            qs = qs[0]
            request.session['session_id'] = qs.id
            request.session['session_nickname'] = qs.nickname
            temp = 1
        else:
            temp = 0
        context = {'temp':temp}        
        return render(request,'login.html',context) 
  
    

def membership1(request):
    return render(request, 'membership1.html')









