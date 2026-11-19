import pandas as pd

# 파일읽어오기
df = pd.read_json(r'C:\workspace\learn\aix_learn_1106\movie.list\searchMovieList (1).json')
print(df.head(2))


# 파일저장
df.to_csv('searchMovie.csv',encoding='utf-8-sig')
print('완료')