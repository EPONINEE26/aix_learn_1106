# 딥러닝, 머신러닝 

# 지도 학습 : 답을 주고 학습시키는 것, 예측, 분류의 알고리즘으로 진행
# regression : 데이터에 따라 답이 달라지는 것 (예측), 1.0으로 분류되는 것 (분류)
# svm (support vector machine) : machinLearning의 일종의 방법으로 데이터들이 비슷한 특징들을 나타낼때 그 패턴을 컴퓨터가 쉽게 알게 하기위해 데이터 사이의 선을 긋는 것. 주로 교사합습과 회귀분석 분류에 많이 쓰임 
# K-최근접이웃 (K-NN, K-Nearest Neighbar) 알고리즘 
# 알고리즘의 기준점을 세우는 것이 중요. 

# 비지도 학습 : 답이 없고 그룹핑으로 학습시키는 것
# 강화 학습 : 경험치를 가지고 학습시키는 것 

from sklearn import svm, metrics

# 1. 데이터준비 - 학습데이터, 테스트데이터 분리 8:2 
# 학습 데이터 : 2차원배열형태여야함. 무조건. 
data = [ [0,0],[0,1],[1,0],[1,1] ]  
label = [0,1,1,0] 

# 테스트 데이터 
test_data = [[0,0],[1,0]]
test_label = [0,1]

# 데이터 학습 
clf = svm.SVC()  # 알고리즘 선택 
clf.fit(data,label) # 학습시키기 

# 데이터 예측 
results = clf.predict(test_data) # 테스트데이터를 가지고 예측실행 
print("예측결과:", results) # 0,1 

# 정답율
# score = metrics.accuracy_score(test_label,results)
score = clf.score(test_data, test_label) 
print("정답율:", score) # 1,0

# 데이터 학습 코드 전 
# import sys
# import locale

# print("Python:", sys.executable)
# print("UTF-8 모드:", sys.flags.utf8_mode)
# print("기본 인코딩:", locale.getpreferredencoding())

# 터미널 창에서 실행 
# [System.Environment]::SetEnvironmentVariable("PYTHONUTF8", "1", "User")
# [System.Environment]::GetEnvironmentVariable("PYTHONUTF8", "User")
