library(dplyr)
house = read.csv("trainHouse.csv")
titanic = read.csv("trainTitanic.csv")

### LINEAR REGRESSION ### 
# predict sale price of a home as a function of GrLivArea, PoolArea, FullBath, BedroomAbvGr,
house_model = glm(SalePrice ~ GrLivArea + PoolArea + BedroomAbvGr,
                  data = house, family = "gaussian")

# I am not sure what's happening here
# GrLivArea -> increases the price by 129.845 ...
# Poolarea -> decreases the price by 67.607 ...
# Pr ( >|t|) -> t value, probability
# You can remove PoolArea from the model because its probability is higher?
summary(house_model)

prediction = predict(house_model, data.frame(GrLivArea=1500, PoolArea=0,
                                FullBath=3, BedroomAbvGr=3))


# predicted the price of the given house
prediction


house$predictions = predict(house_model, house)
# correleation
cor(house$predictions, house$SalePrice)


### BINOMIAL REGRESSION ###
titanic_model = glm(Survived~Sex+Age+Pclass, data=titanic, family="binomial")

# Sexmale - male or not
summary(titanic_model)

# if answer is negative, use logistics function
# or you can use type = "response" as variable to get rid of the negative
predict(titanic_model, data.frame(Sex="male", Age=25, Pclass=2), type="response")





#### BOOTSTRAP AND REGRESSION ####

house_model_copy = glm(SalePrice ~ GrLivArea + PoolArea + BedroomAbvGr,
                  data = house[sample(nrow(house), nrow(house), T),],
                  family = "gaussian")

# new prediction based on the new sample! 
prediction = predict(house_model_copy, data.frame(GrLivArea=1500, PoolArea=0,
                                             FullBath=3, BedroomAbvGr=3))





## LECTURE 7
library(randomForest)

rfmodel=randomForest(house[,c("GrLivArea","PoolArea","FullBath","BedroomAbvGr")],
                     # TARGET VARIABLE
                     house$SalePrice,
                     # how many bootstrap copies
                     n.trees=1000)

# based on how often these variables show up in splits
importance(rfmodel)

house$rfpredictions=predict(rfmodel,
                            house[,c("GrLivArea","PoolArea","FullBath","BedroomAbvGr")])


# see how prediction depends on GrLivArea
partialPlot(rfmodel, 
            data.frame(house[,c("GrLivArea","PoolArea","FullBath","BedroomAbvGr")]),
            x.var = "GrLivArea")

### should really cross validate (CV)
## if we want to compare models

# create random train and test data
# Really important!
house_shuffle=house[sample(nrow(house),nrow(house),F),]
house_train=house[1:1000,]
house_test=house[1001:1460,]

# train on training data
rfmodel=randomForest(house_train[,c("GrLivArea","PoolArea","FullBath","BedroomAbvGr")],
                     house_train$SalePrice,
                     n.trees=10000,nodesize=20)

glmmodel=glm(SalePrice~GrLivArea+PoolArea+FullBath+BedroomAbvGr,
             data=house_train,family="gaussian")

#predict on test data

house_test$rfpredictions=predict(rfmodel,
                                 house_test[,c("GrLivArea","PoolArea","FullBath","BedroomAbvGr")])

house_test$predictions=predict(glmmodel,house_test)

#compare accuracy on held out data
mean(abs(house_test$rfpredictions-house_test$SalePrice))
mean(abs(house_test$predictions-house_test$SalePrice))





