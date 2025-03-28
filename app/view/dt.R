box::use(
    shiny[moduleServer,
          NS],
    DT[dataTableOutput,
       renderDataTable,
       datatable]
    )

#' @export
ui <- function(id){
    ns <- NS(id)
    dataTableOutput(ns("table"))
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