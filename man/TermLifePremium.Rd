\name{TermLifePremium}
\alias{TermLifePremium}
\title{Premium Calculator}
\usage{
TermLifePremium(mortality_table, benefit_amount, age, min_interest,
max_interest, inflation, policy_term, old_age_loading, select_period)
}
\description{
This function calculates the premium for a term life insurance product
based on provided mortality data, interest rates,
and other policy details.
}

\arguments{
  \item{mortality_table}{A `tibble` or `data frame` containing age and mortality rates.}
  \item{benefit_amount}{A numeric value representing the sum insured.}
  \item{age}{Current age of the insured.}
  \item{min_interest}{Minimum interest rate for discounting.}
  \item{max_interest}{Maximum interest rate for discounting.}
  \item{inflation}{Inflation rate to be applied on benefit amount}
  \item{policy_term}{Policy term in years.}
  \item{old_age_loading}{Numeric adjustment factor for older ages.}
  \item{select_period}{Duration of the select mortality period (e.g., 3 years).}
}

\examples{
#note: mortality table should include labels "Age", "qx" for age and mortality rates respectively.

library(readxl)
#Data source : https://aga.gov.au/publications/life-tables/australian-life-tables-2020-22

mortality_data <- readxl::read_excel(
    system.file("extdata", "australian-life-tables-2020-22_0.xlsx"
    , package = "TermLifePremiumCalculator")
)


result <- TermLifePremium(
  mortality_table = mortality_data,
  benefit_amount = 100000,
  age = 52,
  min_interest = 0.01,
  max_interest = 0.05,
  inflation = 0.02,
  policy_term = 10,
  old_age_loading = 1.2,
  select_period = 5)

#Extracting net premium
result$NetPremium
#Extracting interest rates for each policy year
result$InterestRates
}
