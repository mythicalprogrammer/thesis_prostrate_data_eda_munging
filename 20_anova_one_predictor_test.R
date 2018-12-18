# Run anova for the first predictor and check the p-value
res.aov <- aov(GDS[[1]] ~ state, data = GDS)
result <- summary(res.aov)
result[[1]]$`Pr(>F)`[[1]]
