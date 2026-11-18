from django.shortcuts import render
from django.http import JsonResponse
import joblib
import os
from pathlib import Path
import numpy as np
from scipy.special import softmax


BASE_DIR = Path(__file__).resolve().parent.parent
model3 = joblib.load(BASE_DIR / "model3.joblib")


def index(request):
    return render(request, 'index.html')

def ajax_data(request):
    global model3
    data = request.POST.get('data', '9.4,1.8,3.51')

    in_data = data
    in_data = in_data.split(',')
    in_data = list(map(float,in_data))
    print('전달받은 원본 데이터:', data)
    print('입력 데이터 개수:', len(in_data))
    
    result = model3.predict([in_data])
    print('입력데이터:', in_data)
    print(f'예측와인: {result[0]}')
    print(f'와인분류: {model3.classes_}')    
    # print('예측와인:', result[0])
    # print('와인분류:', model3.classes_)
    
    proba = model3.predict_proba([in_data])
    result_all = np.round(proba, decimals=3)[0].tolist()
          
    decisions= model3.decision_function([in_data])
    decisions = np.array([[0, decisions[0]]])
    soft1 = softmax(decisions,axis=1)  #axis =1:행방향 / axis=0:열방향
    print("softmax 전체 확률 : ")
    print(np.round(soft1,decimals=2))
    result_all = np.round(soft1,decimals=3)[0].tolist()  
         
    if result[0] == 0:
        result2 = result_all[0] # 분류 0의 확률
        name = '레드와인(0)'
    else:
        result2 = result_all[1] # 분류 1의 확률
        name = '화이트와인(1)'
            
    print(model3[-1].classes_)
    result_name = (model3[-1].classes_).tolist()
    print('분류와인 : ', name)
    print('확률 : ', result2)

    context = {
        'result' : f'{result[0]}',    # 모델이 예측한 숫자 (0 또는 1)
        'result2' : result2,          # 예측된 그 와인의 확률값 (%)
        'result_all' : result_all,    # 전체 후보군 각각의 확률 리스트
        'result_name' : result_name,  # 모든 전체확률 전체 후보군의 이름 리스트
        'name' : name                 # 숫자(0 또는 1)에서 변환된 최종 예측 와인 이름
    }

    print(f'예측 와인 : {result[0]}')
    return JsonResponse(context)