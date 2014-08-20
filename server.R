library(shiny)
library(datasets)
data(mtcars)

# Define server logic for random distribution application
shinyServer(function(input, output) {
    modelFit <- reactive({
        var <- input$variable
        if (length(var) > 0) {
            x <- paste(var,collapse='+')
            f <- paste('mpg ~ am + ',x,sep="")
            lm(f, data=mtcars)
        } else {
            lm(mpg ~ am, data=mtcars)
        }
    })
    output$plot <- renderPlot({
        plot(fitted(modelFit()),resid(modelFit()), main = "Residuals vs Fitted",
             xlab = "Fitted Values", ylab = "Residuals")
        abline(h=0)
    })
    output$summary <- renderPrint({
        summary(modelFit())$coeff
    })
    output$anova <- renderPrint({
        tFit <- lm(mpg ~ am, data=mtcars)
        anova(tFit,modelFit())
    })
    output$about <- renderUI({
    HTML('<p><span style="font-size: 13px; line-height: 1.6;">This shiny application
    looks at the dataset for 32 different car models (1973-1974) from
    the&nbsp;</span><em style="font-size: 13px; line-height: 1.6;">Motor
    Trend</em><span style="font-size: 13px; line-height: 1.6;">&nbsp;Magazine
    and attempts to answer the question</span></p>

    <ul>
        <li>Does automatic/manual transmission have any impact on mpg</li>
        </ul>

        <p>We use linear regression to attempt to answer this question.</p>

        <p>There are 3 tabs, the model summary tab shows the summary of the
        model as returned by&nbsp;<strong>lm</strong>&nbsp;function. The model
        comparison tab, compares the default model (mpg ~ am), with model (mpg ~
        am + <i>&lt;selected_variable&gt;</i>) using the anova function. The
        residuals plot tab, shows the residual plot for the model.</p>

        <p>&nbsp;By default when none of the variables are selected, the linear
        model just uses transmission (indicated by &#39;am&#39; in the dataset)
        as the predictor variable for determining mpg. By looking at just the
        transmission in isolation it seems to suggest that on average manual
        transmission gives better mpg than automatic transmission, better by
        about 7.245 miles to be precise. But when you add weight for e.g. as the
        predictor, we can see that each additional 1000 pound increase in
        weight, decreases the mpg by about 5 miles, and the higher p-value
        for&nbsp;<em>am</em>&nbsp;suggests that there is no evidence that
        transmission type affects mileage, other things being equal.</p>

        <p>The likelihood ratio test using anova,&nbsp;between the models that
        only has&nbsp;<em>am</em>&nbsp;vs. the model that has&nbsp;<em>am +
        wt&nbsp;</em>also suggests that we include am as the predictor as it
        increases the model fit, which can be seen by low p-value.</p>

        <p>User can include other variables like number of cylinders and horse
        power as well in the model, to see if including them gives a better
        model fit.</p>

        <p>The residual plot, plots the residuals on the y-axis and the
        predicted values on the x-axis. By observing the residual plot, we can
        see if the linear regression model is right for the data or not. If the
        point in the&nbsp;<strong>residual plot&nbsp;</strong>are randomly
        dispersed around the horizontal axis, a linear regression model is
        appropriate for the data; otherwise, a non-linear model is more
        appropriate.</p>')
        })
})
