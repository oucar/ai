library(tidyverse)
# Survived is available in train
testData=read_csv("test.csv")
train=read_csv("train.csv")
ex_sub=read_csv("gender_submission.csv")

table(train$Survived)


######################### 1 ######################### 
### GLM Logistic Regression
summary(train)
### Survived, Sex, Age, Pclass, Embarked -> categorical, factor can be used?
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)

### handle NA's 
# Check NA's or empty strings, then remove
colSums(is.na(train) | train == "")
train <- train %>% drop_na(Age)


# Split 70/30: 
set.seed(31)
train_size_70 <- floor(0.70 * nrow(train))
train_split <- sample(seq_len(nrow(train)), size = train_size_70)
train_splitted_data <- train[train_split, ]

titanic_glm <- glm(Survived ~ Sex + Age + Pclass + Embarked  + Fare + Parch, data = train_splitted_data, family = 'binomial')
summary(titanic_glm)

## Best predictors are Age, Fare and then Parch
predict_survived_7 <- predict(titanic_glm ,newdata = testData,type = 'response') 
# Above 0.51 will be accepted as 1
predict_survived_7 <- ifelse(predict_survived_7 > 0.51, 1, 0)

testData$Survived = predict_survived_7
# testData <- na.omit(testData) 

View(testData)
# Replace NA's
testData$Survived[is.na(testData$Survived)] <- 0

write.csv(testData[,c("PassengerId","Survived")],
          "glm_submission.csv",
          row.names=F)

######################### 2 ######################### 
library(randomForest)
library(xgboost)

## Random Forest
test <- read_csv("test.csv")
train <- read_csv("train.csv")

# train <- train %>% drop_na()
train <- train %>% drop_na(Sex, Age, Pclass, Embarked, Fare, Parch)


rfmodel <- randomForest(train[,c("Sex" , "Age" , "Pclass" , "Embarked"  , "Fare" , "Parch")],
                        train$Survived,
                        n.trees = 1000)
importance(rfmodel)

titanic_shuffle = train[sample(nrow(train),nrow(train),F),]
titanic_train=train[1:500,]
titanic_test=train[1:418,]

# train on training daa
rfmodel <- randomForest(titanic_train[,c("Sex" , "Age" , "Pclass" , "Embarked"  , "Fare" , "Parch")],
                        titanic_train$Survived,
                        n.trees=10000,
                        nodesize=20)

predict_rf <- predict(rfmodel, titanic_test[,c("Sex" , "Age" , "Pclass" , "Embarked"  , "Fare" , "Parch")])
predict_rf <- ifelse(predict_rf > 0.51, 1, 0)

test$Survived = predict_rf

write.csv(test[,c("PassengerId","Survived")],
          "glm_submission_rf.csv",
          row.names=F)
## GBM
library(MASS)

test <- read_csv("test.csv")
train <- read_csv("train.csv")

train_x = data.matrix(train[, -12])
train_y = train$Embarked
train_y <- na.omit(train_y)
train_x = na.omit(train_x)
View(train_y)

test_x = data.matrix(test[, -11])
test_y = test[, 11]

# xgb_train = xgb.DMatrix(data = train_x, label = train_y)
# xgb_test = xgb.DMatrix(data = test_x, label = test_y)
# length(train_y)

# gmb_model <- xgboost(data = train, label = train$Survived, nrounds = 2, objective = "binary:logistic")





### Accuracy : GLM > RF 