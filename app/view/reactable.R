box::use(
    shiny[moduleServer,
          NS,
          reactive],
    reactable[reactableOutput,
              renderReactable,
              reactable]
)

#' @export
ui <- function(id){
    ns <- NS(id)
    reactableOutput(ns("table"))
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

