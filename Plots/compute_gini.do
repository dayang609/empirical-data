*Compute Gini Coefficients for each wave by year

clear
clear matrix
clear mata 
set mem 500m
set maxvar 32760
set more off

cap ssc install fastgini



********** Compute Gini Coefficient of logy and logc for RURAL **********
cd "$project"

use "dydc_spec_rural.dta", clear

foreach var in income1_Rural consumption1_Rural logy logc {
gen gini_`var' = .     
egen   subgroup = group(wave)
levels subgroup, local(levels) 
foreach i of local levels { 
	fastgini `var'									if subgroup == `i'
	replace gini_`var' = r(gini)					if subgroup == `i'
	replace gini_`var' = round(gini_`var', 0.001)	if subgroup == `i'
	format gini_`var' %9.3f							if subgroup == `i'
	}
drop subgroup
}

collapse (first) gini_income1_Rural gini_consumption1_Rural gini_logy gini_logc, by(wave)

export excel using "gini_rural.xlsx", firstrow(variables) keepcellfmt replace



********** Compute Gini Coefficient of logy and logc for URBAN **********

use "dydc_spec_urban.dta", clear

foreach var in income1_Urban consumption1_Urban logy logc {
gen gini_`var' = .     
egen   subgroup = group(wave)
levels subgroup, local(levels) 
foreach i of local levels { 
	fastgini `var'									if subgroup == `i'
	replace gini_`var' = r(gini)					if subgroup == `i'
	replace gini_`var' = round(gini_`var', 0.001)	if subgroup == `i'
	format gini_`var' %9.3f							if subgroup == `i'
	}
drop subgroup
}

collapse (first) gini_income1_Urban gini_consumption1_Urban gini_logy gini_logc, by(wave)

export excel using "gini_urban.xlsx", firstrow(variables) keepcellfmt replace

