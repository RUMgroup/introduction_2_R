vector <- runif(n=25,min=1,max=100)

# S3 function
calculate <- function(x, colors='blue', plot){
  MEAN <- mean(x) # here i calculate the mean
  SUM <- sum(x)
  SD <- sd(x)
  print(colors)
  df <- data.frame(mean=MEAN,sum=SUM,std=SD)
  return(df)
}
calculate(x=vector)

# S4 functions
setGeneric('Calculate', function(x, print) standardGeneric('Calculate'))
# Here we define the behaviour of the function for the case that x is numeric and a logical value for print is provided
setMethod(f='Calculate', 
          signature=c(x='numeric', print='logical'), 
          definition=function(x,print){
            MEAN <- mean(x) # here i calculate the mean
            SUM <- sum(x)
            SD <- sd(x)
            df <- data.frame(mean=MEAN,sum=SUM,std=SD)
            if(print==TRUE) print('DONE')
            return(df)
          })

# If a list instead of a numeric value is provided for the argument x, R will select the following function (which behaves differently and returns a different result).
setMethod(f='Calculate', 
          signature=c(x='list'), 
          definition=function(x){
            MEAN <- lapply(x,mean)
            return(MEAN)
          })

Calculate(x=vector, print=T)
Calculate(x=list(c(1:10), c(5:25)), print=F)



# Related to Migules data reorganisation question (see the different layout of 'tst' and 'result'):
# First: we import the data (here I create a data frame that has similar characteristics of his data set)
tst <- data.frame(V1=runif(99,5,10), V2=runif(99,2,25), V3=rep(seq(0,1,.1),times=9), V4=rep(1:9,each=11))
# Second: We go trough all unique elements of column 4 and return the values of column 1 and 2 in a new data.frame and bind all data.frames of this new list together in a new data.frame that we call result
result <- do.call('cbind', lapply(unique(tst$V4), function(x){
  v1 <- tst$V1[tst$V4==x]
  v2 <- tst$V2[tst$V4==x]
  df <- data.frame(a=v1,b=v2)
}) )
# Third: we rename the columns (in the format 1a, 1b, 2a, 2b, ...)
names(result)  <- paste(rep(unique(tst$V4),each=2), names(result), sep='')
# And Finally: we rename the rows 
# NOTE: the same result but more dynamical would be: row.names(result) <- unique(tst$V3)
row.names(result) <- seq(from=0,to=1,by=.1) 
result