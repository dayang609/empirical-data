clear
clear matrix
clear mata
set mem 500m
set maxvar 32760
set more off

//cd "C:\Users\k1sxy06\OneDrive - FR Banks\Dotsey_Li_Yang\CHNS_YY\2022_Dan_Paper\4_Missing_Primary_Occupation\"
global project "C:\Users\j\Desktop\DY\My research\CHNS_income_2026_cleaned"

** compute residuals for rural sample

do "CHNS_rural_c"

** compute residuals for urban sample

do "CHNS_urban_c"

** compute gini coefficient for both samples

do "Compute_Gini"


** compute residuals for rural sample after control for household size

//do "CHNS_rural_c_hhs"

** compute residuals for urban sample after control for household size

//do "CHNS_urban_c_hhs"

** compute gini coefficient for both samples  after control for household size

//do "Compute_Gini_hhs"

** plot Figure 1
shell "C:\Program Files\MATLAB\R2026b\bin\matlab.exe" -batch "run('C:\Users\j\Desktop\DY\My research\CHNS_income_2026_cleaned/Plot_var_byyear_bs.m')"

** plot figures A.1  - A.3
shell "C:\Program Files\MATLAB\R2026b\bin\matlab.exe" -batch "run('C:\Users\j\Desktop\DY\My research\CHNS_income_2026_cleaned/Plot_var_byyear_noeducctl.m')"
shell "C:\Program Files\MATLAB\R2026b\bin\matlab.exe" -batch "run('C:\Users\j\Desktop\DY\My research\CHNS_income_2026_cleaned/Plot_var_byyear_nosexctl.m')"
shell "C:\Program Files\MATLAB\R2026b\bin\matlab.exe" -batch "run('C:\Users\j\Desktop\DY\My research\CHNS_income_2026_cleaned/Plot_var_byyear_nosexeducctl.m')"