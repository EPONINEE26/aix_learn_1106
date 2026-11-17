from django.shortcuts import render
from django.http import JsonResponse
from pathlib import Path
import os
import joblib

# 메인페이지 
def index(request):
    # 주소 :  C:\workspace\learn\aix_learn_1106\wproject\wpro 로 이동하는 의미
    # BASE_DIR = Path(__file__).resolve().parent.parent
    # model = joblib.load(BASE_DIR/"model.joblib")
    # # 예측
    # # in_data = input('길이,높이,넓이를 입력하세요. 예) 40,11.73,7.22')
    # in_data = '40,11.73,7.22'
    # in_data = in_data.split(',')
    # result = list(map(float, in_data))

    # 예측
    # print('입력데이터:', result)
    # result = model.predict([result])
    # print('예측무게: {result[0]:.2f}g')       
    
    # print("주소 : ", BASE_DIR)
    
    # data = request.POST.get('data','40,11.73,7.22')
    # html로 데이터 전달
    # context = {'result':'데이터를 입력하세요.','result2': '예측값이 나타납니다.'}
    return render(request,'index.html')


def ajax_data(request):
    data = request.POST.get('data','40,11.73,7.22')
    BASE_DIR = Path(__file__).resolve().parent.parent
    model = joblib.load(BASE_DIR / "model.joblib")
    
    # 파일 변환
    in_data = data
    in_data = in_data.split(',')
    result = list(map(float,in_data))

    # 예측
    print('입력데이터 : ',result)
    result = model.predict([result])
    print(f'예측무게 : {result[0]:.2f} g')
    # 파일전달
    context = {
        'data':result[0],'result':'success'
    }
    return JsonResponse(context)


# def ajax_data(request):
#     # data = request.POST.get('data','')
#     data = request.POST.get('data','40,11.73,7.22')
#     #### 머신러닝 예측 결과    
#     try : 
#         values = [float(values.strip()) for values in data.split(',')]
#         if len(values) !=3:
#             raise ValueError
    
#     except ValueError:
#         return JsonResponse({            
#         })
    
#     context = {
#         'result':data,'result2':876.54
#     }
#     return JsonResponse(context)

