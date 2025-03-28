box::use(
    shiny[titlePanel,
          reactive,
          moduleServer, 
          NS, 
          renderUI, 
          tags, 
          uiOutput],
    bslib[page_fluid,
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
    bslib::page_fluid(
        waiter::useWaiter(),
        waiter::waiterPreloader(),
        # app title ----
        shiny::titlePanel("Business-Oriented Dashboard"),
        # theme
        theme = bslib::bs_theme(
            bootswatch = "flatly",
            version = "5"),
        # sidebar layout with input and output definitions ----
        bslib::navset_card_pill(
            sidebar = bslib::sidebar(
                sidebar$ui(ns("sidebar1"))
            ),
            bslib::nav_panel(
                title = "Visualizations",
                bslib::layout_column_wrap(
                    width = "400px",
                    bslib::card(bslib::card_header("Plotly - Sales Trends"),
                         full_screen = T,
                         bslib::card_body(shinycssloaders::withSpinner(
                             plotly$ui(ns("chart1")),
                             type = 7))
                    ),
                    bslib::card(bslib::card_header("Highcharter - Top Products"),
                         full_screen = T,
                         bslib::card_body(shinycssloaders::withSpinner(
                             highcharter$ui(ns("chart2")),
                             type = 7))
                    ),
                )
            ),
            bslib::nav_panel(
                title = "DT",
                bslib::card(
                    bslib::card_header("DT - Interactive Transaction Table"),
                    full_screen = T,
                    bslib::card_body(shinycssloaders::withSpinner(
                        dt$ui(ns("table1")),
                        type = 7))
                )
            ),
            bslib::nav_panel(
                title = "Reactable",
                bslib::card(
                    bslib::card_header("Reactable - Customer Insights"),
                    full_screen = T,
                    bslib::card_body(shinycssloaders::withSpinner(
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
        data <- sidebar$server("sidebar1","app/data/cleaned_data.csv")
        plotly$server("chart1",data)
        highcharter$server("chart2",data)
        dt$server("table1",data)
        reactable$server("table2",data)
        }
    )
}