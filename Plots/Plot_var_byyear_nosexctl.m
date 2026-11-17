% Plot age profile of variances of Rlogy and Rlogc by wave
% Run master first
clear all; close all;

% cd 'C:\Users\j\Desktop\DY\My research\CHNS_income_2026'



%% RURAL

T_rural = xlsread("var_inc_con_rural_new_nosex.xlsx");

% this is to control age in the sample
T_rural = T_rural(T_rural(:,15)<61,:);   % age are younger than 59.

max_wave = max(T_rural(:,8));
max_age = max(T_rural(:,15));
var_y_rural  = [];
var_c_rural = [];

% find variances for log and logc residuals by wave (age between 25 and 65 )
for i = 1:max_wave 
    idx = find(T_rural(:,8) == i);
    Rlogy = T_rural(idx,16);    % this is log income 
    Rlogc = T_rural(idx,17);   % this is log consumption 
    Rlogy = Rlogy(~isnan(Rlogy));
    Rlogc = Rlogc(~isnan(Rlogc));
    var_y_rural = [var_y_rural;[i,var(Rlogy)]];
    var_c_rural = [var_c_rural;[i,var(Rlogc)]];
end 

int_year = [1989,1991,1993,1997,2000,2004,2006,2009];

var_bs_rural = [var_y_rural(3,2),var_c_rural(3,2)];
var_rural = [var_y_rural, var_c_rural, int_year']; 

% gini_y_rural = xlsread("gini_rural.xlsx", "D:D");
% gini_c_rural = xlsread("gini_rural.xlsx", "E:E");
% gininolog_y_rural = xlsread("gini_rural.xlsx", "B:B");
% gininolog_c_rural = xlsread("gini_rural.xlsx", "C:C");


%% URBAN

% read and prepare urban data 
T_urban = xlsread("var_inc_con_urban_new_nosex.xlsx");
T_urban = T_urban(T_urban(:,15)<61,:);  % age are younger than 59.

%max_wave = max(T_urban(:,7));
var_y_urban  = [];
var_c_urban = [];

% find variances for log and logc residuals by wave ( age between 25 and 65 )
for i = 1:max_wave 
    idx = find(T_urban(:,8) == i);
    Rlogy = T_urban(idx,16);    % this is log income
    Rlogc = T_urban(idx,17);   % this is log comsumption 
    Rlogy = Rlogy(~isnan(Rlogy)); % removes NaN values
    Rlogc = Rlogc(~isnan(Rlogc));
    var_y_urban = [var_y_urban;[i,var(Rlogy)]];
    var_c_urban = [var_c_urban;[i,var(Rlogc)]];
end 

%int_year = [1989,1991,1993,1997,2000,2004,2006,2009];

var_bs_urban = [var_y_urban(3,2),var_c_urban(3,2)];
var_urban = [var_y_urban, var_c_urban, int_year']; 

% gini_y_urban = xlsread("gini_urban.xlsx", "D:D");
% gini_c_urban = xlsread("gini_urban.xlsx", "E:E");
% gininolog_y_urban = xlsread("gini_urban.xlsx", "B:B");
% gininolog_c_urban = xlsread("gini_urban.xlsx", "C:C");


%% PLOTS WITH GINI OF VARIABLES WITHOUT LOG

% subplot(2,1,1)
fig = 1; 
figure(fig)
% yyaxis left
plot(int_year, var_y_rural(:,2),'b--O',  int_year, var_c_rural(:,2),'b--X','LineWidth',3),grid
ylim([0, 1.5]);
set(gca, 'ytick', 0:0.1:1.5,'FontSize',12);
% yyaxis right
% plot(int_year, gininolog_y_rural,'r--O',  int_year, gininolog_c_rural,'r--X','LineWidth',3),grid
% ylim([0, 0.5]);
% set(gca, 'ytick', 0:0.1:0.5,'FontSize',12);
xlim([1989, 2009]);
% set(gca, 'xtick', 1989:2:2009,'FontSize',12);
% legend('variance of log income','variance of log consumption','gini coeff of income','gini coeff of consumption', ...
%     'Location', 'southeast','FontSize',12)
legend('variance of log income','variance of log consumption', ...
    'Location', 'southeast','FontSize',12)
title('(A). Rural','FontSize',12)
set(gcf,'units','pixels','position',[500,500,500,500]);
grid on;
print(gcf,'ruralinequality_g_nolog_nosex','-dpng','-r400')
printpdf(gcf,'ruralinequality_g_nolog_nosex.pdf')

% subplot(2,1,2)
fig = fig+1;
figure(fig)
% yyaxis left
plot(int_year, var_y_urban(:,2),'b--O', int_year, var_c_urban(:,2),'b--X', 'LineWidth',3),grid
ylim([0, 1.5]);
set(gca, 'ytick', 0:0.1:1.5,'FontSize',12);
% yyaxis right
% plot(int_year, gininolog_y_urban,'r--O',  int_year, gininolog_c_urban,'r--X','LineWidth',3),grid
% ylim([0, 0.5]);
% set(gca, 'ytick', 0:0.1:0.5,'FontSize',12);
xlim([1989, 2009]);
% set(gca, 'xtick', 1989:2:2009,'FontSize',12);
% legend('variance of log income','variance of log consumption','gini coeff of income','gini coeff of consumption', ...
%     'Location', 'northwest','FontSize',12)
legend('variance of log income','variance of log consumption',...
    'Location', 'northwest','FontSize',12)
title('(B). Urban','FontSize',12)
set(gcf,'units','pixels','position',[500,500,500,500]);
grid on;
print(gcf,'urbaninequality_g_nolog_nosex','-dpng','-r400')
printpdf(gcf,'urbaninequality_g_nolog_nosex.pdf')


save var_nosex var_y_urban var_c_urban var_y_rural var_c_rural
%% save to a table
T = table(var_y_urban(:,2), var_c_urban(:,2), var_y_rural(:,2),var_c_rural(:,2), ...
    'VariableNames', {'var_y_urban', 'var_c_urban', 'var_y_rural','var_c_rural'});

writetable(T, 'variance_nosex.xlsx')
