
# model and engine size

df <- read.csv("bmw.csv")

df_sorted <- df[order(df$mpg, decreasing=FALSE), ]
df_sorted[(df_sorted$fuelType != "Petrol") & (df_sorted$fuelType != "Diesel"), ]
df_sorted
df_sorted[(df_sorted$fuelType == "Petrol"), ]


table(df$engineSize)
nrow(df[df$engineSize == 0, ])
nrow(df[df$engineSize == 0 & df$fuelType == "Electric", ])
# 47 cars have an engine size of 0
# only 2 of them are actually electric

# chart code from https://rfortherestofus.com/2019/11/how-to-make-beautiful-tables-in-r
install.packages("huxtable", type="binary")
# library(huxtable)
library(dplyr)
df$engineSizeStr <- paste(no  quote(sprintf("%1.1f",df$engineSize)), "L", sep="")
count(df, engineSizeStr) %>% 
  as_huxtable(add_colnames=TRUE) %>% 
  set_all_borders(1) %>%
  set_bold(1, everywhere)

t <- table(df$fuelType)
nrow(df[df$fuelType == "Electric", ])
nrow(df[df$fuelType == "Electric" & df$engineSize != 0, ])
# there are 3 electric cars and 1 of them has a non-0 engine size

df[df$engineSize == 6.6, ]
# there are 2 6.6 liter V8s

table(df$model)
nrow(table(df$model))
# there are 24 different models
# 5 most common: 3, 1, 2, 5, 4

nrow(df[df$model == " 3 Series", ]) / nrow(df) * 100
nrow(df[df$model == " 1 Series", ]) / nrow(df) * 100
nrow(df[df$model == " 2 Series", ]) / nrow(df) * 100
nrow(df[df$model == " 5 Series", ]) / nrow(df) * 100
nrow(df[df$model == " 4 Series", ]) / nrow(df) * 100
# they take make 23%, 18%, 11%, 10%, and 9% of the dataset
# note that apparently every model has a proceeding space

# remove proceeding space
df$model <- substr(df$model, 2, nchar(df$model))

counts <- count(df, model)
counts <- counts[order(counts$n), ]

is_suv <- substr(counts$model, 1, 1) == "X"
suvs <- counts[is_suv, ]
counts_simplified <- counts[!is_suv, ]
counts_simplified <- rbind(counts_simplified, list("X models", sum(suvs$n)))
# simplified away all suvs into a single category

is_z <- substr(counts_simplified$model, 1, 1) == "Z"
zs <- counts_simplified[is_z, ]
counts_simplified <- counts_simplified[!is_z, ]
counts_simplified <- rbind(counts_simplified, list("Z models", sum(zs$n)))
# simplified away all Zs into a single category

is_m <- substr(counts_simplified$model, 1, 1) == "M"
ms <- counts_simplified[is_m, ]
counts_simplified <- counts_simplified[!is_m, ]
counts_simplified <- rbind(counts_simplified, list("M models", sum(ms$n)))
# simplified away all Ms into a single category

is_i <- substr(counts_simplified$model, 1, 1) == "i"
is <- counts_simplified[is_i, ]
counts_simplified <- counts_simplified[!is_i, ]
counts_simplified <- rbind(counts_simplified, list("I models", sum(is$n)))
# simplified away all Is into a single category

pie(counts_simplified$n, counts_simplified$model, radius=1.075)


