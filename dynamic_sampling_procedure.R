
# Benjamin Buss
# Started November 15th 2019
# Establish Dynamic Sampling Procedure
# Challenge issued by Professor of STAT 4200 Class
# Based on chapter 7, 8, 9 and 10.7 of Stats book
# WIP, no testing done, limited capabilities

dynamic_probabilities <- function(x, n, p, s, known) {
    # === Function Documentation ===========================================================
    # Simulates for best possible probabilities to sample with based off known information
    # -- Inputs --
    # x             :data to choose from/index
    # n             :size of final sample
    # p             :vector of probabilities
    # known         :
    # s             :number of rounds to simulate(default = 100)
    # -- Outputs --
    # probabilities :vector of the same length as x, containing the corresponsing probabilities
    # -- Assumptions
    # Plenty
    # ======================================================================================
    if(rlang::is_empty(s)) { # If s not provided default to 100
        s = 100
    }
    else {      # If s is provided keep it as is
        s = s
    }
    
    #Initialize empty vector here
    
    for(i in 1:s) {
        # Simulate s[100] times to determine best method
        
    }
    probabilities = (10 * p) / sum(p) # best formula as determined by above loop?
        
        
    return(probabilities)
} # == End of Dynamic Probabilities Function ==


dynamic_sample <- function(data, size, prob, rep, var) {
    # === Function Documentation ===============================================================
    # Dynamically samples from vector X, based off probability 'prob' and previous observations
    # -- Inputs --
    # data  :vector of elements to choose from
    # size  :number of items to choose
    # prob  :vector of corelated variable to base the probability weights off of
    # rep   :Sample with or without replacement?
    # var   :I don't even know the point of this variable
    # -- Outputs --
    # final :Vector of length 'size' containing sampled
    # -- Assumptions --
    # What are thoseeee
    # ==========================================================================================
    
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
# 
# 
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


