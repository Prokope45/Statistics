
n = 1026
p = 0.47

(n * p) >= 5
n * (1 - p) >= 5

alpha = 1 - .95
1 - alpha / 2

z_stat = round(qnorm(1 - alpha / 2, 0, 1), 3)
z_stat

moe = z_stat * sqrt((p * (1 - p)) / n)
moe

round(p - moe, 3)
round(p + moe, 3)
