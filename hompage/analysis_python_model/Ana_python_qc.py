import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier, AdaBoostClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, roc_auc_score, recall_score, accuracy_score, precision_score, f1_score
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from imblearn.over_sampling import*
import matplotlib.pyplot as plt
import seaborn as sns
import pymysql
import os

# db 연동
host_name = '127.0.0.1'
host_port = 3306
username = 'root'
password = '1234'
database_name = 'algo'

db = pymysql.connect(
    host = host_name, 
    port = host_port,
    user = username,
    passwd = password,
    db = database_name
)

# select-path
SQL_data_sel = 'select file_path from analysis order by num DESC LIMIT 1;'

file_path = pd.read_sql_query(SQL_data_sel, db)

SQL_data_num = 'select num from analysis order by num DESC LIMIT 1;'

file_num = pd.read_sql_query(SQL_data_num, db)

df = pd.read_csv(file_path['file_path'].to_string(index = False), header=[0, 1])

# df = pd.read_csv('C:/Users/jungf/OneDrive/analysis/jj/data/DieCasting_Quality_Raw_Data.csv', header=[0, 1])

#===================================================
df.head()

df.columns

df.describe()

df.info()

df.shape

# 결측치 확인
df.isna().sum()

# 데이터 정제(전처리)
# 불량 유형
cavity1_out_list=[('Defects','Short_Shot_1'),('Defects','Bubble_1'),('Defects','Exfoliation_1'),('Defects','Blow_Hole_1'),('Defects','Stain_1'),('Defects','Dent_1'),('Defects','Deformation_1'),('Defects','Contamination_1'),
                  ('Defects','Impurity_1'),('Defects','Crack_1'),('Defects','Scratch_1'),('Defects','Buring_Mark_1'),('Defects','Inclusions_1')]
cavity2_out_list=[('Defects','Short_Shot_2'),('Defects','Bubble_2'),('Defects','Exfoliation_2'),('Defects','Blow_Hole_2'),
                  ('Defects','Stain_2'),('Defects','Dent_2'),('Defects','Deformation_2'),('Defects','Contamination_2'),('Defects','Impurity_2'),('Defects','Crack_2'),('Defects','Scratch_2'),('Defects','Buring_Mark_2'),('Defects','Inclusions_2')]

# 캐비티 1번, 2번 불량 유형 열의 NAN값 0으로 대체
df[cavity1_out_list] = df[cavity1_out_list].fillna(0)
df[cavity2_out_list] = df[cavity2_out_list].fillna(0)

cavity_all = cavity1_out_list + cavity2_out_list
df[cavity_all].isnull().sum()

# 캐비티1번: 양품이면 1 불량이면 0
df.loc[:, ('Defects', 'Good1')] = np.where(np.sum(df[cavity1_out_list], axis = 1)==0,1,0) 

# 캐비티2번: 양품이면 1 불량이면 0
df.loc[:, ('Defects', 'Good2')] = np.where(np.sum(df[cavity2_out_list], axis = 1)==0,1,0)

# 불량 유형 담은 리스트에 양품 여부열 추가
cavity1_out_list.append(('Defects', 'Good1'))
cavity2_out_list.append(('Defects', 'Good2'))

df

# 불량 발생하는 유형을 표기하기 위한 열 생성
df[('Defects', 'cavity1out')] = np.argmax(np.array(df[cavity1_out_list]), axis = 1)
df[('Defects', 'cavity2out')] = np.argmax(np.array(df[cavity2_out_list]), axis = 1)
df

# 새롭게 불량 유형 표기
cavity_list = ['Good', 'Short_Shot', 'Bubble', 'Exfoliation', 'Blow_Hole', 'Etc']

# 캐비티1
df[('Defects', 'cavity1out2')] = np.where(df[('Defects', 'cavity1out')]==13,0,
                                         np.where(df[('Defects', 'cavity1out')]==0, 1, 
                                                 np.where(df[('Defects', 'cavity1out')]==1, 2, 
                                                         np.where(df[('Defects', 'cavity1out')]==2, 3, 
                                                                 np.where(df[('Defects', 'cavity1out')]==3, 4, 5)))))
# 캐비티2
df[('Defects', 'cavity2out2')] = np.where(df[('Defects', 'cavity2out')]==13, 0, 
                                         np.where(df[('Defects', 'cavity2out')]==0, 1, 
                                                 np.where(df[('Defects', 'cavity2out')]==1, 2, 
                                                         np.where(df[('Defects', 'cavity2out')]==2, 3, 
                                                                 np.where(df[('Defects', 'cavity2out')]==3, 4, 5)))))

# 불필요한 열 줄이기
df = df.drop(columns = cavity1_out_list)
df = df.drop(columns = cavity2_out_list)

df = df.drop(columns = [('Defects', 'cavity1out'), ('Defects', 'cavity2out')])

# 빈 행 제거 #7445
df = df.dropna()

# 멀티 칼럼 제거
df.columns = df.columns.droplevel(0)

# 불필요한 열 제거
df = df.drop(['id', 'Shot'], axis = 1)

# cavity1, cavity2 행으로 연결
df_1 = pd.melt(df, id_vars = df.columns.values[:-2], 
              value_vars = df.columns.values[-2:])
df_1

# 캐비티 1번이면 0, 2번이면 1
df_1['cavity']= np.where(df_1['variable']=='cavity1out2', 0, 1)
df_1

# 중복항 제거
df_1.drop_duplicates(inplace = True)

# 불필요한 열 제거
df_1 = df_1.drop(columns = ['variable'])

# 인덱스 정리
df_1.reset_index(drop = True, inplace = True)
df_1

# input_data, target_data 분리
x_list = df_1.columns.drop(['value'])

xx = df_1.loc[:, x_list]
yy = df_1.loc[:, 'value']

yy.value_counts()

# 캐비티 타입 변환
xx['cavity'] = xx['cavity'].astype('category')
xx.dtypes

# 학습 / 평가 데이터 분리
X_train, X_test, y_train, y_test = train_test_split(xx, yy, test_size = 0.3, random_state = 1234)

# AI모델 구축
xg1 = GradientBoostingClassifier(n_estimators = 100)

# 모델 훈련
xg1.fit(X_train, y_train)
xg1_pred = xg1.predict(X_test)

# 결과 분석 및 해석
accuracy_s = accuracy_score(y_test, xg1_pred)
f1_s = f1_score(y_test, xg1_pred, average = 'weighted')
precision_s = precision_score(y_test, xg1_pred, average = 'weighted')
recall_s = recall_score(y_test, xg1_pred, average = 'weighted')

val = (accuracy_s, f1_s, recall_s, precision_s)
# val = ("1234", "1234", "1234", "1234")

print(val)

SQL_insert_data = 'insert into analysis_result (accuracy_score, f1_score, recall_score, precision_score) values (%s, %s, %s, %s)'

cursor = db.cursor()
cursor.execute(SQL_insert_data, val)

db.commit()
db.close()
# cm = confusion_matrix(y_test, xg1_pred)

# sns.heatmap(cm, annot = True, cmap = 'Blues')
# plt.xlabel('Predicted')
# plt.ylabel('True')
# plt.show()
