
df <- read.csv("bmw.csv")
summary(df)

plot(engineSize ~ mpg, data=df)

df$fuelType

df_diesel <- df[df$fuelType == 'Diesel', ]

plot(engineSize ~ mpg, data=df_diesel)


df_petrol <- df[df$fuelType == 'Petrol', ]

df_petrol$mpg_adjusted = df_petrol$mpg / 1.2

boxplot(df_petrol$mpg_adjusted)


df$mpg_adjusted = df$mpg / 1.2

library(ggplot2)

ggplot(df, aes(x = model, y = mpg_adjusted)) +
  geom_boxplot()


