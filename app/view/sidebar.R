box::use(
    shiny[moduleServer,
          NS,
          reactive,
          tagList,
          selectInput,
          dateRangeInput,
          uiOutput,
          renderUI,
          req],
    shinyWidgets[pickerInput],
    rio[import],
    dplyr[filter]
    )

#' @export
ui <- function(id){
    ns <- NS(id)
    uiOutput(ns("sidebar"))
    }

#' @export
server <- function(id,data){
    moduleServer(id, function(input,output,session){
        ns <- session$ns
        output$sidebar <- renderUI ({
            tagList(
                pickerInput(
                    inputId = ns("country"),
                    label = "Choose country",
                    choices = sort(unique(data$Country)),
                    multiple = TRUE,
                    selected = "Belgium",
                    options = list(
                        `actions-box` = TRUE
                    )
                ),
                # dateRangeInput(
                #     inputId = ns("period"),
                #     label = "Choose period",
                #     min = min(data$InvoiceDate),
                #     max = max(data$InvoiceDate),
                #     start=c(max(data$InvoiceDate) %m-% months(6)),
                #     end=max(data$InvoiceDate)
                # ),
                selectInput(
                    inputId = ns("format"),
                    label = "Select File Format",
                    choices = sort(c("CSV"="csv","Excel"="xlsx"))
                ),
            )
        })
        data2 <- reactive({
            req(input$country)  
            data |>
                # filter(InvoiceDate >= input$period[1] & InvoiceDate <= input$period[2]) |>
                filter(Country == input$country)
        })
        return(data2)
        }
    )
    }