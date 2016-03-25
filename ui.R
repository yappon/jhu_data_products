library(shiny)
shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Central Limit Theorem Simulation"),

                sidebarPanel(
                        h5(a("Help - How to use this application", 
                             href="https://github.com/yappon/jhu_data_products/wiki/Central-Limit-Theorem-Simulation-Application")),

                        selectInput("distribution", "Distribution:",
                                    selected = "unif",
                                    list("Uniform[0:1]" = "unif",
                                         "Normal[0,1]" = "norm",
                                         "Poisson(4)" = "pois",
                                         "Exponential(1)" = "exp")
                                    ),
                        numericInput(inputId = "n", value = 40, label = "Sampling size",
                                     min = 10, max=400, step=10),
                        numericInput(inputId = "trial", value = 1000,
                                     label = "The number of trials", min = 500, max = 2000, step=50)
                ),

                mainPanel(
                        h3("Output"),
                        h4("Theoretical vs. Actual"),
                        verbatimTextOutput("summary"),
                        h4("Simulation Output"),
                        plotOutput("newPlot")
                )

))
