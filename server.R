shinyServer(
    function(input, output)
    {
        dist <- reactive({
            if (input$disttype == "norm")
            {
                rnorm(input$number, input$normmean, input$normsd)
            }
            else if (input$disttype == "unif")
            {
                if(input$unifmin <= input$unifmax)
                    runif(input$number, input$unifmin, input$unifmax)
                else
                    runif(input$number, input$unifmax, input$unifmin)
            }
            else if (input$disttype == "lnorm")
            {
                rlnorm(input$number, input$logmean, input$logsd)
            }
            else if (input$disttype == "exp")
            {
                rexp(input$number, input$exprate);
            }
        });

        output$plot <- renderPlot({
            if (input$plottype == "scatter")
                scatter.smooth(dist(), col='lightblue', main='Scatter plot',
                               xlab = "Index", ylab = "Value")
            else if (input$plottype == "hist")
                hist(dist(), col='lightblue', main='Histogram',
                     xlab = "Value", ylab = "Frequency");
        })
        output$summary <- renderPrint({
            summary(dist())
        })
        output$table <- renderDataTable({
            data.frame(x = seq_along(along.with = dist()), y = dist())
        })
    }
)