import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from sklearn.ensemble import RandomForestClassifier
from imblearn.over_sampling import SMOTE
from sklearn.metrics import confusion_matrix, accuracy_score, precision_score, recall_score, f1_score, roc_auc_score

# 데이터 로드 및 전처리
dc_data = pd.read_csv("data/DieCasting_Raw_Data.csv", encoding='EUC-KR')  # 'EUC-KR' 또는 'CP949' 시도

# 불필요한 열 제거 및 결측값 처리
dc_data_drop = dc_data.drop(['Shot', '_id'], axis=1)
dc_data_drop = dc_data_drop.dropna().reset_index(drop=True)

# 독립변수와 종속변수 정의
X = dc_data_drop.drop(columns=['Machine_Status'])
Y = dc_data_drop['Machine_Status']

# 데이터 스케일링
scaler = MinMaxScaler(feature_range=(0, 1))
X_scaled = scaler.fit_transform(X)
X_scaled = pd.DataFrame(X_scaled, columns=X.columns)

# 학습/테스트 데이터 분할
train_x, test_x, train_y, test_y = train_test_split(X_scaled, Y, test_size=0.3, random_state=42)

# SMOTE로 데이터 증강
smote = SMOTE(random_state=42)
X_train_over, y_train_over = smote.fit_resample(train_x, train_y)

# 랜덤 포레스트 모델 정의
rfc = RandomForestClassifier(n_estimators=101, max_depth=25, max_leaf_nodes=25,
                             min_samples_leaf=1, min_samples_split=6, random_state=0)

# 성능 평가 함수
def get_clf_eval(y_test, pred):
    print("Confusion Matrix:\n", confusion_matrix(y_test, pred))
    print('Accuracy:', accuracy_score(y_test, pred))
    print('F1 Score:', f1_score(y_test, pred))
    print('Precision:', precision_score(y_test, pred))
    print('Recall:', recall_score(y_test, pred))

# 모델 훈련 및 평가 함수
def get_model_train_eval(model, ftr_train, ftr_test, tgt_train, tgt_test):
    model.fit(ftr_train, tgt_train)
    pred = model.predict(ftr_test)
    get_clf_eval(tgt_test, pred)

# 모델 훈련 및 평가
get_model_train_eval(rfc, X_train_over, test_x, y_train_over, test_y)
