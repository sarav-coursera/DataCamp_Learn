library(tm)
library(wordcloud)
library(ggplot2)

# tfile=read.table("C:\Users\Janaki\Documents\CodeLib\R\TextMining\GE_BusinessDescription.txt")
# library(readr)
# GE_BusinessDescription <- read_delim("~/CodeLib/R/TextMining/GE_BusinessDescription.csv", 
    # "\t", escape_double = FALSE, col_names = FALSE, 
    # trim_ws = TRUE)
# View(GE_BusinessDescription)

docs2_1=Corpus(VectorSource(docs2))
ge_tdm=TermDocumentMatrix(docs2_1)
ge_tdm_matrix=as.matrix(ge_tdm)
# get word counts in decreasing order
word_freqs = sort(rowSums(ge_tdm_matrix), decreasing=TRUE)

# create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

#Plot Histogram
p <- ggplot(subset(dm, freq>10), aes(word, freq))
p <-p+ geom_bar(stat="identity")
p <-p+ theme(axis.text.x=element_text(angle=45, hjust=1))
p

#Plot Wordcloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(6, "Dark2"),min.freq=10, scale=c(4,.2),rot.per=.15,max.words=100)