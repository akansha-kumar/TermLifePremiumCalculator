library(readxl)
#data : https://aga.gov.au/publications/life-tables/australian-life-tables-2020-22
mortality_data <- read_excel("test_data/australian-life-tables-2020-22_0.xlsx")
head(mortality_data)#all columns have proper column names as for premium calculator function

#All tests below should produce output "TRUE". [A uniform interest rate it used]

#check if loading increase increases premium:
a <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1, 0)$NetPremium #no loading
a1 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1.3, 0)$NetPremium #loading
a1 > a
#check that loading doesn't apply in case where insured turns 60 at end of term
b <- TermLifePremium(mortality_data, 100000, 50, 0.05, 0.05, 0, 10, 1, 0)$NetPremium
b1 <- TermLifePremium(mortality_data, 100000, 50, 0.05, 0.05, 0, 10, 1.3, 0)$NetPremium
b1 == b
#check that interest rate is stochastic between given boundaries
premium_list <- c()
for(i in 1:100){
  premium_list[i] <- TermLifePremium(mortality_data, 150000, 32, 0.01, 0.05, 0, 15, 1.2, 0)$NetPremium
}
plot(premium_list) #premium is random given random interest rates

#tuning (assuming adjustment factor of 0.98) constant that controls the rate at which
#the mortality is reduced relative to age
k <- seq(0.01, 0.1, 0.01) #range of values for steepness control
colours <- colorRampPalette(c("lightblue", "blue", "purple", "red", "darkred"))(10)#colours for plot lines
par(mar = c(5, 4, 4, 10)) #increase the right margin for legend
plot(mortality_data$Age, mortality_data$qx,pch = 16, xlab = "Age", ylab = "Mortality Rate")
#adding adjusted mortality rates with differing k
for(i in 1:length(k)){
  lines(mortality_data$Age, mortality_data$qx *0.98*exp(mortality_data$Age*-k[i]),
        col = colours[i], lwd = 2)
}
#legend for different k values)
legend("topright", legend = paste("k =", k), inset = c(-0.4, 0), xpd = TRUE,
       col = colors, lwd = 2, cex = 0.8, title = "Steepness Factor")

#Notes:
  #smaller k values (steeper) results in a sharper adjustment to mortality for younger ages
  #larger k value results in a smaller difference between the improvement in mortality for young/old ages
  #other option is an equal adjustment across all ages (k=0)
#Assumption:
  #Although the select period length can impact the select rate used, the model ignores it for simplicity
  #As people get older they are more likely to develop health issues and hence more
  #likely to die during the term they are insured.
  #However, a large difference in mortality adjustment would not account for the fact that select periods
  #are backed by medical underwriting results
  #Since we also have a loading applied for older ages (60+), the giant reduction
  #in mortality rate from ages 85+ is not an issue when selecting k
#Taking these into consideration, a value of 0.02 for the steepness of mortality adjustment is used.


#checks for select rates input

#with and without select period (no loading)
s_1 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1, 5)$NetPremium #w/ select period
s_2 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1, 0)$NetPremium #w/o select period
s_1 < s_2
#how select period impact premiums when loading is applied
s_3 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1.2, 5)$NetPremium #w/ select period
s_4 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1.2, 0)$NetPremium #w/o select period
rel_change <- (s_4-s_3)/s_3*100 #30% higher premium without select period
#how select period impact premiums when loading isn't applied
rel_change2 <- (s_2-s_1)/s_1*100 #31% higher premium without select period
#good news: loading still has an impact on the premium
s_3 > s_1
s_4 > s_2

#checks for inflation
inf1 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0.01, 10, 1.2, 5)$NetPremium #with inflation
inf2 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0, 10, 1.2, 5)$NetPremium #without inflation
inf1 > inf2

#check for printing interest rates
TermLifePremium(mortality_data, 100000, 52, 0.05, 0.05, 0.01, 10, 1.2, 5)
TermLifePremium(mortality_data, 100000, 52, 0.01, 0.05, 0.01, 10, 1.2, 5)
