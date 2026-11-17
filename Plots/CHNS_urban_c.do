
*******
* Run CHNS master, CHNS cr-CHNSbootpanel before this


clear
clear matrix
clear mata
set mem 500m
set maxvar 32760
set more off  

cd "$project"

* Urban baseline logy, logc residuals (baseline measures)
use "dydc_spec_urban.dta"

gen age = interview_year - cohort

gen Rlogy =.	
gen Rlogc =.
local  xwave =  1
while `xwave' < 9{
	qui regress logy i.sex i.age i.educ i.hh_size i.province i.minority if wave==`xwave'
	qui predict  Rlogywave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogy =  Rlogywave`xwave'       if wave==`xwave'
	drop     Rlogywave`xwave'
		
	qui regress logc i.sex i.age i.educ i.hh_size i.province i.minority	      if wave==`xwave'
	qui predict  Rlogcwave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogc =  Rlogcwave`xwave'       if wave==`xwave'
	drop     Rlogcwave`xwave'
		
	local xwave = `xwave'+ 1
	}

//drop hh_size
export excel using "var_inc_con_urban_new_yy.xlsx", first(var) replace
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


export excel using "var_inc_con_urban_new_nosex.xlsx", first(var) replace
drop  Rlogy Rlogc

gen Rlogy =.	
gen Rlogc =.
local  xwave =  1
while `xwave' < 9{
	qui regress logy i.hh_size  i.age i.sex i.province i.minority if wave==`xwave'
	qui predict  Rlogywave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogy =  Rlogywave`xwave'       if wave==`xwave'
	drop     Rlogywave`xwave'
		
	qui regress   logc i.hh_size i.age i.sex i.province i.minority	      if wave==`xwave'
	qui predict  Rlogcwave`xwave' 				if wave==`xwave', resid					   						
	replace  Rlogc =  Rlogcwave`xwave'       if wave==`xwave'
	drop     Rlogcwave`xwave'
		
	local xwave = `xwave'+ 1
	}


export excel using "var_inc_con_urban_new_noeduc.xlsx", first(var) replace
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


export excel using "var_inc_con_urban_new_nosexeduc.xlsx", first(var) replace
drop  Rlogy Rlogc