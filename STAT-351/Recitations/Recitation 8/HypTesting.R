#Load in Customers dataset
Customers <- read.csv("Recitations/Recitation 8/Customers.csv", header=TRUE)

#Test whether customers spent more than $500 on average
t.test(Customers$Spending2018,mu = 500, alternative = "greater")

#Test whether fewer than 25% of customers are Very Satisfied
prop.table(table(Customers$Satisfaction))

#0.225 is Very Satisfied

length(Customers$Satisfaction)
#n = 200

z = (0.225 - 0.25)/sqrt(0.25*(1-0.25)/200)

#z-is -0.8165

#P-value
pVal = pnorm(z,0,1)

#P-value is 0.2071
pVal < 0.05

# Part 2
# 1.
n = 36
m = 1.22
s = 0.06
x = 1.20

t_stat = (m - x) / (s/sqrt(n))


2 * (1-pnorm(t_stat, mean=0, sd=1))

# 2.
n = 190
p_hat = 50/190
p = 0.20

z_stat = (p_hat - p) / sqrt((p*(1-p)) / n)

1 - pnorm(z_stat, mean=0, sd=1)
