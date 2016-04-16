require(tm)

cleanFuns <- list(
  removePunctuation,
  stripWhitespace,
  removeNumbers,
  tolower,
  stemDocument
)

CleanText <- function(txt) {
  txt <- MC_tokenizer(txt)
  
  for(f in cleanFuns) {
    txt <- f(txt)
  }
  
  paste(txt, sep="", collapse="_")
}
