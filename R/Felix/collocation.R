library(tidyverse)
library(ggwordcloud)
library(readxl)
library(udpipe)
library(textrank)
#model <- udpipe_download_model(language = "english")
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

### 
logan <- read_excel(file.choose())

