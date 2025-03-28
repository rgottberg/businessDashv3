box::use(
    shiny[moduleServer,
          NS,
          reactive,
          tagList,
          selectInput,
          dateRangeInput],
    shinyWidgets[pickerInput],
    rio[import],
    dplyr[filter]
    )

#' @export
ui <- function(id){
    ns <- shiny::NS(id)
    shiny::tagList(
        shinyWidgets::pickerInput(
            inputId = ns("country"),
            label = "Choose country",
            # choices = sort(unique(data_orig$Country)),
            choices = c("Argentina","Belgium", "Brazil"),
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

}

#' @export
server <- function(id,datafile){
    shiny::moduleServer(id, function(input,output,session){
        data <- shiny::reactive({
            datafile |>
                rio::import() |>
                # dplyr::filter(InvoiceDate >= input$period[1] & InvoiceDate <= input$period[2]) |>
                dplyr::filter(Country == input$country)
        })
        return(data)
        }
    )
    }