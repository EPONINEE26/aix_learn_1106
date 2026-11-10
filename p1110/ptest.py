import pandas as pd
from sklearn import svm,metrics

df = pd.read_csv('p1110/data/mushroom.csv', header=None) # 기준점이 aix_learn_1106 부터이기에 폴더명을 제일 먼저 작성해야 읽어옴)
print(df) 



