# Takes as input a two-letter state abbreviation, an outcome, and a rank,
#   and returns the hospitals with that rank for mortality from the outcome
#   in that state.
#
#   Input:
#     state = chatacter (e.g. - CA, WA, OR)
#     outcome = character (only - heart attack, heart failure, pneumonia)
#     num = integer or character (e.g. - 1, 2, 3, ..., OR only - best, worst)

rankhospital <- function(state, outcome, num = 'best') {
    ## Read outcome data
    csvfile <- "healthcare_data/outcome-of-care-measures.csv"
    hospitaldata<- read.csv(csvfile, colClasses = "character")
    
    ## Check that inputs are valid
    state <- toupper(state)
    outcome <- tolower(outcome)
    if (is.numeric(num) && !is.integer(num)) {
        num <- as.integer(num)
        warning('Converting num to integer')
        print(paste('num set to', as.character(num), sep = ' '))
    }   else if (is.character(num)) {
        num <- tolower(num)
    }
    
    allstates <- unique(hospitaldata$State)
    alloutcomes <-c('heart attack', 'heart failure', 'pneumonia')
    
    if (!is.character(state) || !is.element(state, allstates)) {
            stop('invalid state')
    }   else if (!is.character(outcome) || !is.element(outcome, alloutcomes)) {
            stop('invalid outcome')
    }   else if (is.character(num) && !is.element(num, c('best', 'worst'))) {
            stop('invalid num')
    }   else if (num < 1) {
            stop('invalid num')
    }
    
    ## Return hospital name in that state with given rank of 30-day death rate
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
    hospitals <- hospitals[states == state]
    ranks <- order(deaths, hospitals)
    deaths <- deaths[ranks]
    hospitals <- hospitals[ranks]
    
    if (num == 'best') {
        num <- 1L
    }   else if (num == 'worst') {
        num <- length(deaths)
    }   else if (num > length(deaths)) {
        return(NA)
    }
    
    rankhospital <- hospitals[num]
}