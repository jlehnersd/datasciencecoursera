# Takes as input an outcome and a rank, and returns the hospitals
#   with that rank for mortality from the outcome in all states.
#
#   Input:
#     outcome = character (only - heart attack, heart failure, pneumonia)
#     num = integer or character (e.g. - 1, 2, 3, ..., OR only - best, worst)

rankall <- function(outcome, num = 'best') {
    ## Read outcome data
    csvfile <- "healthcare_data/outcome-of-care-measures.csv"
    hospitaldata<- read.csv(csvfile, colClasses = "character")
    
    ## Check that inputs are valid
    outcome <- tolower(outcome)
    if (is.numeric(num) && !is.integer(num)) {
        num <- as.integer(num)
        warning('Converting num to integer')
        print(paste('num set to', as.character(num), sep = ' '))
    }   else if (is.character(num)) {
        num <- tolower(num)
    }
    
    allstates <- sort(unique(hospitaldata$State))
    alloutcomes <-c('heart attack', 'heart failure', 'pneumonia')
    
    if (!is.character(outcome) || !is.element(outcome, alloutcomes)) {
        stop('invalid outcome')
    }   else if (is.character(num) && !is.element(num, c('best', 'worst'))) {
        stop('invalid num')
    }   else if (num < 1) {
        stop('invalid num')
    }
    
    ## For each state, find the hospital of the given rank
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
    
    rankhospitals <- character(length(allstates))
    for (iState in 1:length(allstates)) {
        state <- allstates[iState]
        deaths_ <- deaths[states == state]
        hospitals_ <- hospitals[states == state]
        ranks <- order(deaths_, hospitals_)
        deaths_ <- deaths_[ranks]
        hospitals_ <- hospitals_[ranks]
        
        if (num == 'best') {
                rankhospitals[iState] <- hospitals_[1]
        }   else if (num == 'worst') {
                rankhospitals[iState] <- hospitals_[length(deaths_)]
        }   else if (num > length(deaths_)) {
                rankhospitals[iState] <- NA
        }   else {
                rankhospitals[iState] <- hospitals_[num]
        }
    }
    
    ## Return a data frame with the hospital names and the state abbreviation
    ranktable <- data.frame(hospital = rankhospitals, state = allstates)

}