demographics <- read.csv("Assignments\Assignment 6\Demographics.csv")

# 1.a
# Sample Statistics
demo_age_n = length(demographics$Age)
demo_age_n
demo_age_sd = sd(demographics$Age)
demo_age_sd
demo_age_mean = mean(demographics$Age)
demo_age_mean

age_alpha = 1 - .90
1 - age_alpha / 2

# Find 90% confidence interval for age: a = 1 - 0.9, 1 - a/2 = 0.95
t_stat_demo_age = qt(1 - age_alpha / 2, demo_age_n - 1)
t_stat_demo_age

demo_age_margin_of_error = t_stat_demo_age * demo_age_sd/sqrt(demo_age_n)
demo_age_margin_of_error

# Left endpoint
demo_age_mean - demo_age_margin_of_error
# Right endpoint
demo_age_mean + demo_age_margin_of_error

t.test(demographics$Age, alternative="two.sided", conf.level=0.90)

print("We are 90% confident that the true mean of the age of the demographics is between (39.62, 40.62)")


# --------------------------------------------------------------------------------------------------------------------------------------

# 1.b
# married_prop = prop.table(table(demographics$Married))[2]
married_prop = mean(demographics$Married == 'Y')
married_prop
married_n = length(demographics$Married)
married_n

married_alpha = 1 - .95
1 - married_alpha / 2

z_stat_married = qnorm(1 - married_alpha / 2, mean=0, sd=1)
z_stat_married

# Left endpoint
married_prop - z_stat_married * sqrt(married_prop * (1 - married_prop) / married_n)
# Right endpoint
married_prop + z_stat_married * sqrt(married_prop * (1 - married_prop) / married_n)

married_sum = length(which(demographics$Married == 'Y'))
married_sum

prop.test(x=married_sum, n=married_n, alternative="two.sided", conf.level=.95, correct=FALSE)

print("We are 95% confident that the percentage of married households is between 62.4% and 68.7%.")

# --------------------------------------------------------------------------------------------------------------------------------------

# 1.c
income_gt_100th_prop = mean(demographics$Income >= 100)
income_gt_100th_prop
income_gt_100th_n = length(demographics$Income >= 100)
income_gt_100th_n

income_gt_100th_alpha = 1 - .99
1 - income_gt_100th_alpha / 2

z_stat_income_gt_100th = qnorm(1-income_gt_100th_alpha / 2, mean=0, sd=1)
z_stat_income_gt_100th

# Left endpoint
income_gt_100th_prop - z_stat_income_gt_100th * sqrt((income_gt_100th_prop * (1 - income_gt_100th_prop)) / income_gt_100th_n)
# Right endpoint
income_gt_100th_prop + z_stat_income_gt_100th * sqrt((income_gt_100th_prop * (1 - income_gt_100th_prop)) / income_gt_100th_n)

income_gt_100th_sum = length(which(demographics$Income >= 100))
income_gt_100th_sum

prop.test(x=income_gt_100th_sum, n=income_gt_100th_n, alternative="two.sided", conf.level=.99, correct=FALSE)

print("We are 99% confident that the percentage of households with incomes greater than 100,000 is between 20.2% and 27.6%.")

# --------------------------------------------------------------------------------------------------------------------------------------

# 2.b
t_stat_age = (demo_age_mean - 40) / (demo_age_sd / sqrt(demo_age_n))
t_stat_age

degrees_of_freedom = demo_age_n - 1
degrees_of_freedom


1 - pt(t_stat_age, degrees_of_freedom)

t.test(demographics$Age, mu=40, alternative="greater")

