house = read.csv("trainHouse.csv")
titanic = read.csv("trainTitanic.csv")

### LINEAR REGRESSION ### 
# predict sale price of a home as a function of GrLivArea, PoolArea, FullBath, BedroomAbvGr,
house_model = glm(SalePrice ~ GrLivArea + PoolArea + BedroomAbvGr,
                  data = house, family = "gaussian")

# GrLivArea -> increases the price by 129.845 ...
# Poolarea -> decreases the price by 67.607 ...
# Pr ( >|t|) -> t value, probability
# You can remove PoolArea from the model because it's probability is higher?
summary(house_model)

prediction = predict(house_model, data.frame(GrLivArea=1500, PoolArea=0,
                                FullBath=3, BedroomAbvGr=3))
# predicted price of the given house
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
