## I. Summary
- Main methods I used for this competition that provides the desired Leaderboard score: LightGBM
- Methods I tried to implement but resulted in worse RMSE: XGBoost, Neural Network with categorical embedding, Stacking (both simple averaging and metal models such as Linear Regression and shallow random forest)
- The most important features are lag features of previous months, especially the ‘item_cnt_day’ lag features. Some of them, which can be found in my lag dataset, are 
  - **target_lag_1,target_lag_2**: item_cnt_day of each shop – item pair of previous month and previous two months
  - **item_block_target_mean_lag_1, item_block_target_sum_lag_1**: sum and mean of item_cnt_day per item of previous month
Important features are measured from LightGBM model
- Tools I used in this competition are: numpy, pandas, sklearn, XGBoost GPU, LightGBM, and fast.ai libraries (running Pytorch)
- All models are tuned on a linux server with Intel i5 processor, 16GB RAM, NVIDIA 1080 GPU. Tuning models took about 8 to 10 hours.


## II. Exploratory Data Analysis
More information can be found in [EDA notebook](EDA.ipynb)

Basic data analysis is done, including plotting sum and mean of item_cnt_day for each month to find some patterns, exploring missing values, inspecting test set …

Here are few things interesting I found from doing EDA:
- Number of sold items declines over the year
- There are peaks in November and similar item count zic-zac behaviors in June-July-August. This inspires me to look up Russia national holiday and create a Boolean holiday features. More information can be found in ‘Feature Engineering’ section
- Data has no missing values
- Some interesting information from test set analysis:
  - Not all shop_id in training set are used in test set. Test set excludes following shops (but not vice versa): [0, 1, 8, 9, 11, 13, 17, 20, 23, 27, 29, 30, 32, 33, 40, 43, 51, 54]
  - Not all item in train set are in test set and vice versa
  - In test set, a fixed set of items (5100) are used for each shop_id, and each item only appears one per each shop. This possibly means that items are picked from a generator, which will result in lots of 0 for item count. Therefore, generating all possible shop-item pairs for each month in train set and assigning missing item count with 0 makes sense.


## III. Feature Engineering

### 1. Generate all shop-item pairs and Mean Encoding
Since the competition task is to make a monthly prediction, we need to aggregate the data to monthly level before doing any encodings

Item counts for each shop-item pairs per month (‘target’). I also generated sum and mean of item counts for each shop per month (‘shop_block_target_sum’,’shop_block_target_mean’), each item per month (‘item_block_target_sum’,’item_block_target_mean’, and each item category per month (‘item_cat_block_target_sum’,’item_cat_block_target_mean’)

This process can be found in [this notebook](generate_lag_features.ipynb), under ‘Generating new_sales.csv’. Datasets generated from this steps will be saved under the name ‘new_sales.csv’

### 2. Generate lag features
Lag features are values at prior time steps. I am generating lag features based on ‘item_cnt’ and grouped by ‘shop_id’ and ‘item_id’ .  Time steps are: 1,2,3,5 and 12 months.

All sale record before 2014 are dropped, since there would be no lag features before 2014 as we have a 12-month lag.

These lag features turn out to be the most important features in my dataset, based on gradient boosting’s importance features.

More information can be found in [this notebook](generate_lag_features.ipynb), under ‘Generate lag feature new_sales_lag_after12.pickle’

### 3. Holiday Boolean features
As mentioned above, I look up few Russia national holidays and created few 5 more features: December (to mark December), Newyear_Xmas (for January), Valentine_Menday (February), Women_Day (March), Easter_Labor (April). This might help boosting my score a little since December feature seems to be helpful

After all this steps, you should have a pickle file name in ‘data‘ directory: 'new_sales_lag_after12.pickle'. This is the main file I used for training models


## IV. Cross validations
Since this is time series so I have to pre-define which data can be used for train and test. I have a function called get_cv_idxs in utils.py that will return a list of tuples for cross validation. I decide to use 6 folds, from date_block_num 28 to 33, and luckily this CV score is consistent to leaderboard score.


## V. Training methods:

### 1. LightGBM
LightGBM is tuned using hyperopt, then manually tune with GridSearchCV to get the optimal result. One interesting thing I found: when tuning the size of the tree, it’s better to tune min_data_in_leaf instead of max_depth. This means to let the tree grows freely until the condition for min_data_in_leaf is met. I believe this will allow deeper logic to develop without overfitting too much. Colsample_bytree and subsample are also used to control overfitting. And I keep the learning rate small (0.03) throughout tuning.

Mean RMSE of 6 folds CV is 0.9088, which is better than any other models I used.

You can find more information in [LGB notebook](lightgbm_tuning.ipynb). From this file I also created out-of-fold features for block 29 to 33, which is used for ensembling later.


### 2. XGBoost
I pick 2 models: one with max_depth tuned, and one without max_depth tuned, to get out-of-fold features and hoping they are different enough for ensembling. 

For the record, the first models results .912 CV score (in hyperopt) and .926 LB score, and second models results in .913 CV score (hyperopt) and .927 LB score. Either way, both are worse than LGB model 

You can find more information about this in [XGB notebook](xgb_tuning.ipynb). 

### 3. Neural Network with categorical embedding
This is by far the most time-consuming models, and I don’t have good results for this (1.001 on LB). I also made a fatal mistake while clipping the results due to late night coding, so I won’t discuss much about this. The idea is to separate all numerical features and categorical features, and apply embedding layers for each of those categorical features (i.e map each unique item_id to a vectors of some length). These embedding layers and numerical features are fed into hidden layers of Neural network.

This method is used to get the 3rd place in Kaggle Rossman competition. With Fast.ai library, it is easy to implement this approach, but it doesn’t seem to work well with this dataset.

## VI. Ensembling

With LightGBM, XGB model-1 and XGB model-2 out-of-fold features from previous methods, I calculated pairwise differences between them, get the mean of all 3 LGB, XGB1 and XGB2 out-of-fold features, and include the most important features from feature importance: ‘target_lag_1’.

From here I try few ensembling methods
- Simple average and Weighted average 
- SKlearn linear regression and Elasticnet
- Shallow Random Forest, tuned with 5 folds (from 29 to 33)

All of them results in RMSE score that is slightly more than the LightGBM best model, so LightGBM still outperforms them.

More information can be found in [Ensembling notebook](ensembling.ipynb)

