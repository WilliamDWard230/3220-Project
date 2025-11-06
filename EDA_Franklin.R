
df <- read.csv("bmw.csv")
summary(df)

plot(engineSize ~ mpg, data=df)

df$fuelType

df_diesel <- df[df$fuelType == 'Diesel', ]

plot(engineSize ~ mpg, data=df_diesel)
