
*******
* Run CHNS master, CHNS cr-CHNSbootpanel 

clear
clear matrix
clear mata 
set mem 500m
set maxvar 32760
set more off

cd "$project"
* Rural baseline logy, logc residuals 
 use "dydc_spec_rural.dta"  /*dydc_spec_rural can be produced from 8068_3*/
* import excel "D:\WORK\Yangyang\Benchmark model\CHNS_income\dydc_spec_rural.dta", sheet("Sheet1") firstrow clear

gen age = interview_year - cohort
* COMPUTE RESIDUALS


gen Rlogy =.	
gen Rlogc =.
local  xwave =  1
while `xwave' < 9{
	qui regress logy i.sex i.age  i.educ i.hh_size i.province i.minority if wave==`xwave'
	qui predict  Rlogywave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogy =  Rlogywave`xwave'       if wave==`xwave'
	drop     Rlogywave`xwave'
		
	qui regress logc i.sex i.age i.educ i.hh_size i.province i.minority	      if wave==`xwave'
	qui predict  Rlogcwave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogc =  Rlogcwave`xwave'       if wave==`xwave'
	drop     Rlogcwave`xwave'
		
	local xwave = `xwave'+ 1
	}

//	drop hh_size

export excel using "var_inc_con_rural_new_yy.xlsx", first(var) replace

drop  Rlogy Rlogc

gen Rlogy =.	
gen Rlogc =.
local  xwave =  1
while `xwave' < 9{
	qui regress logy i.hh_size i.age i.educ i.province i.minority if wave==`xwave'
	qui predict  Rlogywave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogy =  Rlogywave`xwave'       if wave==`xwave'
	drop     Rlogywave`xwave'
		
	qui regress   logc i.hh_size i.age i.educ i.province i.minority	      if wave==`xwave'
	qui predict  Rlogcwave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogc =  Rlogcwave`xwave'       if wave==`xwave'
	drop     Rlogcwave`xwave'
		
	local xwave = `xwave'+ 1
	}


export excel using "var_inc_con_rural_new_nosex.xlsx", first(var) replace
drop  Rlogy Rlogc

gen Rlogy =.	
gen Rlogc =.
local  xwave =  1
while `xwave' < 9{
	qui regress logy i.hh_size i.age i.sex i.province i.minority if wave==`xwave'
	qui predict  Rlogywave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogy =  Rlogywave`xwave'       if wave==`xwave'
	drop     Rlogywave`xwave'
		
	qui regress   logc i.hh_size i.age i.sex i.province i.minority	      if wave==`xwave'
	qui predict  Rlogcwave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogc =  Rlogcwave`xwave'       if wave==`xwave'
	drop     Rlogcwave`xwave'
		
	local xwave = `xwave'+ 1
	}


export excel using "var_inc_con_rural_new_noeduc.xlsx", first(var) replace

drop  Rlogy Rlogc

gen Rlogy =.	
gen Rlogc =.
local  xwave =  1
while `xwave' < 9{
	qui regress logy i.hh_size i.age i.province i.minority if wave==`xwave'
	qui predict  Rlogywave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogy =  Rlogywave`xwave'       if wave==`xwave'
	drop     Rlogywave`xwave'
		
	qui regress logc i.hh_size i.age i.province i.minority	      if wave==`xwave'
	qui predict  Rlogcwave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogc =  Rlogcwave`xwave'       if wave==`xwave'
	drop     Rlogcwave`xwave'
		
	local xwave = `xwave'+ 1
	}


export excel using "var_inc_con_rural_new_nosexeduc.xlsx", first(var) replace
drop  Rlogy Rlogc