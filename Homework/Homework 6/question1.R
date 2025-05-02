customers <- read.csv("Homework/Homework 6/Customers.csv")

customers_sd = round(sd(customers$Customers), 2)
customers_mean = round(mean(customers$Customers), 2)
customers_n = length(customers$Customers)

cust_alpha = 1 - .90
1 - cust_alpha / 2

t_stat_cust = round(qt(1 - cust_alpha / 2, customers_n - 1), 3)

customers_moe = t_stat_cust * (customer_sd / sqrt(customers_n))
customers_moe = t_stat_cust * customer_sd / sqrt(customers_n)

round(customers_mean - customers_moe, 2)
round(customers_mean + customers_moe, 2)
