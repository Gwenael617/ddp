library(shiny)

## reading and light processing
im3 <- read.csv("www/immigration.csv", stringsAsFactors = FALSE, 
                fileEncoding = 'latin1')
im3$country.background <- as.factor(im3$country.background)
pop3 <- read.csv("www/population.csv", stringsAsFactors = FALSE, 
                fileEncoding = 'latin1')

## extract the list of communes (length : 428)
listOfCommune <- sort(unique(im3$region))
## add an empty string to have an empty selectImput box at launch
listOfCommune <- c("", listOfCommune)  

shinyServer(
        function(input, output){
                ## create the choice menu for the sidebarPanel
                output$selectUI <- renderUI({
                        selectInput("municipality", 
                                    label= h3("Choose a commune"), 
                                    choices = listOfCommune)
                })
                ## create the right message to send to the user
                output$selection <- renderPrint({
                        if(is.null(input$municipality)){
                                cat("nothing, please select a Commune ",
                                    "and press update")
                        } else if(input$municipality == ""){
                                cat("nothing, please select a Commune ",
                                    "and press update")}
                        else{input$municipality}})
                output$selection2 <- renderPrint({input$year})
                output$statistics <- renderTable({
                        
                        yearSelected <- as.character(input$year)
                        a <- im3[im3$region == input$municipality 
                                 & im3$time == yearSelected,]
                        b <- pop3[pop3$region == input$municipality 
                                  & pop3$time == yearSelected,]
                        # create a percentage column
                        for(i in 1:6){
                        a[i,5] <- a[i,4]/b[1,4]*100
                        colnames(a)[5] <- "percentage of total population"
                        }
                        a
                        
                })
                output$p1 <- renderPlot({
                        ## avoid printing is nothing has been selected
                        if(!is.null(input$municipality)){
                        imPlot <- im3[im3$region == input$municipality,]
                        plot(x=imPlot[,2], 
                             y=imPlot[,4],
                             main = c("Immigration per World region in ",
                                      input$municipality),
                             xlab = "year", 
                             ylab=c("number of immigrants in ", 
                                    input$municipality),
                             ## add colors and plotting symbols
                             col=imPlot$country.background,
                             pch= c(15, 16, 8, 6, 7, 17)[imPlot[,3]])
                        legend(x= "topleft", 
                               legend = levels(im3$country.background),
                               col=1:length(im3$country.background), 
                               pch=c(15, 16, 8, 6, 7, 17))}})
        }
)