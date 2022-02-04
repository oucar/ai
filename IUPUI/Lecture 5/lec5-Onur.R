## Hypothesis Testing with the help of t-distrubition
# if your data is large enough, you can use the z test
y1=c(2,2,4,5,5,4,4,3,5)
y2=c(2,4,4,5,3,2,4,3,4,2)
t.test(y1,y2)


##### BOOTSTRAP STUFF #####
# Simulation to see if coffee vs tea is stat sig
# 18 students in the class, p = 0.5
# generates 1 assumption
rbinom(1, 18, 0.5)

# generates 1000 assumption about possible student answers
coffee_sim = rbinom(1000, 18, 0.5)
hist(coffee_sim)

# one sided p-value
sum(coffee_sim>=11)/1000
# two sided p-value (11, 7 --> symmetric)
sum(coffee_sim>=11)/1000 + sum(coffee_sim<7)/1000


##### CLASS CHALLENGE #####
y1=c(2,2,4,5,5,4,4,3,5)
y2=c(2,4,4,5,3,2,4,3,4,2)

# you get slightly different data everytime
# put `sample(y1, length(y1), replace = T)` in commandline
y_bootstrap = replicate(10000, sample(y1, length(y1), replace = T))
mu_bootstrap = apply(y_bootstrap, 2, mean)
# calculate 90% confidence interval for y1
quantile(mu_bootstrap, .025)
quantile(mu_bootstrap, .975)
# test difference on means
mean(y2)
mean(y1)


###### LOSS PREMIUM ######
lp = read.csv("loss_premium.csv")
View(lp)

loss_ratio = sum(lp$loss)/sum(lp$premium)


## use bootstrap to get a 95% CI for the loss ratio
# 1- For 10k times, sample data(rows) with replacement
# 2- For each compute loss ratio of bootstrap copy
# 3- Use quantile function to compute the CI
lr_bootstrap=numeric(10000)
for(i in 1:10000){
  Nr=nrow(lp)
  lp_copy=lp[sample(Nr,Nr,T),]
  lr_bootstrap[i]=sum(lp_copy$loss)/sum(lp_copy$premium)
}

quantile(lr_bootstrap,.025)
quantile(lr_bootstrap,.975)
