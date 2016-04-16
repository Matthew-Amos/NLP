require(data.table)

freq1 <<- freq1
freq2 <<- freq2
freq3 <<- freq3

getPred <- function(term, spliton = "_") {
  terms <- unlist(strsplit(term, spliton))
  preds <- c()
  
  if(length(terms)>=2)
    preds <- getn3Pred(terms[length(terms)-1], terms[length(terms)])
  
  if(length(terms)==1 | predFailed(preds))
    preds <- getn2Pred(terms[length(terms)])
  
  if(length(terms)==0 | predFailed(preds))
    preds <- getn1Pred()
  
  preds
}

# validate preds
predFailed <- function(df) {
  if(class(df)[[1]] != "data.table")
    return(T)
  if(length(df)==0)
    return(T)
  if(nrow(na.omit(df))==0)
    return(T)
  return(F)
}

# Trigram prediction
getn3Pred <- function(t1, t2) {
  temp <- freq3[t1]
  if(nrow(temp) > 0) {
    setkey(temp, w2)
    temp <- temp[t2]
  }
  setorderv(temp, colnames(temp)[ncol(temp)], order=-1)
  temp
}

# Bigram prediction
getn2Pred <- function(t1) {
  temp <- freq2[t1]
  setorderv(temp, colnames(temp)[ncol(temp)], order=-1)
  temp
}

# Unigram prediction
getn1Pred <- function() {
  temp <- freq1
  setorderv(freq1, colnames(freq1)[ncol(freq1)], order=-1)
  temp
}