# TermLifePremiumCalculator

## Overview 

This package facilitates accurate premium calculations for term life insurance products based on given mortality data. It includes general factor inputs such benefit amount, age of the client, interest rate boundaries, inflation, the policy term (in years), the loading factor for clients over 60 years anytime during the policy and a selection period (in years). 

## Installation

### GitHub
```R
install.packages("devtools")
devtools::install_github("akansha-kumar/TermLifePremiumCalculator")
```

## Usuage 

To get started, you can import the mortality data. The example below calculates the premium with: 

- benefit amount = 100,000
- age = 52
- interest rate =  1-5%
- inflation rate = 1%
- policy term = 10 years
- loading for 60+ = 1.2
- select period = 5 years

```R
library(readxl)
#Data source : https://aga.gov.au/publications/life-tables/australian-life-tables-2020-22
mortality_data <- read_excel("test/test_data/australian-life-tables-2020-22_0.xlsx")
head(mortality_data) #Ensure columns a properly named ("Age" and mortality rates as "qx")

#Utilising the function
info <- TermLifePremium(mortality_data, 100000, 52, 0.01, 0.05, 0.01, 10, 1.2, 5)
#Extracting the net premium and the interest rates for each year separately
info$NetPremium
info$InterestRates
```

## Features 

### Stochastic Interest Rates 

The function takes a boundary for interest rates to allow for randomisation of interest rates within the policy period. For ease of analysis and understanding, the function allows for the interest rates in each year to be displayed.

### Loading on Old Ages

When a loading factor greater than 1 is chosen to be applied on ages 60 and over, the function multiplies this factor by the respective mortality rate to assume a greater risk of death compared to past mortality rates. 
Likewise, a rate less than 1 can be applied in this age range if the assumption that the mortality data rates are higher than expected for the period in which the premium is being calculated. 

### Select Rates 

When a select period is chosen,  during this period the mortality rate from given data is reduced relative to age: 

$$ q_x_new = q_x_old * adjustment factor$$

$$ adjustment factor = 0.98 * e^(-k * age) = 0.98 * e^(-0.02 * age)$$

A greater improvement in mortality is shown for younger ages compared to older ages based on the assumption that although medical underwriting would've occurred prior to the select period establishment, older people are statistically more likely to develop health issues. However, to account for the occurrence of underwriting the difference of improvement between these two groups is chosen not to be too high.  

![Mortality Plot - Tuning](kRplot.png)

### In-Built Age Warning

The function will automatically return a incompatibility message if the age of the insured is outside the age range of the given mortality data at any year of the policy term. This helps users to identify and resolve such an issue efficiently without spending unnecessary time troubleshooting. 


## Authors and License

Author: Akansha Kumar | akanshas.kumar4@gmail.com
Licence: This package is licensed under the MIT License. You are free to use, modify, and distribute the software, provided the terms of the MIT License are met. For details, see the LICENSE file included in this package.

