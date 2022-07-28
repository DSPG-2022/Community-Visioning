library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

algona <- read_csv(file.choose())
groups <- iconv(algona$`4      To begin our discussion of`)
s <- get_nrc_sentiment(groups)
head(s)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Algona Sentiment Scores')
#######
aplington <- read_csv(file.choose())
groups <- iconv(aplington$`1`)
s <- get_nrc_sentiment(groups)
head(s)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Aplington Sentiment Scores')
######
dunlap <- read_csv(file.choose())
groups <- iconv(dunlap$`Dunlap older adults.  All`)
s <- get_nrc_sentiment(groups)
head(s)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Dunlap Sentiment Scores')
#####
riverside <- read_csv(file.choose())
groups <- iconv(riverside)
s <- get_nrc_sentiment(groups)
head(s)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Riverside Sentiment Scores')
