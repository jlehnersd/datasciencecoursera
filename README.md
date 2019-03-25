# datasciencecoursera

This repo contains coding assignments and data science projects that I have completed in the Data Science series from John Hopkins University through Coursera. The series consists of 9 courses. Each course has its own folder, which contains my work for that course.

## Course 1 - The Data Scientist's Toolbox

This course was an overview of data science tools and methodology. The assignments consisted of installing software such as R and R Studio, and creating a GitHub account (which I already had). There were no coding projects for this course so there is no folder for course 1.

## Course 2 - R Programming

This course was an overview of the R programming language, especially as it pertains to data analysis and statistics.

### Assignment 1 - Air Pollution

This assignment was to write three functions to analyze pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. The data is stored as CSV text files in the specdata directory. The data analysis functions are in the following R files:

pollutantmean.R - calculates the mean of a specified pollutant over a specified list of monitors.

complete.R - determines the number of complete data measurements for a list of specified monitors (i.e. only counts measurements with no missing data entries).

corr.R - calculates the correlation between nitrate and sulfate pollutants for specified monitors only if they have a specified minimum number of complete data measurements.

### Assignment 2 - Lexical Scoping

This assignment was to use the lexical scoping rules of the R language to write a function, cachematrix(), that caches the inverse of a matrix and only computes a new matrix inverse if the cache is empty or if the non-inverted matrix has changed.

### Assignment 3 - Hospital Compare

This assignment was to write three functions to determine hospital rankings in the United States for health outcomes for several medical conditions according to data provided by the U.S. Department of Health and Human Services. The data is stored as CSV text files in the healthcare_data directory. The data analysis functions are in the following R files:

best.R - finds the best-ranked hospital for a specified medical condition in a specified U.S. state or territory.

rankhospital.R - finds the hospital with the specified rank for a specified medical condition in a specified U.S. state or territory.

rankall.R - finds the hospital with the specified rank for a specified medical condition in every U.S. states and territory.