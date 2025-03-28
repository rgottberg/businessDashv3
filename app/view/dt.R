box::use(
    shiny[moduleServer,
          NS],
    DT[dataTableOutput,
       renderDataTable,
       datatable],
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
        card_header("DT - Interactive Transaction Table"),
        full_screen = T,
        card_body(withSpinner(
            dataTableOutput(ns("table")),
            type = 7))
    )
}

#' @export
server <- function(id,data){
    moduleServer(id, function(input,output,session){
        output$table <- renderDataTable(
            data() |>
                datatable(class = 'cell-border stripe',
                              rownames = FALSE,
                              filter = 'top',
                              options = list(pageLength = 5))
        )
    }
    )
}