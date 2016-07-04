function  compare_performance( res )

close all; clc;

% load all categories
cat = load_fund_categories;


for k=1:length(cat.names)
    
    % class to analyze
    category_name = cat.names(k,:);   
    fprintf('------------------------------------------\nFund class name \t%s\n------------------------------------------\n',category_name);
    
    [~, sorting] = sort(res.increase{k});
    funds_to_analyze = cat.fund{k};
    
    for i=1:length(sorting)
        
        if ~isnan(res.increase{k}(sorting(i)))
            [ fund_name, fund_class_name, fund_class_ID ] = get_fund_header( funds_to_analyze(sorting(i)), false);
            fprintf('Fund ID \t\t\t%d\nFund name \t\t\t%s \nIncrease \t\t\t%g (%s)\n',...
                funds_to_analyze(sorting(i)),...
                fund_name,...
                100*(res.increase{k}(sorting(i))-1),'%');
            fprintf('---------------------\n');
        end
    end
end

