### finishing example from last meeting
###       Vector
          ID <- 15:6
          Height <- round(runif(n=10, min=1.5, max=2.2), digits=2)
          Sex <- sample(x=c('female','male'), size=10, replace=TRUE)
          
          # Remember logical operators
          ###################
          #     a == b  equal to
          #     a != b  unequal to
          #     a <  b  less than
          #     a >  a  bigger than
          #     a >= a  bigger or equal to
          
          Sex=='male'
          maleHeight <- Height[Sex=='male']
          femaleHeight <- Height[Sex!='male']
          mean(maleHeight); mean(femaleHeight)
          # How does the mean change when you have 100 instead of 10 individuals?
          
###       The data frame - keeps your data organised
          data <- data.frame(id=ID, height=Height, sex=Sex) 
          data
          class(data) # check the class of the data object
          str(data) # detailed information about all compartments of the object
          summary(data) # with summary() R tries to give you a quick statisitc of your values
          
          # Navigating through your data frame
          head(data) # first five lines
          tail(data) # last five lines          
          names(data) # returns the column names of the data.frame
          dim(data) # the dimensions of the data frame; try ncol() and nrow()
          
          data$height # the $ let's you call a specific column
          data[1, ] # shows the first line and all columns of data; also try data[5:7, ]
          data[, 1] # shows the first column and all lines of data; also try data[2:5, 2:3]
          data[ , -1] # exclude the first column
          
          data[ , 'sex']  # try summary(data[ , 'sex'])
          data[ , c('id','height')] # include several columns defined by their name
          data[Height>=1.9, ] # Why should you rather use this: data[data$height>=1.9, ]
          data[data$height>=1.9, 'sex']

          # We can create a simple plot with our data
          plot(data$height, type='b') # try to sort the values with: plot(sort(data$height), type='b')
          # Let us create a histogram that shows the distribution of body size
          hist(data$height, xlab="Height", main="Distribution of body size")  
          # And a simple barplot that shows the differences between male and female
          barplot(height = c(mean(Height[Sex!='male']), mean(Height[Sex=='male'])), 
                  names.arg = c('female','male'))

          
### Importing and exporting data
###       We will import data from an Excel spreadsheet using the xlsx package
          library(xlsx)
          # look up help file of the package
          
          # Now we need to locate the file we want to import
          getwd() # returns the place where R is currently looking for a file
          
          # In my case I stored the file on the Desktop, but it could also be at any other place
          setwd("~/Desktop") # tells R to look in a different place for files, in Windows you need a \ instead of a /
          
          # We use the read function from the xlsx package to import data into R
          read.xlsx2(file="PlayerExpenses.xlsx", sheetIndex=1) # you could also import the file using file='~/Desktop/PlayerExpenses.xlsx'
          
          # If you have a look at the orginal data you see that the first column has a date format. We can tell read.xlsx () to handle the first column as a date which in R is defined by the class 'POSIXct'. 
          expenses <- read.xlsx2(file="PlayerExpenses.xlsx", # define the place
                                 sheetIndex=1, 
                                 colClasses=c("POSIXct", "character", "character", "numeric"))
          
          # Have a look at the data
          expenses
          str(expenses)
          summary(expenses)
          
          # Let us take a quick look on the development of fees payed by the football club for a new player.
          plot(expenses[,1], expenses[,4]) 
          
          # Try the following two lines to get a nicer looking plot 
          plot(expenses[,1], expenses[,4]/1000000, xaxt='n', xlab='Date', ylab='Fee in Million GBP', pch=20, type='b')
          axis.POSIXct(1, x=expenses$Date)
          
          # We have a file that tells us the nationality of the players. Let's import this csv file and add the information to our expenses data.frame
          nationality <- read.csv(file="Nationality.csv")
          # I included the Fee column so you can check whether the order of the two data.frames is correct.
          all(expenses$Fee==nationality$Fee) #the all() function checks whether all elements are TRUE and if so returns TRUE
          
          # To add a vector to a data.frame we just tell R how the new column shoud be named, here it is Nation
          expenses$Nation <- nationality[,1] # equal to: <- nationality$Nationality
          expenses
          summary(expenses)
          
          # By the way, if you would like to combine two data.frames, you can use the data.frame funciton
          data.frame(expenses,nationality) # Note, we have two columns with the same name (Fee). R will add an identifier to make all column names unique. If you need replicated column names use the argument check.names=F
          
          # Say, we are only interested in a subset of the whole data, e.g. only the english player. 
          expensesEnglish <- expenses[ expenses$Nation=="England", ] # inspect the new data.frame using the Workspace of RStudio and clicking at expensesEnglish
          
          # For our future work we may only need the fees payed and the team names. We will store this in a csv file.
          write.csv(file="expensesE.csv", expensesEnglish[ ,c('Sold.to', 'Fee')])
          write.xlsx(file="expensesE.xlsx", x=expensesEnglish[ ,c('Sold.to', 'Fee')], sheetName="England") 

          # Sometimes it is easier to save your manipulated data the same way as it is currently stored in R. Try this:
          save(expenses, file='myData') # you will find a file in your current wokring directory with the name 'myData'
          # Let's see how we get this data into R again
          rm(expenses)
          expenses
          load('myData')
          expenses
          # Note: you can store several objects in a single file. Try for example save(expenses, data, file='myData2')

          
###       Using a list to handle several data.frames
          fruit <- data.frame(apple=c(3,2,4,5), banana=c(7,7,8,1), strawberry=c(0,1,1,10))
          vegetable <- data.frame(salad=c(15,24,17), tomato=c(10,9,2))
          
          list(fruit, vegetable)
          food <- list(fruits = fruit, vegetables = vegetable)
          food
          class(food)
          str(food)
          summary(food)
          
          # Navigating through a list
          food$fruit
          food[[1]]
          class(food[[1]])
          food[[1]]$'n'
          food[[1]][1]
          
###       If there is time left we will import a slightly bigger list and see how we can work with it
          load('expenseList') 
          expenseList