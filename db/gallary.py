import json
import pandas as pd

df = pd.read_json('db/galleryList1.json')
print(df.head(2))

df.to_csv('db/galleryList1.csv',encoding='utf-8-sig')
print('완료')
print(df.head(2))