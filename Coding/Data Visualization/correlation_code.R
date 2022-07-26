install.packages("tidyverse")
library("readxl")

df <- read_excel("physical_limitations_mastersheet.xlsx",sheet="PercentVSMarriage")
cor(df[, 6], df[, 10], use = "complete.obs")
#cor(df$'Percent disabled', df$Single)
#cor(df$'Light', df$Percent_Disabled)
#cor(df$`Sit`, df$Mean_Age)
#cor(df$`Well Kept`, df$Mean_Age)
#cor(df$`Bike`, df$Mean_Age)
#cor(df$`Stop`, df$Mean_Age)
#cor(df$`Rest`, df$Mean_Age)
#cor(df$`Business`, df$Mean_Age)
#cor(df$`Nature`, df$Mean_Age)
#cor(df$`Countryside`, df$Mean_Age)

#cor(df$`Trail`, df$Income)

