#!/usr/bin/env python
# coding: utf-8

# In[1]:


import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
import scipy
import xgboost
import lightgbm
import warnings
from eli5.sklearn import PermutationImportance
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import f1_score, confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from lightgbm import LGBMClassifier, plot_importance
from xgboost import XGBClassifier
from sklearn.model_selection import StratifiedShuffleSplit
warnings.filterwarnings('ignore')


# In[2]:


data = pd.read_csv('casting.csv', encoding='cp949', index_col=0)
data.head()


# In[3]:


data.hist(figsize=(25,20))
plt.show()


# In[4]:


pass_count = len(data[data['passorfail']== 0])
fail_count = len(data[data['passorfail']== 1])
 
print('양품 개수 : ', pass_count)
print('불량 개수 : ', fail_count)
print('불량률 :', fail_count/(fail_count+pass_count)*100)


# In[5]:


use_col = data.dtypes[data.dtypes!='object'].index
data = data[use_col]
data


# In[6]:


data_copy = data.copy()
data_copy


# In[7]:


data_copy.columns


# In[8]:


data_copy.shape


# In[9]:


data_copy.isnull().sum()


# In[10]:


data_copy.describe().T


# In[11]:


data_copy.info()


# In[12]:


data_copy.drop('molten_volume', axis=1, inplace=True)
data_copy.dropna(axis=0, inplace=True)
data_copy.reset_index(drop=True, inplace=True)
data_copy


# In[13]:


for col in data_copy.dtypes[data_copy.dtypes!='object'].index:
     UCL = np.percentile(data_copy[col], 99.9)
     LCL = np.percentile(data_copy[col], 0.1)
     data_copy = data_copy[(data_copy[col] <= UCL) & (data_copy[col] >= LCL)]
data_copy.reset_index(drop=True, inplace=True)
data_copy


# In[14]:


t_test = []
for i, col in enumerate(data_copy.columns):
     t=scipy.stats.ttest_ind(data_copy[data_copy['passorfail']==1][col], data_copy[data_copy['passorfail']==0][col],equal_var=False)
     t_test.append([col, t[0], t[1]])
df_ttest = pd.DataFrame(t_test, columns=['col', 'tvalue', 'pvalue'])
use_t_list = []
for i in range(len(df_ttest)):
     if df_ttest['pvalue'][i] < 0.1:
         use_t_list.append(df_ttest['col'][i])
df_ttest


# In[15]:


data_copy = data_copy[use_t_list]
data_copy


# In[16]:


data_copy.drop(['count', 'EMS_operation_time', 'mold_code'], axis=1, inplace=True)
data_copy


# In[17]:


plt.figure(figsize=(25, 25))
sns.heatmap(data_copy.corr(), annot = True, fmt = '.1f', square = True, cmap = 'Blues')
plt.show()


# In[18]:


X = data_copy.drop('passorfail', axis=1).values
y = data_copy['passorfail'].values


# In[19]:


sss = StratifiedShuffleSplit(n_splits=5, random_state=42, test_size=0.2)


# In[20]:


mms = MinMaxScaler()


# In[21]:


dt_clf = DecisionTreeClassifier(random_state=42)
rf_clf = RandomForestClassifier(random_state=42)
xgb_clf = XGBClassifier(random_state=42, eval_metric='error', use_label_encoder=False)
lgbm_clf = LGBMClassifier(random_state=42)
ada_clf = AdaBoostClassifier(random_state=42)


# In[22]:


dt_clf = DecisionTreeClassifier(random_state=42)
dt_fold_f1 = []
n_iter = 0
print('모델 :', dt_clf)
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
         dt_fold_f1.sort(key=lambda x : x[1], reverse=True)
         print(f'교차검증 중 가장 높은 정확도 : Split {dt_fold_f1[0][0]} {dt_fold_f1[0][1]}')


# #### Decision Tree 모델 

# In[23]:


