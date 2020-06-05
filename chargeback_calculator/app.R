library(shiny)
library(dplyr)
library(connectapi)

ui <- fluidPage(
    
    titlePanel("Chargeback Estimator"),
    sidebarLayout(
        sidebarPanel(
            numericInput(
                "spend",
                "Total Spend",
                25000
            ),
            selectInput(
                "grps", 
                "Groups to Include", 
                choices = "", 
                selected = NULL, 
                multiple = TRUE
            ),
            actionButton(
                "refresh", 
                "Calculate"
            )
        ),
        
        mainPanel(
            DT::dataTableOutput("grp_spend")
        )
    )
)

server <- function(input, output, session) {
    
    if (Sys.getenv("CONNECT_SERVER") == "") stop("Please define 'CONNECT_SERVER' env var.")
    if (Sys.getenv("CONNECT_API_KEY") == "") stop("Please define 'CONNECT_APY_KEY' env var.")
    
    # Put groups into select input
    con <- connectapi::connect()
    grps_df <- reactive(connectapi::get_groups(con))
    observe({
        req(grps_df)
        updateSelectInput(
            session, 
            inputId = "grps",
            choices = grps_df()$name, 
            selected = grps_df()$name
        )
    })
    
    # Calculate chargeback for selected groups
    grps_selected <- reactive({
        req(grps_df)
        grps_df() %>%
            dplyr::filter(name %in% input$grps)
    })
    dat <- eventReactive(input$refresh, {
        grp_members <- purrr::map_dfr(
            grps_selected()$guid, 
            function(x){
                connectapi::get_group_members(con, x) %>%
                    dplyr::count()
            }) %>%
            dplyr::transmute(
                `Group Name` = grps_selected()$name,
                Members = n,
                `Spend Pct` = n / sum(n), 
                `Chargeback` = scales::dollar(`Spend Pct` * input$spend)) %>%
            dplyr::mutate(`Spend Pct` = scales::percent(`Spend Pct`))
        
    })
    
    output$grp_spend <- DT::renderDT(
        DT::datatable({
            req(dat)
            dat()
        })
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
