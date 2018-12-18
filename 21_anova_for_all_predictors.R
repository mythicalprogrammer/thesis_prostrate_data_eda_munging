# point of this is do anova to see which predictor are significant
# in determining the classes in tissue
# we're using one way anova

nc <- ncol(GDS)
# one less because last two columns are disase.state and state
# which are the responses
nc <- nc - 2

# this will keep the significant predictors
keep_pred <- c()
j <- 1
for (i in 1:nc) {
  # one way anova no interactions
  res.aov <- aov(GDS[[i]] ~ state, data = GDS)
  result <- summary(res.aov)
  p_val <- result[[1]]$`Pr(>F)`[[1]]
  if (p_val <= 0.05) {
    keep_pred[[j]] <- names(GDS[i])
    j <- j + 1
  }
}

# test the result with one of the predict that's in the list
res.aov <- aov(GDS$`200000_s_at` ~ state, data = GDS)
result <- summary(res.aov)
result[[1]]$`Pr(>F)`[[1]]



# variable selection (drop all the insignificant ones)
keep_pred[[j]] <- "state"
GDS_anova <- GDS[,names(GDS) %in% keep_pred]
write.csv(GDS_anova, file = "cleaned_data/GDS1390_after_anova.csv", row.names=FALSE)
