TermLifePremium <- function(mortality_table, benefit_amount, age, min_interest, max_interest, inflation, policy_term, old_age_loading, select_period){
  #null results outside mortality data age range
  end_age <- age + policy_term
  if(end_age > max(mortality_table$Age) | age < min(mortality_table$Age)){
    print("Incompatiable Age Range")
  }  else {
    #initialise premium to 0
    net_premium <- 0
    #allowing for return of interest rates in each year
    interest_rates <- c()
    #premium calculation - sum PV of benefit cost in each year
    for(year in 1:policy_term){
      qx <- as.numeric(mortality_table[mortality_table$Age == age,"qx"])#mortality_rate
      if(year <= select_period){ #lower/select rates apply here
        qx <- qx * 0.98 * exp(age*-0.02) #adjustment relative to age
      }
      if(age>=60){#loading applies when insured >= 60 only (standard loading age)
        qx <- qx * old_age_loading
      }
      #calculating a random interest rate given boundary rates
      interest_rates[year] <- (min_interest + (max_interest - min_interest) * runif(1))
      discount_factor <- (1+interest_rates[year])^(-year)
      #inclusion of inflation to benefit amount
      PV <- (benefit_amount*(1 + inflation)^year)*qx*discount_factor #PV of benefit at specific year
      net_premium <- net_premium + PV #accumulating PV over policy term
      age <- age + 1 #increment age for next year of policy term
    }

    #return(net_premium)
    return(list(
      NetPremium = net_premium,
      InterestRates = interest_rates
    ))
  }
}
