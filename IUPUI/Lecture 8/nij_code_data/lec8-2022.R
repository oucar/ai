library(tidyverse)
library(xgboost)

nij_train = read_rds("nij_training.rds")


# Linear regression: easier but often data is not linear.
# Random forest: based on decision trees that divide feature space into various rectangles (like decision splits)
# 

xgb2int=function(data){
  data$Gang_Affiliated=as.integer(data$Gang_Affiliated)
  data$Gender=as.integer(data$Gender)
  data$Arrests_PPViolationCharges=as.integer(data$Arrests_PPViolationCharges)
  data$Revos_Parole=as.integer(data$Revos_Parole)
  data$Program_Attendances=as.integer(data$Program_Attendances)
  data$Convictions_Felony=as.integer(data$Convictions_Felony) 
  
  return(as.matrix(data))
}


features=c("Arrests_Age","day_job_diff","Jobs_Per_Year","golden",
           "Total_Arrests","yrs18","num_Arrests_PPViolationCharges",
           "Percent_Days_Employed","num_Arrests_Misd","Avg_Days_per_DrugTest",
           "Total_Convictions","Arrests_PPViolationCharges","DrugTests_THC_Positive",
           "num_Arrests_Felony","Gang_Affiliated","num_Arrests_Property",
           "num_Arrests_Drug","Convictions_Age","num_Convictions_Felony","Gender",
           "Revos_Parole","Program_Attendances","Convictions_Felony",
           "DrugTests_Cocaine_Positive",
           "num_Convictions_Prop","Yavgid")

ylabel=nij_train$Y3

dtrain <- xgb.DMatrix(data = xgb2int(nij_train[,features]), label = as.numeric(unlist(ylabel)))

set.seed(1)
modelxgb<-xgboost(data = dtrain,
                  min_split_loss=.01,
                  missing_value=-9999.0,
                  nrounds=470,
                  random_state=153,
                  alpha=0.0,
                  lambda=1.0,
                  smooth_interval=200,
                  subsample=0.7,
                  tree_method="auto",
                  learning_rate=.02,
                  max_bin=256,
                  max_delta_step=0.0,
                  max_depth=3,
                  colsample_bytree=0.2,
                  interval=10,
                  colsample_bylevel=1.0,
                  min_child_weight=1.0,
                  verbose=0,
                  objective = "reg:squarederror")


prd=predict(modelxgb,dtrain)
