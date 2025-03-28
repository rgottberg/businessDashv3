box::use(
    shiny[moduleServer,
          NS,
          reactive],
    reactable[reactableOutput,
              renderReactable,
              reactable],
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
    card(
        card_header("Reactable - Customer Insights"),
        full_screen = T,
        card_body(withSpinner(
            reactableOutput(ns("table")),
            type = 7))
    )
}

#' @export
server <- function(id,data){
    moduleServer(id, function(input,output,session){
    output$table <- renderReactable(
        data() |>
            reactable()
        )
    }
    )
}

