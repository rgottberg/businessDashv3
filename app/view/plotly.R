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
    lubridate[month],
    bslib[sidebar,
          card,
          card_header,
          card_body,
          layout_column_wrap],
    shinycssloaders[withSpinner],
)

#' @export
ui <- function(id){
    ns <- shiny::NS(id)
    card(card_header("Plotly - Sales Trends"),
         full_screen = T,
         card_body(withSpinner(
             plotlyOutput(ns("chart")),
             type = 7))
    )
}

#' @export
server <- function(id,data){
    shiny::moduleServer(id, function(input,output,session){
        output$chart <- renderPlotly(
            data() |>
                mutate(month = month(InvoiceDate)) |>
                group_by(month) |>
                summarize(total_revenue = sum(Revenue)) |>
                plot_ly(x = ~month,
                                y = ~total_revenue,
                                type="scatter",
                                mode="lines") |>
                layout(title = "Revenue by InvoiceDate",
                               xaxis = list(title = "Months"),
                               yaxis = list (title = "Revenues"))
                
        )
    }
    )
}






