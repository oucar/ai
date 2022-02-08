house=read_csv("house_price.csv")
titanic=read_csv("titanic_survival.csv")


library(randomForest)

rfmodel=randomForest(house[,c("GrLivArea","PoolArea","FullBath","BedroomAbvGr")],
                     house$SalePrice,
                     n.trees=1000)

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




