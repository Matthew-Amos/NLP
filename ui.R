require(shiny)

shinyUI(
  fluidPage(theme="styles.css",
    titlePanel("Natural Language Prediction"),
    sidebarLayout(
      sidebarPanel(
        h3("Introduction"),
        p("This app will try to predict the next word you are about to type.
          It will show you the top 10 predicted results and their probability
          within the observed sample space."),
        p("So get typing!"),
        p("Link to github"),
        p("Link to pitch")
      ),
      mainPanel(
        textInput(inputId="text1", 
                  label = "", 
                  placeholder = "start typing..."),
        tableOutput('preds')
      )
    )
  )
)