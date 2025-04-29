library(readxl)
#data : https://aga.gov.au/publications/life-tables/australian-life-tables-2020-22
mortality_data <- read_excel("test/test_data/australian-life-tables-2020-22_0.xlsx")
head(mortality_data)#all columns have proper column names as for premium calculator function

#All tests below should produce output "TRUE"

#check if loading increase increases premium:
a <- TermLifePremium(mortality_data, 100000, 52, 0.05, 10, 1) #no loading
a1 <- TermLifePremium(mortality_data, 100000, 52, 0.05, 10, 1.3) #loading
a1 > a
#check that loading doesn't apply in case where insured turns 60 at end of term
b <- TermLifePremium(mortality_data, 100000, 50, 0.05, 10, 1)
b1 <- TermLifePremium(mortality_data, 100000, 50, 0.05, 10, 1.3)
b1 == b
#