dt_clf.fit(X[idx_list[dt_fold_f1[0][0]-1][0]], y[idx_list[dt_fold_f1[0][0]-1][0]])
pred = dt_clf.predict(X[idx_list[dt_fold_f1[0][0]-1][1]])
cm = confusion_matrix(y[idx_list[dt_fold_f1[0][0]-1][1]], pred)
sns.heatmap(cm, annot=True, fmt='.0f')
plt.show()


# #### RandomForest 모델 학습 및 결과
# 

# In[24]:


rf_clf = RandomForestClassifier(random_state=42)
rf_fold_f1 = []
n_iter = 0
print('모델 :', rf_clf)
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
         rf_clf.fit(X_train_scaled, y_train)
         valid_pred = rf_clf.predict(X_valid_scaled)
         test_pred = rf_clf.predict(X_test_scaled)
         valid_f1 = f1_score(y_valid, valid_pred)
         test_f1 = f1_score(y_test, test_pred)
         n_iter += 1
         rf_fold_f1.append([n_iter, test_f1])
         idx_list.append([train_idx, test_idx])
         print(f'StratifiedShuffleSplit {n_iter} 검증 데이터 f1 정확도 : {valid_f1}')
         print(f'StratifiedShuffleSplit {n_iter} 테스트 데이터 f1 정확도 : {test_f1}')
         print('='*50)
         dt_fold_f1.sort(key=lambda x : x[1], reverse=True)
         print(f'교차검증 중 가장 높은 정확도 : Split {rf_fold_f1[0][0]} {rf_fold_f1[0][1]}')


# In[25]:


rf_clf.fit(X[idx_list[rf_fold_f1[0][0]-1][0]], y[idx_list[rf_fold_f1[0][0]-1][0]])
pred = rf_clf.predict(X[idx_list[rf_fold_f1[0][0]-1][1]])
cm = confusion_matrix(y[idx_list[rf_fold_f1[0][0]-1][1]], pred)
sns.heatmap(cm, annot=True, fmt='.0f')
plt.show()


# #### XGBoost

# In[26]:


xgb_clf = RandomForestClassifier(random_state=42)
xgb_fold_f1 = []
n_iter = 0
print('모델 :', xgb_clf)
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
         xgb_clf.fit(X_train_scaled, y_train)
         valid_pred = xgb_clf.predict(X_valid_scaled)
         test_pred = xgb_clf.predict(X_test_scaled)
         valid_f1 = f1_score(y_valid, valid_pred)
         test_f1 = f1_score(y_test, test_pred)
         n_iter += 1
         xgb_fold_f1.append([n_iter, test_f1])
         idx_list.append([train_idx, test_idx])
         print(f'StratifiedShuffleSplit {n_iter} 검증 데이터 f1 정확도 : {valid_f1}')
         print(f'StratifiedShuffleSplit {n_iter} 테스트 데이터 f1 정확도 : {test_f1}')
         print('='*50)
         xgb_fold_f1.sort(key=lambda x : x[1], reverse=True)
         print(f'교차검증 중 가장 높은 정확도 : Split {xgb_fold_f1[0][0]} {xgb_fold_f1[0][1]}')


# In[27]:


xgb_clf.fit(X[idx_list[xgb_fold_f1[0][0]-1][0]], y[idx_list[xgb_fold_f1[0][0]-1][0]])
pred = xgb_clf.predict(X[idx_list[xgb_fold_f1[0][0]-1][1]])
cm = confusion_matrix(y[idx_list[xgb_fold_f1[0][0]-1][1]], pred)
sns.heatmap(cm, annot=True, fmt='.0f')
plt.show()


# #### LightGBM

# In[28]:


lgbm_clf = LGBMClassifier(random_state=42)
lgbm_fold_f1 = []
n_iter = 0
print('모델 :', lgbm_clf)
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
         lgbm_clf.fit(X_train_scaled, y_train)
         valid_pred = lgbm_clf.predict(X_valid_scaled)
         test_pred = lgbm_clf.predict(X_test_scaled)
         valid_f1 = f1_score(y_valid, valid_pred)
         test_f1 = f1_score(y_test, test_pred)
         n_iter += 1
         lgbm_fold_f1.append([n_iter, test_f1])
         idx_list.append([train_idx, test_idx])
         print(f'StratifiedShuffleSplit {n_iter} 검증 데이터 f1 정확도 : {valid_f1}')
         print(f'StratifiedShuffleSplit {n_iter} 테스트 데이터 f1 정확도 : {test_f1}')
         print('='*50)
         lgbm_fold_f1.sort(key=lambda x : x[1], reverse=True)
         print(f'교차검증 중 가장 높은 정확도 : Split {lgbm_fold_f1[0][0]} {lgbm_fold_f1[0][1]}')


