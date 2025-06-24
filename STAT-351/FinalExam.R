# 1.
n = 100
m = 7
sd = 3.5
1-pnorm(7.5, mean = m, sd = sd)


# 5.
shoppers = c(285, 221, 173, 358, 274, 216, 301)
n = length(shoppers)
m = mean(shoppers)
m
median = median(shoppers)
median
sd = sd(shoppers)
sd

# t-stat?
t_stat = (m - 200) / (sd/sqrt(n))
t_stat
p_val = 1 - pt(t_stat, n-1)
p_val <= 0.05

alpha = 1 - .98
1 - alpha / 2

# t_stat = qt(1 - alpha / 2, n - 1)
# t_stat

margin_of_error = t_stat * sd/sqrt(n)
margin_of_error

# Left endpoint
m - margin_of_error
# Right endpoint
m + margin_of_error

# t.test(shoppers, alternative="two.sided", conf.level=0.98)

t.test(shoppers, mu=200, alternative="greater")

# 6.
n = 800
p_hat = 656 / n
p_hat
p_0 = 0.80

z_stat = (p_hat - p_0) / sqrt((p_0 * (1 - p_0)) / n)
z_stat

p_val = 1 - pnorm(z_stat, m = 0, sd = 1)
p_val
p_val <= 0.05

prop.test(p_0, n, p=p_hat, alternative="greater")

# 9.
q10Data = read.csv("final_exam_q_10.csv")
mylm = lm(Price ~ Mileage, data=q10Data)
summary(mylm)

# 12.
q12data = read.csv("final_exam_q_12.csv")
mylm = lm(Attendance ~ Flyers + Color, data = q12data)
summary(mylm)
# P-value = 0.009677
attendance = mylm$coefficients[1]
attendance
flyers = mylm$coefficients[2]
flyers
color = mylm$coefficients[3]
color

attendance + (flyers*80) + (color*1)

mylm = lm(Attendance ~ Flyers + Color + Flyers*Color, data = q12data)
summary(mylm)
# P-value = 0.01865
# A-R2 = 0.8224
attendance = mylm$coefficients[1]
attendance
flyers = mylm$coefficients[2]
flyers
color = mylm$coefficients[3]
color

attendance + (flyers*80) + (color*1)


# 15.
107.1250 + 19.7321*16 + -70.7321*0 + -104.9167*0 + -68.9821*1
