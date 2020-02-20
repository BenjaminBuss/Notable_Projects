
# Benjamin Buss
# Started November 15th 2019
# Establish Dynamic Sampling Procedure
# Challenge issued by Professor of STAT 4200 Class
# Based on chapter 7, 8, 9 and 10.7 of Stats book
# WIP, no testing done, extremely limited capabilities


#' Simulates for best possible probabilities to sample with based off known correlated values
#' 
#' @description 
#' \code{dynamic_probabilities} insert description here. Insert assumptions here as well
#' 
#' @param x vector of data/indexs to sample from
#' @param n size of final sample
#' @param p vector of probabilities
#' @param s number of rounds to simulate
#' @param known yes
#' 
#' @examples None...
#' 
#' @return Vector 'Probabilities' the same length as x containing corresponding probabilities
#' 
#' @seealso ?sample
dynamic_probabilities <- function(x, n, p, s, known) {
    # Get range of probabilities and model any relation(assuming some relations), test formulas based off that model?
    
    #Initialize empty vector here
    
    for(i in 1:s) {
        # Simulate s[100] times to determine best method
        
    }
    # Select method with least variance as p
    # probabilities = p.method(p)
    probabilities = (10 * p) / sum(p) # best formula as determined by above loop?
        
        
    return(probabilities)
} # == End of Dynamic Probabilities Function ==

#' Dynamicalaly samples from vector X, based off probability 'prob' and previous observations
#' 
#'   @description 
#'   \code{dynamic_sample} insert description, assumptions, and limitations here
#'   
#'   @param data Vector of elements to sample from
#'   @param size a non-negative integer giving the number of items to choose
#'   @param rep should sampling be with replacement?
#'   @param prob a vector of correlated variables to base weight off of
#'   @param var don't know why I have this
#'   
#'   @examples None currently
#'   
#'   @return final vector of length 'size' containging final sample
#'   
#'   @seealso ?sample ?dynamic_probabilities 
#'   
dynamic_sample <- function(data, size, rep, prob,  var) {
    
    if(as.character(length(size)) >= as.character(length(x))) {
        print("Error, size must be larger than vector to be sampled from")
        break
    }
    else {
        known <- vector(mode = "numeric", length = size)      # Initialize empty vectors for better RAM utilization
        dynam_samp <- vector(mode = "numeric", length = size) # 
        
        for (i in 1:size) {                                   # Sample
            prob <- dynamic_probabilities(data, size, prob, known) # Fetch updated list of probabilities
            known[i] <- sample(data, 1, prob = prob)          # Sample once based off of the probabilitites
            dynam_samp[i] <- known[i]                         # Seperate known and final vectors?

            # if(rep != TRUE) { # Without replacement
            # Remove index from list after it has been selected?
            # Also remove any probability?
            # But keep the known?????
            # Man this is going to be a mess
            # }
            # else() {}
        }
        final <- dynam_samp
        return(final)
    } 
    
} # == End of Dynamic Samplings Function ==

# Notes / To Do -----------------------------------------------------------

# How to sample without replacement???
# How to return 'Known' data and implement it into dynamic sampling procedure?
# Weights
# Genetic programming
# 

# Test Cases --------------------------------------------------------------

# Sample size larger than sample
# dynamic_sample(1,5)

# == Exam 2 Test Case ==
x <- array(1:23)
size = 10
prob = c(3,2,3,2,2,2,3,3,2,2,1,1,2,1,3,3,3,3,3,1,3,3,3)
dynamic_sample(x, size, prob, 100)

# 
# 




