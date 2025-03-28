box::use(
    shiny[moduleServer,
          NS,
          reactive],
    plotly[plotlyOutput,
           renderPlotly,
           plot_ly,
           layout],
    dplyr[mutate,
          group_by,
          summarize],
    lubridate[month]
)

#' @export
ui <- function(id){
    ns <- shiny::NS(id)
    plotly::plotlyOutput(ns("chart"))
}

#' @export
server <- function(id,data){
    shiny::moduleServer(id, function(input,output,session){
        output$chart <- plotly::renderPlotly(
            data() |>
                dplyr::mutate(month = lubridate::month(InvoiceDate)) |>
                dplyr::group_by(month) |>
                dplyr::summarize(total_revenue = sum(Revenue)) |>
                plotly::plot_ly(x = ~month,
                                y = ~total_revenue,
                                type="scatter",
                                mode="lines") |>
                plotly::layout(title = "Revenue by InvoiceDate",
                               xaxis = list(title = "Months"),
                               yaxis = list (title = "Revenues"))
                
        )
    }
    )
}






