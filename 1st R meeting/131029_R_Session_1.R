### Basics in R
### Session 1 - 29/10/2013
### Marco Smolla


### 1.    Simple calculations and first objects
###       Using basic operators
          9+2-1
          5*0.5
          27/3
          9^2
          9^(1/2)
          sqrt(9)
          log(5)
          
###       Comparing values
          # Will return a logical value, which is either 'TRUE' or 'FALSE'
          54>45 # greater than
          1<2 # less than
          15==15 # exactly equal to
          50>=51 # greater than or equal to

###       Assigning values to a variable
          # There are different ways to assign values to a variable (or placeholder)
          # The most common is the arrow method <- that assigns a value to the variable
          # it is pointing at. 
          x <- 2  # assigns a numeric value to a variable
          y = 15  # -- same effect
          assign('d', 7) # -- same effect
          color <- 'green' # assigns a character value to a variable
          
          c(2,3,4) # c is a function that combines values to a vector
          c(d, color, 'Flowers') # 
          
          # test what happens when you ype this 
          c(1:10)
          
###       Calculating with variables
          # Once we created 
          b <- x + y
          f <- d^x
          g <- x < y
          
            
###       Simple statistical measure
          vector <- c(x,y,d,f,b, 50.3, 7^2) 
          length(vector)
          sum(vector)
          mean(vector)
          max(vector)
          min(vector)
          median(vector)
          summary(vector)
          
          # try also the sort() and the order() function with the vector


### 2.    Understanding objects in R 
          # There are different so called classes of objects. We have already seen numeric 
          # characters, and logical values. The function class() helps you to find out which
          # data type you are dealing with. Let's test this:
          class(2)
          class(c('a','2'))
          class(TRUE)
          class(2<3)
          class(vector)
          
          # To an extend we can change the class of an object, for example, we can make 
          # a numeric value to a character value (characters are always surrounded by ' '):
          as.character(3)
          # We can also make a logical value to a numeric
          as.numeric(TRUE)
          as.numeric(FALSE)
          as.character(TRUE)
          # But remember, by changing the class, you also change the behvaior of R regarding
          # this object. But R tries hard to understand what you are doing see this:
          'TRUE' == TRUE
          '2' == 2
          #BUT:
          'color' == color
          
          
          ls() # returns all values that are in your workspace
          rm(x,y,d,f,b,g) # removes individual values
          ls() 

          ### 3.    Ways to organize and navigate through your data
          
###       Vector
          ID <- c(1:10)
          Hight <- round(runif(n=10, min=1.5, max=2.2), digits=2)
          Sex <- sample(x=c('female','male'), size=10, replace=TRUE)
          
          Sex=='male'
          maleHight <- Hight[Sex=='male']
          femaleHight <- Hight[Sex!='male']
          mean(maleHight); mean(femaleHight)
          # How does the mean change when you have 100 instead of 10 individuals?

###       The data frame - keeps your data organised
          data <- data.frame(id=ID, hight=Hight, sex=Sex) 
          summary(data)
          class(data)
          
          head(data) # first five lines
          tail(data) # last five lines
          
          names(data) # returns the column names of the data.frame
          
          data$hight # the $ let's you call a specific column

          data[1, ] # show the first line and all columns of data
          data[ , 'sex']  #try summary(data[ , 'sex'])
          data[Hight>=1.9, ] # Why should you rather use this: data[data$hight>=1.9, ]
          
          # Let us create a histogram that shows the distribution of body size
          hist(data$hight, xlab="Hight", main="Distribution of body size")   