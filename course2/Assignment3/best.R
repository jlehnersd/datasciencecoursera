# Takes as input a two-letter state abbreviation and an outcome,
#   and returns the hospital with the lowest mortality rate for 
#   that outcome in that state.
#
#   Input:
#     state = chatacter (e.g. - CA, WA, OR)
#     outcome = character (only - heart attack, heart failure, pneumonia)

best <- function(state, outcome) {
    ## Read outcome data
    csvfile <- "healthcare_data/outcome-of-care-measures.csv"
    hospitaldata<- read.csv(csvfile, colClasses = "character")

    ## Check that state and outcome are valid
    state <- toupper(state)
    outcome <- tolower(outcome)
    
    allstates <- unique(hospitaldata$State)
    alloutcomes <-c('heart attack', 'heart failure', 'pneumonia')
    
    if (!is.character(state) || !is.element(state, allstates)) {
            stop('invalid state')
    }   else if (!is.character(outcome) || !is.element(outcome, alloutcomes)) {
            stop('invalid outcome')
    }
    
    ## Return hospital name in that state with lowest 30-day death rate
    if (outcome == 'heart attack') {
        colnum <- 11L
    }   else if (outcome == 'heart failure') {
        colnum <- 17L
    }   else {
        colnum <- 23L
    }
    
    states <- hospitaldata$State
    deaths <- (hospitaldata[[colnum]])
    hospitals  <- hospitaldata$Hospital.Name
    
    valid <- !is.na(states) & !is.na(deaths) & deaths != 'Not Available'
    
    states <- states[valid]
    deaths <- as.numeric(deaths[valid])
    hospitals  <- hospitals[valid]
    
    deaths <- deaths[states == state]
    hospitals  <- hospitals[states == state]
    bests  <- which(deaths == min(deaths))
    
    hospitals <- sort(toupper(hospitals[bests]))
    besthospital <- hospitals[1]
}