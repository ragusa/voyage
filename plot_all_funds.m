close all; clc;

since_when=today-100; % in days
% since_when=[];

cat = load_fund_categories;

% plot classes
logi_new_figure =true;
logi_normalize =true;
figure();
for k=1:length(cat.names)
    if ~logi_new_figure
        subplot(4,4,k)
    end
    plot_funds(logi_new_figure,  logi_normalize, cat.fund{k},  cat.names(k,:), cat.fundID_excl, since_when);
end

% plot_funds(logi_new_figure, logi_normalize, aa     ,'aa'          , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, aaLC   ,'aaLC'        , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, aaLS   ,'aaLS'        , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, bond   ,'Bonds'       , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, fore   ,'foreign'     , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, glob   ,'global'      , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, larblen,'large blend' , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, largrw ,'large growth', cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, larval ,'large value' , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, midblen,'mid blend'   , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, midgrw ,'mid growth'  , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, midval ,'mid value'   , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, smlblen,'small blend' , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, smlgrw ,'small growth', cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, smlval ,'small value' , cat.fundID_excl, since_when);
% plot_funds(logi_new_figure, logi_normalize, sector ,'sector'      , cat.fundID_excl, since_when);

return
