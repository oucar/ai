library(tidyverse)
test=read_csv("test.csv")
train=read_csv("train.csv")
ex_sub=read_csv("gender_submission.csv")

# Test data doesn't have the survived column. Goal is the filling that column out.

# fill in na

# mean age
mean_age=mean(train$Age,na.rm=T)
train$Age[is.na(train$Age)]=mean_age
test$Age[is.na(test$Age)]=mean_age

# model age to fill in missing data
#age_model=glm(Age~Sex+Parch,data=train[!is.na(train$Age),])
#train$Age[is.na(train$Age)]=predict(age_model,train[is.na(train$Age),])
#test$Age[is.na(test$Age)]=predict(age_model,test[is.na(test$Age),])

# replace category with averaged numeric value
cat2num=train %>% group_by(Embarked) %>% summarise(numEmb=mean(Survived,na.rm=T))
train=train %>% left_join(cat2num,by="Embarked")
test=test %>% left_join(cat2num,by="Embarked")

lin_model=glm(Survived~Sex+Parch+Age+numEmb,data=train,family="binomial")

# if you increase the age prob. of survival decreases
# if you increase the fare prob. of survival increases
summary(lin_model)

test$Survived=round(predict(lin_model,test,type="response"))
table(test$Survived)

# creating a csv out of R
write.csv(test[,c("PassengerId","Survived")],
          "glm_submission.csv",
          row.names=F)
