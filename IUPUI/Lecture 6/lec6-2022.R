house=read_csv("house_price.csv")
titanic=read_csv("titanic_survival.csv")

house_model=glm(SalePrice~GrLivArea+PoolArea+FullBath+BedroomAbvGr,
                data=house,family="gaussian")

summary(house_model)

prediction=predict(house_model,data.frame(GrLivArea=1500,PoolArea=0,
                              FullBath=3,BedroomAbvGr=3))

house$predictions=predict(house_model,house)

titanic_model=glm(Survived~Sex+Age+Pclass,
                data=titanic,family="binomial")

predict(titanic_model,data.frame(Sex="male",Age=25,Pclass=2),
        type="response")

###### bootstrap to quantify uncertainty

house_model=glm(SalePrice~GrLivArea+PoolArea+FullBath+BedroomAbvGr,
                data=house,family="gaussian")
predict(house_model,data.frame(GrLivArea=1500,PoolArea=0,
                                          FullBath=3,BedroomAbvGr=3))

house_model_copy=glm(SalePrice~GrLivArea+PoolArea+FullBath+BedroomAbvGr,
                data=house[sample(nrow(house),nrow(house),T),],
                family="gaussian")
predict(house_model_copy,data.frame(GrLivArea=1500,PoolArea=0,
                               FullBath=3,BedroomAbvGr=3))
