# ====   PATHS ===================

PATH_TO_DATASET = "titanic.csv"
OUTPUT_SCALER_PATH = 'scaler.pkl'
OUTPUT_MODEL_PATH = 'logistic_regression.pkl'


# ======= PARAMETERS ===============

# imputation parameters
# This is to capture the median values of the numerical features of the train set.
# We need to fill up the missing values of the numerical features of the test set using the same median values.  
IMPUTATION_DICT = {
	'age': 28,
	'fare': 14.4542
}


# encoding parameters
FREQUENT_LABELS = {
	'sex': ['female', 'male'],
	'cabin': ['C', 'Missing'],
	'embarked': ['C', 'Q', 'S'],
	'title': ['Miss', 'Mr', 'Mrs']
}


DUMMY_VARIABLES = ['sex_male', 'cabin_Missing', 'cabin_Rare', 'embarked_Q',	'embarked_Rare', 'embarked_S', 'title_Mr', 'title_Mrs', 'title_Rare']


# ======= FEATURE GROUPS =============

TARGET = 'survived'

CATEGORICAL_VARS = ['sex', 'cabin', 'embarked', 'title']

NUMERICAL_TO_IMPUTE = ['age', 'fare']