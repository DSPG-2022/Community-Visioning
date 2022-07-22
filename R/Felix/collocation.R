library(tidyverse)
library(ggwordcloud)
library(readxl)
library(udpipe)
library(textrank)
#model <- udpipe_download_model(language = "english")
word_frequency <- function(data, titl = "No title provided", udmodel, word_type = "NOUN",
                           top_n = 25) {
  require(udpipe)
  require(tidyverse)
  require(ggwordcloud)
  ud_model <- udpipe_load_model(udmodel$file_model)
  x <- as.data.frame(udpipe_annotate(ud_model, x = tolower(data)))
  stats <- x %>% filter(upos %in% word_type)
  stats <- txt_freq(x = stats$lemma)
  stats$key <- factor(stats$key, levels = rev(stats$key))
  stats <- head(stats, top_n)
  print(ggplot(stats, aes(label = key, size = freq, color = factor(sample.int(10, nrow(stats), replace = TRUE)))) +
          geom_text_wordcloud_area() +
          ggtitle(titl) +
          scale_size_area(max_size = 24) +
          theme(plot.title = element_text(hjust = 0.5)) +
          theme_minimal())
}
collocation <- function(data, titl = "No title provided", udmodel, word_type = "NOUN",
                        top_n = 25){
  require(udpipe)
  require(tidyverse)
  require(igraph)
  require(ggraph)
  require(ggplot2)
  ud_model <- udpipe_load_model(udmodel$file_model)
  x <- as.data.frame(udpipe_annotate(ud_model, x = tolower(data)))
  stats <- keywords_collocation(x = x, 
                                term = "token", 
                                group = c("doc_id", "paragraph_id", "sentence_id"),
                                ngram_max = 4)
  stats <- cooccurrence(x = subset(x, upos %in% word_type), 
                        term = "lemma", group = c("doc_id", "paragraph_id", "sentence_id"))
  stats <- cooccurrence(x = x$lemma, 
                        relevant = x$upos %in% word_type)
  stats <- cooccurrence(x = x$lemma, 
                        relevant = x$upos %in% word_type, skipgram = 2)
  wordnetwork <- head(stats, top_n)
  wordnetwork <- graph_from_data_frame(wordnetwork)
  
  print(ggraph(wordnetwork, layout = "fr") +
          geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "pink") +
          geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
          theme_graph(base_family = "Arial Narrow") +
          theme(legend.position = "none") +
          labs(title = titl))
}

### Farragut
farragut <- read_excel(file.choose())
glimpse(farragut)

# Farragut Challenges
collocation(farragut$...14, titl = "Farragut Challenges", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

# Farragut benefits
collocation(farragut$...15, titl = "Farragut Benefits", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

### Farragut Suggestions
collocation(farragut$...16, titl = "Farragut Suggestions", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

### logan 
logan <- read_excel(file.choose())
# logan Challenges
collocation(logan$...14, titl = "Logan Challenges", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

# logan benefits
collocation(logan$...15, titl = "Logan Benefits", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

### logan Suggestions
collocation(logan$...16, titl = "Logan Suggestions", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

### shellrock
shellrock <- read_excel(file.choose())
# shellrock Challenges
collocation(logan$...14, titl = "Shell Rock Challenges", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

# shellrock benefits
collocation(shellrock$...15, titl = "Shell Rock Benefits", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

### shellrock Suggestions
collocation(shellrock$...16, titl = "Shell Rock Suggestions", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)


#### algona older adults
algona <- read_csv(file.choose())
collocation(algona$`4      To begin our discussion of`, titl = "Algona Discussion", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)
word_frequency(algona$`4      To begin our discussion of`, titl = "Algona Discussion", udmodel = model, 
            word_type = c("NOUN", "ADJ", "VERB"),top_n = 50)

