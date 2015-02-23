library(shiny)
library(markdown)
shinyUI
(
    fluidPage
    (
        titlePanel("Distribution simulator"),
        helpText("Create, configure and display dynamic distributions"),
        sidebarLayout
        (
            sidebarPanel
            (
                helpText("1. Choose the type of plot to be represented"),
                radioButtons("plottype", "Plot type:",
                             c("Histogram" = "hist",
                               "Scatter plot" = "scatter")),

                helpText("2. Choose the type of distribution to be simulated"),
                radioButtons("disttype", "Distribution type:",
                             c("Normal" = "norm",
                               "Uniform" = "unif",
                               "Log-normal" = "lnorm",
                               "Exponential" = "exp")),

                conditionalPanel(condition = "input.disttype == 'norm'",
                    helpText("3. Normal distribution: select mean and standard deviation"),
                    sliderInput('normmean', 'Mean',
                                value = 0, min = -100, max = 100, step = 1),
                    sliderInput('normsd', 'Standard deviation',
                                value = 1, min = 0, max = 100, step = 1)),

                conditionalPanel(condition = "input.disttype == 'unif'",
                    helpText("3. Uniform distribution: select lower and upper limits (lower <= upper)"),
                    sliderInput('unifmin', 'Lower limit',
                                value = 0, min = -100, max = 100, step = 1),
                    sliderInput('unifmax', 'Upper limit',
                                value = 1, min = -100, max = 100, step = 1)),

                conditionalPanel(condition = "input.disttype == 'lnorm'",
                    helpText("3. Exponential distribution: select rate = 1/mean"),
                    sliderInput('logmean', 'Mean log',
                                value = 0, min = -100, max = 100, step = 1),
                    sliderInput('logsd', 'Standard deviation log',
                                value = 1, min = 0, max = 100, step = 1)),

                conditionalPanel(condition = "input.disttype == 'exp'",
                    helpText("3. Uniform distribution: select lower and upper limits (lower <= upper)"),
                    sliderInput('exprate', 'Rate',
                                value = 1, min = 1, max = 100, step = 1)),

                helpText("4. Choose the number of observations to simulate"),
                sliderInput('number', 'Number of observations',
                            value = 500, min = 10, max = 1000, step = 1)
            ),
            mainPanel
            (
                tabsetPanel
                (   type = "pills",
                    tabPanel("Plot",
                             wellPanel(helpText("Distribution plot"),
                                       plotOutput("plot"))),
                    tabPanel("Summary",
                             wellPanel(helpText("Distribution median, mean and quantiles"),
                                       verbatimTextOutput("summary"))),
                    tabPanel("Table", wellPanel(helpText("List of distribution values"),
                                                dataTableOutput("table"))),
                    tabPanel("Help", includeMarkdown("documentation.md"))
                )
            )
        )
    )
)