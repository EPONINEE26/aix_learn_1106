from django.shortcuts import render
from django.http import JsonResponse
import joblib
import os
from pathlib import Path
import numpy as np
from scipy.special import softmax


BASE_DIR = Path(__file__).resolve().parent.parent
model_ex = joblib.load(BASE_DIR / "model_ex.joblib")


def ajax_data(request):
    global model_ex
    # html에서 들어온 입력데이터
    data = request.POST.get('data','290.0,26.3,31.2,12.48,4.3056')
    # 파일 변환
    in_data = data
    in_data = in_data.split(',')
    in_data = list(map(float,in_data))

    # 입력된 데이터를 가지고 분류예측
    result = model_ex.predict([in_data])
    # 확률
    print('입력데이터 : ',in_data)
    print(f'예측생선 : {result[0]} ')
    print(f'생선분류 : {model_ex.classes_} ')

    
    #-------------------------------------
    # 모든 생선에 대한 확률을 가져옴.
    decisions = model_ex.decision_function([in_data])
    soft1 = softmax(decisions,axis=1)
    result_all = np.round(soft1,decimals=3)[0]
    if result == 'Bream':
        result2 = result_all[0]
    elif result == 'Parkki':
        result2 = result_all[1]    
    elif result == 'Perch':
        result2 = result_all[2]    
    elif result == 'Pike':
        result2 = result_all[3]    
    elif result == 'Roach':
        result2 = result_all[4]    
    elif result == 'Smelt':
        result2 = result_all[5]    
    elif result == 'Whitefish':
        result2 = result_all[6]    
        
    # np.array()타입을 list()타입으로 변경 - Json전송가능
    result_all = result_all.tolist()
    # 모든 생선 종류 확인
    print(model_ex[-1].classes_)
    result_name = (model_ex[-1].classes_).tolist()    
    # result_str = "".join(map(str,result_all))   
    #-------------------------------------   

    # 파일전달
    context = {
        'result':f'{result[0]}',       # 분류예측생선
        'result2':result2,             # 해당생선확률
        'result_all':result_all,       # 전체생선확률 
        'result_name':['Bream', 'Parkki', 'Perch', 'Pike', 'Roach', 'Smelt', 'Whitefish']  # 모든전체확률 
    }   
    
    # context = {'result_data': result[0],'result':result2 ,'result_all': result_all.tolist() }

    print(f'예측 생선 : {result[0]} (예측확률 : {result2}) ')
    return JsonResponse(context)


def index(request):
    return render(request, 'index.html')