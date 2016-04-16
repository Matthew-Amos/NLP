require(shiny)
require(SnowballC)

# Load Functions
source("Prediction2.R")
source("Clean Text.R")

shinyServer(
  function(input, output) {
    tbl <- reactive({
      if(length(unlist(strsplit(input$text1, " "))) > 0) {
        txt <- CleanText(as.character(input$text1))
        temp <- getPred(txt)
        temp2 <- head(temp, 10)
        temp2 <- temp2[1:10,]
        temp2[apply(temp2, 1, function(r) all(is.na(r))),] <- ""
        
        temp <- data.frame(
          Prediction = temp2$Pred,
          Probability = temp2$Freq / sum(temp$Freq))

      } else {
        temp <- data.frame(Prediction = rep("", 10), Probability = rep("", 10))
      }
      
      temp
    })
    
    output$preds <- renderTable(tbl())
  }
)