library(shiny)

set.seed(12321)

generateSample <- function(size, distribution){
        if(distribution=="unif") runif(size)
        else if(distribution=="norm") rnorm(size)
        else if(distribution=="pois") rpois(size, lambda=4.0)
        else rexp(size)
}

calculateMean <- function(distribution){
        if(distribution=="unif") 0.5
        else if(distribution=="norm") 0
        else if(distribution=="pois") 4
        else 1
}

calculateVar <- function(distribution){
        if(distribution=="unif") sqrt(1/12)
        else if(distribution=="norm") 1
        else if(distribution=="pois") 2
        else 1
}

shinyServer(
        function(input, output){
                output$summary <- renderPrint({
                                x <- generateSample(input$n * input$trial, input$distribution)
                                mat <- matrix(x, input$trial, input$n)
                                dat <- apply(mat, 1, mean)
                                        data.frame(
                                                type=c("Theoretical","Actual","Difference"),
                                                mean=c(calculateMean(input$distribution),
                                                       mean(dat),
                                                       calculateMean(input$distribution)-mean(dat)),
                                                std=c(calculateVar(input$distribution)/sqrt(input$n),
                                                      sqrt(var(dat)),
                                                      calculateVar(input$distribution)/sqrt(input$n)-sqrt(var(dat)))
                                                )
                })

                output$newPlot <- renderPlot({
                        x <- generateSample(input$n * input$trial, input$distribution)
                        mat <- matrix(x, input$trial, input$n)
                        dat <- apply(mat, 1, mean)
                        par(mfrow=c(1,2))
                        hist(mat[1,], 10, xlab="Sample",col="lightblue",
                             main="Histogram of Samples (the 1st trial)", probability = TRUE)
                        hist(dat, 20, xlab="Sample Mean",col="lightblue",
                             main="Histogram of Sample Mean", probability = TRUE)
                        curve(dnorm(x, mean=calculateMean(input$distribution),
                                    sd=calculateVar(input$distribution)/sqrt(input$n)),add=TRUE)
                })
        }
)
