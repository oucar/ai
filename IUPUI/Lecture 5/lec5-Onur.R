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
