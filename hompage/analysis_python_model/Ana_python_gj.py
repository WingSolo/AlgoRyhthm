# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
import scipy
import xgboost
import lightgbm
import warnings
# from eli5.sklearn import PermutationImportance
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import f1_score, confusion_matrix, accuracy_score, precision_score, recall_score, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from lightgbm import LGBMClassifier, plot_importance
from xgboost import XGBClassifier
from sklearn.model_selection import StratifiedShuffleSplit
warnings.filterwarnings('ignore')
import pymysql

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

data = pd.read_csv(file_path['file_path'].to_string(index = False), index_col = 0, encoding = 'cp949')
# data = pd.read_csv(file_path['file_path'].to_string(index = False), header=[0, 1])
# data = pd.read_csv('C:\savepath/Ana_data_gj.csv', index_col=0, encoding = 'cp949')

# data.hist(figsize=(25,20))
# plt.show()

pass_count = len(data[data['passorfail']== 0])
fail_count = len(data[data['passorfail']== 1])

# print('양품 개수 : ', pass_count)
# print('불량 개수 : ', fail_count)
# print('불량률 :', fail_count/(fail_count+pass_count)*100)

use_col = data.dtypes[data.dtypes!='object'].index
data = data[use_col]
data_copy = data.copy()

data_copy.drop('molten_volume', axis=1, inplace=True)
data_copy.dropna(axis=0, inplace=True)
data_copy.reset_index(drop=True, inplace=True)

for col in data_copy.dtypes[data_copy.dtypes!='object'].index:
    UCL = np.percentile(data_copy[col], 99.9)
    LCL = np.percentile(data_copy[col], 0.1)
    data_copy = data_copy[(data_copy[col] <= UCL) & (data_copy[col] >= LCL)]
data_copy.reset_index(drop=True, inplace=True)

t_test = []
for i, col in enumerate(data_copy.columns):
    t=scipy.stats.ttest_ind(data_copy[data_copy['passorfail']==1][col], data_copy[data_copy['passorfail']==0][col],equal_var=False)
    t_test.append([col, t[0], t[1]])
df_ttest = pd.DataFrame(t_test, columns=['col', 'tvalue', 'pvalue'])
use_t_list = [df_ttest['col'][i] for i in range(len(df_ttest)) if df_ttest['pvalue'][i] < 0.1]

data_copy = data_copy[use_t_list]
data_copy.drop(['count', 'EMS_operation_time', 'mold_code'], axis=1, inplace=True)

X = data_copy.drop('passorfail', axis=1).values
y = data_copy['passorfail'].values

sss = StratifiedShuffleSplit(n_splits=5, random_state=42, test_size=0.2)
mms = MinMaxScaler()

dt_clf = DecisionTreeClassifier(random_state=42)
# rf_clf = RandomForestClassifier(random_state=42)
# xgb_clf = XGBClassifier(random_state=42, eval_metric='error', use_label_encoder=False)
# lgbm_clf = LGBMClassifier(random_state=42)
# ada_clf = AdaBoostClassifier(random_state=42)

dt_fold_f1 = []
n_iter = 0
idx_list = [] 
for train_idx, test_idx in sss.split(X, y):
    X_train, X_test = X[train_idx], X[test_idx]
    y_train, y_test = y[train_idx], y[test_idx]

    for train_idx, valid_idx in sss.split(X_train, y_train):
        X_valid = X_train[valid_idx]
        y_valid = y_train[valid_idx]
        X_train_scaled = mms.fit_transform(X_train)
        X_test_scaled = mms.transform(X_test)
        X_valid_scaled = mms.transform(X_valid)
        dt_clf.fit(X_train_scaled, y_train)
        valid_pred = dt_clf.predict(X_valid_scaled)
        test_pred = dt_clf.predict(X_test_scaled)
        valid_f1 = f1_score(y_valid, valid_pred)
        test_f1 = f1_score(y_test, test_pred)
        n_iter += 1
        dt_fold_f1.append([n_iter, test_f1])
        idx_list.append([train_idx, test_idx])
        print(f'StratifiedShuffleSplit {n_iter} 검증 데이터 f1 정확도 : {valid_f1}')
        print(f'StratifiedShuffleSplit {n_iter} 테스트 데이터 f1 정확도 : {test_f1}')
        print('='*50)

# 성능 지표 계산
dt_clf.fit(X[idx_list[dt_fold_f1[0][0]-1][0]], y[idx_list[dt_fold_f1[0][0]-1][0]])
pred = dt_clf.predict(X[idx_list[dt_fold_f1[0][0]-1][1]])

accuracy_s = accuracy_score(y[idx_list[dt_fold_f1[0][0]-1][1]], pred)
precision_s = precision_score(y[idx_list[dt_fold_f1[0][0]-1][1]], pred)
recall_s = recall_score(y[idx_list[dt_fold_f1[0][0]-1][1]], pred)
f1_s = f1_score(y[idx_list[dt_fold_f1[0][0]-1][1]], pred)
# auc = roc_auc_score(y[idx_list[dt_fold_f1[0][0]-1][1]], dt_clf.predict_proba(X[idx_list[dt_fold_f1[0][0]-1][1]])[:, 1])

print(f"Accuracy: {accuracy_s}")
print(f"Precision: {precision_s}")
print(f"Recall: {recall_s}")
print(f"F1 Score: {f1_s}")

val = (accuracy_s, f1_s, recall_s, precision_s)
# val = ("1234", "1234", "1234", "1234")

print(val)

SQL_insert_data = 'insert into analysis_result (accuracy_score, f1_score, recall_score, precision_score) values (%s, %s, %s, %s)'

cursor = db.cursor()
cursor.execute(SQL_insert_data, val)

db.commit()
db.close()
# print(f"AUC: {auc}")

