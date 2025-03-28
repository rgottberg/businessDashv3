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
    ns <- shiny::NS(id)
    reactable::reactableOutput(ns("table"))
}

#' @export
server <- function(id,data){
    shiny::moduleServer(id, function(input,output,session){
    output$table <- reactable::renderReactable(
        data() |>
            reactable::reactable()
        )
    }
    )
}

