corr <- function(directory, threshold = 0) {
    
    id = 1:332
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
    
    nFiles <- length(filenames)
    corrs <- numeric()
    k = 1
    for (file in filenames) {
       
        data <- read.csv(file)
        
        nitratelevels_ <- as.numeric(data$nitrate)
        sulfatelevels_ <- as.numeric(data$sulfate)
        fullset = !is.na(nitratelevels_) & !is.na(sulfatelevels_)
        
        nSamples <- length(fullset[fullset])
        
        if (nSamples > threshold) {
            nitratelevels <- nitratelevels_[fullset]
            sulfatelevels <- sulfatelevels_[fullset]
            corrs[k] <- cor(nitratelevels, sulfatelevels)
            k <- k + 1
        }
    }
    corrs
}