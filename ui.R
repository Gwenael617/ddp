library(shiny)

shinyUI(pageWithSidebar(
        # application title
        headerPanel("Norway : Immigration per Commune"),
        sidebarPanel(
                # Import the select box created in server.R
                htmlOutput("selectUI"),
                numericInput("year", "Select the year of observation", 2015,
                             min = 1986, max = 2015, step = 1),
                helpText("Note : data are only available for the years ","
                         1986 to 2015"),
                submitButton("update"),
                br(),
                em("This app will generate a table and a plot")
                ),
        mainPanel(
            tabsetPanel(
                tabPanel("App", 
                         h4('you entered'),
                         verbatimTextOutput("selection"),
                         verbatimTextOutput("selection2"),
                         tableOutput("statistics"),
                         plotOutput("p1"),
                         br()
                         ),
                tabPanel("Definitions",
                         br(),
                         p("According to the documentation of the datasets :"),
                         p("A", strong("Commune"), 
                                "is the Norwegian administrative
                                district equivalent to a", 
                                a("municipality", 
                                href="http://en.wikipedia.org/wiki/List_of_municipalities_of_Norway",
                                target = "_blank")),
                         p(strong("Immigrants"), 
                                ": These are persons born abroad of 
                                two foreign-born parents and four 
                                foreign-born grandparents. 
                                Immigrants emigrated to Norway at some point."),

                         p(strong("Norwegian-born to immigrant parents"), 
                                ": are persons who are born in Norway of two
                                parents born abroad, and in addition have
                                four grandparents born abroad."),
                           
                         p("Country of birth is mainly the mother's place of
                                residence at the time of the birth of the 
                                child."),
                           
                         p(strong("Country background"),
                           "is the person's own, their
                           mother's or possibly their father's country of 
                           birth. Persons without an immigrant background 
                           only have Norway (000) as their country background.
                           When both parents are born abroad they are in most
                           cases born in the same country. In cases where the
                           parents have different countries of birth, the
                           mother's country of birth is chosen."),
                         br(),
                         p("sources of the data : ",
                         a("immigration",
                         href="http://data.ssb.no/api/v0/dataset/48657?lang=en",
                         target="_blank"), # to open in a new tab automatically
                         a("population",
                         href="http://data.ssb.no/api/v0/dataset/104857?lang=en",
                         target="_blank"))
                         ),
                tabPanel("How to use it",
                         br(),
                         p(strong("How to use it :"),
                           "Select a commune and a year, 
                           then press the update button."),
                         br(),
                         p(strong("Results :"),
                           "The app will render", strong("a table"),
                           "displaying the number of immigrants per 
                           world region for the commune and year selected.", 
                           strong("The plot"), "will show the trends for 
                           this Commune since 1986"),
                         br(),
                         p(strong("Warning :"), "this app is not to be used
                           for wrongful or intolerant purpose"),
                         br(),
                         em("Note : It seems that the main driver of immigration
                           in Norway in the last five to ten years is coming
                           from within the other European countries"))
                ))
))