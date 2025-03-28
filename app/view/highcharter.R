box::use(
    shiny[moduleServer,
          NS,
          reactive],
    highcharter[highchartOutput,
                renderHighchart,
                hchart,
                hcaes,
                hc_title,
                hc_xAxis,
                hc_yAxis],
    dplyr[group_by,
          summarize,
          arrange,
          slice_head],
    bslib[sidebar,
          card,
          card_header,
          card_body,
          layout_column_wrap],
    shinycssloaders[withSpinner],
)

#' @export
ui <- function(id){
    ns <- NS(id)
    card(card_header("Highcharter - Top Products"),
         full_screen = T,
         card_body(withSpinner(
             highchartOutput(ns("chart")),
             type = 7))
    )
}

#' @export
server <- function(id,data){
    moduleServer(id, function(input,output,session){
        output$chart <- renderHighchart(
            data() |>
                group_by(StockCode) |>
                summarize(total_quantity = sum(Quantity)) |>
                arrange(desc(total_quantity)) |>
                slice_head(n=10) |>
                hchart("column", hcaes(x = StockCode, y = total_quantity),
                                    color = "#0198f9", name = "Quantity sold per product") |>
                hc_title(text = "Top 10  products") |>
                hc_xAxis(title = list(text = "Product")) |>
                hc_yAxis(title = list(text = "Quantity"))
        )
    }
    )
}
