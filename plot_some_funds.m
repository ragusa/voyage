close all; clc;

since_when=today-450; % in days
% since_when=[];

cat = load_fund_categories;

% plot 
% (logical_newfig, logical_norm,  funds_to_plot, my_plot_title, fundID_excl, since_when)
logi_normalize=true;
my_funds=[788 79 264 1612 81 187 1776 1445];
my_funds=[1445 1776 788 111 770 80 81];
plot_funds(true,  logi_normalize, my_funds,  'my funds' , cat.fundID_excl, since_when);

return
