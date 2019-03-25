pollutantmean <- function(directory, pollutant, id = 1:332) {
    
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
    pmsum <- 0
    for (iFile in 1:nFiles) {
        file <- filenames[iFile]
        data <- read.csv(file)
        pmlevels_ <- as.numeric(data[[pollutant]])
        pmlevels <- pmlevels_[!is.na(pmlevels_)]
        pmsum <- sum(pmlevels) + pmsum
        nSamples[iFile] <- length(pmlevels)
    }
    pmmean <- pmsum / sum(nSamples)
    #print(pmmean)
    pmmean
}