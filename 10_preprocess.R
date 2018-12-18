set.seed(1030)
# get the data into the correct dimension
desc_path <- "./raw_data/Experiment Descriptor file.csv"
desc_data <- read.csv(desc_path, stringsAsFactors = FALSE)
GDS_path <- "./raw_data/GDS1390.csv"
GDS_data <- read.csv(GDS_path, stringsAsFactors = FALSE, na.strings=c("null"))

# dropping the first 2 cols ID_REF & IDENTIFIER
GDS <- GDS_data[,3:ncol(GDS_data)]
# transpose data and make it into a dataframe
GDS <- as.data.frame(t(GDS))
# test to see it transpose correctly
GDS[1,1:5] == GDS_data[1:5,3]
# test to see the length are the same
length(colnames(GDS)) == length(GDS_data[,2])

# set the col names after transposing
colnames(GDS) <- GDS_data[,2]

# check if there is any NA
check2 <- c(1,NA,2)
is.na(check2)
any(is.na(check2))

# check each col to see if there are any NA
na_result <- apply(GDS, 2, function(x) any(is.na(x)))

# create a list of col names that have NA
list_of_na <- c()
i <- 1
for (j in 1:length(na_result)) {
  if (na_result[[j]] == TRUE) {
    list_of_na[[i]] <- names(na_result[j])
    i <- i + 1
  }
}

# there are no NA sweeeeeet
GDS$disease.state <- desc_data$disease.state
GDS$disease.state

# rename the class to acroymn
state1 <- sub("^androgen-dependent prostate cancer*",
               "D", GDS$disease.state[1:10])
state2 <- sub("^androgen-independent prostate cancer*",
               "I", GDS$disease.state[11:20])
state <- c(state1, state2)
GDS$state <- state

# make sure the order is kept when renaming disease state
print(GDS[,c("state","disease.state")])

write.csv(GDS, file = "cleaned_data/GDS1390_preprocess.csv", row.names=FALSE)

