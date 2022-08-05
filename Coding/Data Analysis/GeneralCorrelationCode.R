#Base code can be used on any data set
#between survey question and demographic data


install.packages("tidyverse")
library("readxl")
#read any excel of choice
df <- read_excel("Q3_travel.xlsx",sheet=6)
#Use this line of code to call columns using numerical order
#cor(df[,3], df[,9], use = "complete.obs")
#Use this line of code to call columns using names
cor(df$Carpool,df$Widowed, use="complete.obs")

#Example of columns name and correlations
#cor(df$`Light`, df$Widowed)
#cor(df$`Sit`, df$Widowed)
#cor(df$`Well Kept`, df$Widowed)
#cor(df$`Stop`, df$Widowed)
#cor(df$`Rest`, df$Widowed)
#cor(df$`Business`, df$Widowed)
#cor(df$`Nature`, df$Widowed)
#cor(df$`Countryside`, df$Widowed)
#cor(df$`Trail`, df$Widowed)
#cor(df$`Bird`, df$Widowed)
#cor(df$`Bike`, df$Widowed)