# In[29]:


lgbm_clf.fit(X[idx_list[lgbm_fold_f1[0][0]-1][0]], y[idx_list[lgbm_fold_f1[0][0]-1][0]])
pred = lgbm_clf.predict(X[idx_list[lgbm_fold_f1[0][0]-1][1]])
cm = confusion_matrix(y[idx_list[lgbm_fold_f1[0][0]-1][1]], pred)
sns.heatmap(cm, annot=True, fmt='.0f')
plt.show()


# #### AdaBoost
# 

# In[30]:


ada_clf = LGBMClassifier(random_state=42)
ada_fold_f1 = []
n_iter = 0
print('모델 :', lgbm_clf)
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
         ada_clf.fit(X_train_scaled, y_train)
         valid_pred = ada_clf.predict(X_valid_scaled)
         test_pred = ada_clf.predict(X_test_scaled)
         valid_f1 = f1_score(y_valid, valid_pred)
         test_f1 = f1_score(y_test, test_pred)
         n_iter += 1
         ada_fold_f1.append([n_iter, test_f1])
         idx_list.append([train_idx, test_idx])
         print(f'StratifiedShuffleSplit {n_iter} 검증 데이터 f1 정확도 : {valid_f1}')
         print(f'StratifiedShuffleSplit {n_iter} 테스트 데이터 f1 정확도 : {test_f1}')
         print('='*50)
         lgbm_fold_f1.sort(key=lambda x : x[1], reverse=True)
         print(f'교차검증 중 가장 높은 정확도 : Split {ada_fold_f1[0][0]} {ada_fold_f1[0][1]}')


# In[31]:


ada_clf.fit(X[idx_list[ada_fold_f1[0][0]-1][0]], y[idx_list[ada_fold_f1[0][0]-1][0]])
pred = ada_clf.predict(X[idx_list[ada_fold_f1[0][0]-1][1]])
cm = confusion_matrix(y[idx_list[ada_fold_f1[0][0]-1][1]], pred)
sns.heatmap(cm, annot=True, fmt='.0f')
plt.show()


# In[32]:


pi = PermutationImportance(lgbm_clf, scoring='f1', n_iter=30)
pi.fit(X[idx_list[lgbm_fold_f1[0][0]-1][0]], y[idx_list[lgbm_fold_f1[0][0]-1][0]])
permu_df = pd.DataFrame()
permu_df["feature"] = data_copy.columns[:-1]
permu_df["importance_weight"] = pi.feature_importances_
permu_df.sort_values(by='importance_weight', ascending=False, inplace=True)
permu_df.reset_index(drop=True, inplace=True)
plt.figure(figsize=(10, 8))
sns.barplot(x='importance_weight', y='feature', data=permu_df)
plt.title('Permutaion Importance', fontsize=18)
plt.show()


# In[33]:


lgbm = LGBMClassifier(random_state=42)
tmp = pd.DataFrame(X[idx_list[lgbm_fold_f1[0][0]-1][0]], columns=data_copy.columns[:-1])
lgbm.fit(tmp, y[idx_list[lgbm_fold_f1[0][0]-1][0]])
lightgbm.plot_tree(lgbm,dpi=100,orientation='vertical',figsize=(20,15), show_info=['internal_value', 'internal_count'])


# In[34]:


import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings('ignore')


# In[35]:


data = pd.read_csv('./casting.csv', encoding='cp949', index_col=0)
use_col = data.dtypes[data.dtypes!='object'].index
data_copy = data[use_col]
data_copy


# 완전성 품질 지수

