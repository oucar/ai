# can do a t test for diff in means
y1=c(2,2,4,5,5,4,4,3,5)
y2=c(2,4,4,5,3,2,4,3,4,2)
t.test(y1,y2)

# simulation to see if coffee vs tea is stat sig
y_sim=rbinom(1000,18,.5)
sum(y_sim>=11)/1000 # one sided p value
sum(y_sim>=11)/1000+sum(y_sim<=7)/1000

# bootstrap confidence interval
y1=c(2,2,4,5,5,4,4,3,5)

y_bootstrap=replicate(10000,sample(y1,length(y1),replace=T))
mu_bootstrap=apply(y_bootstrap,2,mean)
quantile(mu_bootstrap,.025)
quantile(mu_bootstrap,.975)

y2=c(2,4,4,5,3,2,4,3,4,2)
mean(y2)

########
lp=read.csv("loss_premium.csv")
loss_ratio=sum(lp$loss)/sum(lp$premium)

# use bootratp to get a 95% CI for the loss ratio
#
# 1. For 10k times, sample data (rows) with replacement
# 2. For each compute loss ratio of bootstrap copy
# 3. Use quantile function to computer CI
#
#
lr_bootstrap=numeric(10000)
for(i in 1:10000){
Nr=nrow(lp)
lp_copy=lp[sample(Nr,Nr,T),]
lr_bootstrap[i]=sum(lp_copy$loss)/sum(lp_copy$premium)
}

View(lp_copy)
View(lp)

quantile(lr_bootstrap,.025)
quantile(lr_bootstrap,.975)




