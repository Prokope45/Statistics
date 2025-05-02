n = 2100
p = 693 / n

(n * p) >= 5
n * (1 - p) >= 5

alpha = 1 - 0.90
1 - alpha / 2

z_stat = round(qnorm(1 - alpha / 2, 0, 1), 3)
z_stat

moe = z_stat * sqrt((p * (1 - p)) / n)
moe

round(p - moe, 3)
round(p + moe, 3)

prop.test(693, 2100, conf.level = .90)
