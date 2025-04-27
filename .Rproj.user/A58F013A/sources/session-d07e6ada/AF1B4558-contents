TermLifePremium <- function(mortality_table, benefit_amount, start_age, interest_rate, policy_term, old_age_loading){
  #null results outside mortality data age range
  end_age <- start_age + policy_term
  if(end_age > max(mortality_data$Age) | start_age < min(mortality_data$Age)){
    print("Incompatiable Age Range")
  }  else {
    #initialise premium to 0
    net_premium <- 0
    #premium calculation - sum PV of benefit cost in each year
    for(year in 1:policy_term){
      qx <- as.numeric(mortality_data[mortality_data$Age == start_age,"qx"])#mortality_rate
      if(start_age>=60){#loading applies when insured >= 60 only
        qx <- qx * old_age_loading
      }
      discount_factor <- (1+interest_rate)^(-year)
      PV <- benefit_amount*qx*discount_factor #PV of benefit at specific year
      net_premium <- net_premium + PV #accumulating PV over policy term
      start_age <- start_age + 1 #increment age for next year of policy term
    }

    return(net_premium)
  }
}
