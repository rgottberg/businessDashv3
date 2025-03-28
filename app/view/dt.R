box::use(
    shiny[moduleServer,
          NS,
          reactive],
    DT[dataTableOutput,
       renderDataTable,
       datatable]
)

#' @export
ui <- function(id){
    ns <- shiny::NS(id)
    DT::dataTableOutput(ns("table"))
}

#' @export
server <- function(id,data){
    shiny::moduleServer(id, function(input,output,session){
        output$table <- DT::renderDataTable(
            data() |>
                DT::datatable(class = 'cell-border stripe',
                              rownames = FALSE,
                              filter = 'top',
                              options = list(pageLength = 5))
        )
    }
    )
}