# In[36]:


ratio = 30
total_li = []
remove_list = []
for column in data_copy.columns:
     tmp = data_copy[column]
     print('column name :', column)
     print('[step 1] 변수별 결측 비율')
     print(round(tmp.isnull().sum()/len(tmp)*100,2))
     print('[step 2] 변수별 결측 비율 30% 초과 여부')
     print(tmp.isnull().sum()/len(tmp)*100>ratio)
     if tmp.isnull().sum()/len(tmp)*100>ratio:
         remove_list.append(column)
     print('[step 3] 전체 데이터셋 결측치 개수')
     cmpt_len = tmp.isnull().sum().sum()
     print(cmpt_len)
     print(f"결측치 = {cmpt_len}개")
     print(f"완전성 지수 : {(1-cmpt_len/len(data_copy))*100}")
     print('='*30)
     total_li.append((1-cmpt_len/len(data_copy))*100)

print('전체 칼럼의 완전성 지수 :', np.mean(total_li))
print('30% 초과 변수 :', remove_list)
data_copy.drop(remove_list, axis=1, inplace=True)


# 유일성 품질지수

# In[37]:


check_unique = data_copy.value_counts().reset_index()
perc_check_unique=round((len(check_unique)-len(check_unique[check_unique[0]>1]))/len(check_unique)*100,2)
print(f"유일성 지수 : {perc_check_unique}")


# 유효성 품질 지수

# In[38]:


molten_temp_range = [0, 750]
facility_operation_cycleTime_range = [0, 500]
production_cycletime_range = [0, 500]
low_section_speed_range = [0, 200]
high_section_speed_range = [0, 400]
cast_pressure_range = [0, 400]
biscuit_thickness_range = [0,450]
upper_mold_temp1_range = [0, 1500]
upper_mold_temp2_range = [0, 1500]
upper_mold_temp3_range = [0, 1500]
lower_mold_temp1_range = [0, 400]
lower_mold_temp2_range = [0, 500]
lower_mold_temp3_range = [0, 1500]
sleeve_temperature_range = [0, 500]
physical_strength_range = [0, 800]
Coolant_temperature_range = [0, 50]
EMS_operation_time_range = [0, 25]
passorfail_range = [0, 1]
ranges = [molten_temp_range,facility_operation_cycleTime_range,production_cycletime_range,
low_section_speed_range,high_section_speed_range,cast_pressure_range,
biscuit_thickness_range,upper_mold_temp1_range,upper_mold_temp2_range, upper_mold_temp3_range,
          lower_mold_temp1_range,lower_mold_temp2_range,lower_mold_temp3_range,sleeve_temperature_range,
physical_strength_range,Coolant_temperature_range,EMS_operation_time_range,passorfail_range]


# In[39]:


total_in = 0
ratio = []
for col, value in zip(data_copy.columns[1:-1], ranges):
     column_in = 0
 
     for i in range(len(data_copy)):
         if value[0] <= data_copy[col][i] <= value[1] :
             column_in += 1
 
     ratio.append(column_in/len(data_copy)*100)
print(f'유효성 지수 : {np.round(np.mean(ratio),2)}')


# 일관성 품질지수

# In[40]:


numeric = 0
non_numeric = 0
for col in data_copy.columns:
     if (data_copy[col].dtypes == 'int64') | (data_copy[col].dtypes == 'float64'):
         numeric += 1
     else:
         non_numeric += 1
 
print(f'일관성 지수 : {(numeric/numeric+non_numeric)*100}')


# In[44]:


from sklearn.metrics import accuracy_score, f1_score, precision_score, recall_score, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

#결과 분석 및 해석
print(accuracy_score(y_test, pred))
print(f1_score(y_test, pred, average = 'weighted'))
print(precision_score(y_test, pred, average = 'weighted'))
print(recall_score(y_test, pred, average = 'weighted'))
cm = confusion_matrix(y_test, pred)

sns.heatmap(cm,annot=True,cmap='Blues')
plt.xlabel('Predicted')
plt.ylabel('True')
plt.show();


# In[ ]:




