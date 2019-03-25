complete <- function(directory, id = 1:332) {
    
    id_ <- as.character(id)
    nID <- length(id)
    for (i in 1:nID) {
        if (id[i] < 10) {
            id_[i] <- paste("00", id_[i], sep = "")
        } else if (id[i] < 100) {
            id_[i] <- paste("0", id_[i], sep = "")
        } else {
            
        }
    }
    
    filenames <- paste(directory, "/", id_, ".csv", sep = "")
    
    nFiles  <- length(filenames)
    nSamples <- integer(nFiles)
    for (iFile in 1:nFiles) {
        
        file <- filenames[iFile]
        data <- read.csv(file)
        
        nitratelevels_ <- as.numeric(data$nitrate)
        sulfatelevels_ <- as.numeric(data$sulfate)
        
        fullset = !is.na(nitratelevels_) & !is.na(sulfatelevels_)
        nSamples[iFile] <- length(fullset[fullset])
    }
    
    completeobs = data.frame(id = id, nobs = nSamples)
    #print(completeobs)
    completeobs
}