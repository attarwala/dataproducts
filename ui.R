library(shiny)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Does transmission have impact on mpg"),

  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(
    checkboxGroupInput("variable", "Variable:",
                   c("Cylinders" = "cyl",
                     "Horse Power" = "hp",
                     "Weight" = "wt"))

  ),

  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("About", htmlOutput("about")),
      tabPanel("Model Summary", verbatimTextOutput("summary")),
      tabPanel("Model Comparison", verbatimTextOutput("anova")),
      tabPanel("Residuals Plot", plotOutput("plot"))
    )
  )
))
