#################################################
### STAT 341: Tutorial 1 -- Working with Data ###
###          Friday January 10, 2020          ###
#################################################

# R contains many datasets already that you can work with simply by calling their names
# To see a list of all such datasets use the following command:
data()

# We're going to look at the "ChickWeight" dataset
? ChickWeight

# But most of the time we need to load data into R from a file
getwd()
setwd("/Users/nstevens/Dropbox/Teaching/STAT_341/Tutorials/Tutorial 1/")

# Read in a .csv file
df_csv <- read.csv(file = "ChickWeight.csv", header = TRUE)

# Read in a .txt file
df_txt <- read.table(file = "ChickWeight.txt", header = TRUE)

# Read in a .json file
library(rjson)
df_json <- as.data.frame(fromJSON(file = "ChickWeight.json"))

# Let's work with the data frame read from the csv file
df <- df_csv

# View the dataset in a spreadsheet window
View(df)

# View the dataset in the console
df

# Dimension of the data frame (rows/columns)
dim(df)

# View the top n rows of the data frame
head(df, n = 10)

# View the bottom n rows of the data frame
tail(df, n = 10)

# Summary of the dataframe
summary(df)

# "Chick" and "Diet" should be treated as categorical (not numeric) variables. In R
# a categorocal variable is called a "factor" variable. We should change this. But first
# let's figure out how to access specific columns of a data frame.

# Extracting columns that are named
df$Chick
df$Diet

# Extracting columns (in general) -- behaves like a matrix
df[,3]
df[,4]

# Confirm that the "Chick" and "Diet" variables are not treated as factors
is.factor(df$Chick)
is.factor(df$Diet)

# Coerce them to become factors
df$Chick <- as.factor(df$Chick)
is.factor(df$Chick)

df$Diet <- factor(df$Diet, levels = 1:4, labels = c("Diet 1", "Diet 2", "Diet 3", "Diet 4"))
is.factor(df$Diet)

# Sanity Check
summary(df)

################
### Plotting ###
################

# Univariate plots (for quantitative variables)
hist(x = df$weight, xlab = "Weight (grams)", main = "Histogram of Weight")
boxplot(x = df$weight, xlab = "Weight (grams)", main = "Boxplot of Weight")

hist(x = df$Time, xlab = "Time (days)", main = "Histogram of Time")
boxplot(x = df$Time, xlab = "Time (days)", main = "Boxplot of Time")

# Univariate plots (for categorical variables)
# First the table() function:
table(df$Diet)
barplot(table(df$Diet), main = "Frequency Barplot of Diet")
barplot(table(df$Diet)/sum(table(df$Diet)), main = "Relative Frequency Barplot of Diet")

pie(x = table(df$Diet), main = "Pie Chart of Diet")

# Bivariate plots (for quantitative variables)
plot(x = df$Time, y = df$weight, xlab = "Time (days)", ylab = "Weight (grams)", main = "Scatter Plot of Weight vs. Time")

# Bivariate plots (for quantitative and categorical variables)
boxplot(df$weight ~ df$Diet, ylab = "Weight (grams)", main = "Weight by Diet Type")

# Multiple plots in one window
par(mfrow = c(1,3))
hist(x = df$weight, xlab = "Weight (grams)", main = "Histogram of Weight")
plot(x = df$Time, y = df$weight, xlab = "Time (days)", ylab = "Weight (grams)", main = "Scatter Plot of Weight vs. Time")
boxplot(df$weight ~ df$Diet, ylab = "Weight (grams)", main = "Weight by Diet Type")

# Bivariate plots (for categorical variables)
# First the table() function:
table(df$Diet, df$Chick)
par(mfrow = c(1,1))
mosaicplot(x = table(df$Diet, df$Chick), xlab = "Diet", ylab = "Chick ID", main = "Chick ID by Diet")

# Look at another dataset which is a better illustration of this function
? HairEyeColor
HairEyeColor
mosaicplot(x = HairEyeColor[,,1], main = "Male Hair and Eye Colour")
mosaicplot(x = HairEyeColor[,,2], main = "Female Hair and Eye Colour")

# Adding lines to plots
plot(x = rnorm(n = 1000, mean = 0, sd = 1), y = rnorm(n = 1000, mean = 0, sd = 1), xlab = "", ylab = "", main = "", pch = 16, xlim = c(-3.5, 3.5), ylim = c(-3.5, 3.5))

# Diagonal Lines
abline(a = 0, b = 1, col = "red")

# Lines with a specific slope/intercept
abline(a = -1, b = 0.5, col = "green", lwd = 2)

# Horizontal and vertical lines
abline(h = 0, col = "blue", lwd = 2, lty = 2)
abline(v = -2, col = "purple", lwd = 2, lty = 3)

# Line Segments
segments(x0 = -2, y0 = -3, x1 = -1, y1 = -3, col = "magenta", lwd = 3, lty = 1)

# Curves
lines(x = seq(-3, 3, 0.1), y = cos(3*seq(-3, 3, 0.1)), col = "orange", lwd = 4)

# Adding a legend
legend("bottomright", legend = c("Diagonal", "General Line", "Horizontal", "Vertical", "Segment", "Curve"), 
       col = c("red", "green", "blue", "purple", "magenta", "orange"),
       lwd = c(1, 2, 2, 2, 3, 4),
       lty = c(1, 1, 2, 3, 1, 1))

# Add more points, but with a different colour and shape
points(x = rnorm(n = 100, mean = -3, sd = 0.2), y = rnorm(n = 100, mean = 3, sd = 0.2), col = "cyan", pch = 17)

