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
          slice_head]
)

#' @export
ui <- function(id){
    ns <- shiny::NS(id)
    highcharter::highchartOutput(ns("chart"))
}

#' @export
server <- function(id,data){
    shiny::moduleServer(id, function(input,output,session){
        output$chart <- highcharter::renderHighchart(
            data() |>
                dplyr::group_by(StockCode) |>
                dplyr::summarize(total_quantity = sum(Quantity)) |>
                dplyr::arrange(desc(total_quantity)) |>
                dplyr::slice_head(n=10) |>
                highcharter::hchart("column", highcharter::hcaes(x = StockCode, y = total_quantity),
                                    color = "#0198f9", name = "Quantity sold per product") |>
                highcharter::hc_title(text = "Top 10  products") |>
                highcharter::hc_xAxis(title = list(text = "Product")) |>
                highcharter::hc_yAxis(title = list(text = "Quantity"))
        )
    }
    )
}
