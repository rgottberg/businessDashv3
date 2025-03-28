# uiOutput (to render sidebar elements in the server)
# req(id ofuioutput)


box::use(
    shiny[moduleServer,
          NS,
          reactive,
          tagList,
          selectInput,
          dateRangeInput,
          uiOutput,
          renderUI],
    shinyWidgets[pickerInput],
    rio[import],
    dplyr[filter]
    )

#' @export
ui <- function(id){
    ns <- shiny::NS(id)
    shiny::uiOutput(ns("sidebar"))
    }

#' @export
server <- function(id,data){
    shiny::moduleServer(id, function(input,output,session){
        ns <- shiny::NS(id)
        output$sidebar <- shiny::renderUI ({
            shiny::tagList(
                shinyWidgets::pickerInput(
                    inputId = ns("country"),
                    label = "Choose country",
                    choices = sort(unique(data$Country)),
                    multiple = TRUE,
                    selected = "Belgium",
                    options = list(
                        `actions-box` = TRUE
                    )
                ),
                # shiny::dateRangeInput(
                #     inputId = ns("period"),
                #     label = "Choose period",
                #     min = min(data$InvoiceDate),
                #     max = max(data$InvoiceDate),
                #     start=c(max(data$InvoiceDate) %m-% months(6)),
                #     end=max(data$InvoiceDate)
                # ),
                shiny::selectInput(
                    inputId = ns("format"),
                    label = "Select File Format",
                    choices = sort(c("CSV"="csv","Excel"="xlsx"))
                ),
            )
        })
        data2 <- shiny::reactive({
            data |>
                
                # dplyr::filter(InvoiceDate >= input$period[1] & InvoiceDate <= input$period[2]) |>
                # dplyr::filter(Country == input$country)
                dplyr::filter(Country == "Belgium")
        })
        return(data2)
        }
    )
    }