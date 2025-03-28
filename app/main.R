box::use(
    shiny[titlePanel,
          reactive,
          moduleServer, 
          NS, 
          renderUI, 
          tags, 
          uiOutput],
    bslib[bs_theme,
          page_fluid,
          navset_card_pill,
          sidebar,
          nav_panel,
          card,
          card_header,
          card_body,
          layout_column_wrap],
    shinycssloaders[withSpinner],
    waiter[useWaiter,
           waiterPreloader]
)

box::use(app/view/sidebar)
box::use(app/view/plotly)
box::use(app/view/highcharter)
box::use(app/view/dt)
box::use(app/view/reactable)


# Define UI --------------------Country# Define UI ---------------------------------------------------------------
#' @export
ui <- function(id) {
    ns <- NS(id)
    page_fluid(
        useWaiter(),
        waiterPreloader(),
        # app title ----
        titlePanel("Business-Oriented Dashboard"),
        # theme
        theme = bs_theme(
            bootswatch = "flatly",
            version = "5"),
        # sidebar layout with input and output definitions ----
        navset_card_pill(
            sidebar = sidebar(
                sidebar$ui(ns("sidebar1"))
            ),
            nav_panel(
                title = "Visualizations",
                layout_column_wrap(
                    width = "400px",
                    card(card_header("Plotly - Sales Trends"),
                         full_screen = T,
                         card_body(withSpinner(
                             plotly$ui(ns("chart1")),
                             type = 7))
                    ),
                    card(card_header("Highcharter - Top Products"),
                         full_screen = T,
                         card_body(withSpinner(
                             highcharter$ui(ns("chart2")),
                             type = 7))
                    ),
                )
            ),
            nav_panel(
                title = "DT",
                card(
                    card_header("DT - Interactive Transaction Table"),
                    full_screen = T,
                    card_body(withSpinner(
                        dt$ui(ns("table1")),
                        type = 7))
                )
            ),
            nav_panel(
                title = "Reactable",
                card(
                    card_header("Reactable - Customer Insights"),
                    full_screen = T,
                    card_body(withSpinner(
                        reactable$ui(ns("table2")),
                        type = 7))
                )
            )
        )
    )
}
# Define server logic -----------------------------------------------------

#' @export
server <- function(id){
    moduleServer(id, function(input,output,session){
        data <- rio::import("app/data/cleaned_data.csv")
        data2 <- sidebar$server("sidebar1",data) 
        plotly$server("chart1",data2)
        highcharter$server("chart2",data2)
        dt$server("table1",data2)
        reactable$server("table2",data2)
        }
    )
}