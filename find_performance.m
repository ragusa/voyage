function res = find_performance(start_date,seek_maximum_increase)

close all; clc;

if(nargin~=2)
    error('insufficient number of arguments in find_performance: %d',nargin);
end

% determine start date for performance evaluation
if isnumeric(start_date)
    since_when = today - start_date; % start_date = how many days in past
else
    if strcmpi(star_date,'beginning')
        since_when = datenum('10-Aug-2011');
    else
        since_when = datenum(start_date);
    end
end
        
% load all categories
cat = load_fund_categories;


%%% datetime(datenum_when,'ConvertFrom','datenum')

% folder for numbered fund files
dir_golden = '.\golden_daily\';
res=[];

% find best performer per category
for k=1:length(cat.names)
    
    % class to analyze
    funds_to_analyze = cat.fund{k};
    category_name = cat.names(k,:);
    
    % re-init array to store perf values for a given class
    increase=nan*ones(length(funds_to_analyze),1);
    
    for i=1:length(funds_to_analyze)
        
        % check if the current fund is excluded from list
        found_excluded_fund = ~isempty( find(cat.fundID_excl==funds_to_analyze(i), 1) );
        if found_excluded_fund
            warning('excluded fund %d in category %s\n',funds_to_analyze(i),category_name);
            continue
        end
        
        % load fund data
        filename=strcat(dir_golden,num2str(funds_to_analyze(i)),'.txt');
        fid=fopen(filename,'r');
        if fid<0
            error('problem opening %s',filename);
        end
        % sort fund data in chronological order
        a = fscanf(fid,'%g %g',[2 inf]);a=a';
        fclose(fid);
        [dates,perm]=sort(a(:,1));
        fund_values=a(perm,2);
        
        % pick subset of data over specified time period
        ind=find(dates >= datenum_when);
        if(~isempty(ind))
            when=ind(1);
        end
        dates_to_analyze  = dates(when:end);
        values_to_analyze = fund_values(when:end);
        
        % analysis
        %         % weights for moving average
        %         k=10; wts = [1/(2*k);repmat(1/k,k-1,1);1/(2*k)];
        %         y=conv(values_to_analyze,wts,'valid');
        increase(i) = values_to_analyze(end) / values_to_analyze(1);
    end
    % save results
    res.increase{k}=increase;
    
    if seek_maximum_increase
        perf_assessment(k) = max(increase);
    else
        perf_assessment(k) = min(increase);
    end
    ind = find(increase==perf_assessment(k));
    best_fund_index_in_category(k)=ind;
    
end


% sort
[~, sorting] = sort(perf_assessment);
% best_fund_index_in_category = best_fund_index_in_category(sorting);

% print out
for k=1:length(sorting)
    
    funds_to_analyze = cat.fund{sorting(k)};
    
    [ fund_name, fund_class_name, fund_class_ID ] = get_fund_header( funds_to_analyze(best_fund_index_in_category(sorting(k))), false);
    
    fprintf('---------------------\nFund class name \t%s\nFund ID \t\t\t%d\nFund name \t\t\t%s \nIncrease \t\t\t%g (%s)\n',...
        fund_class_name,...
        funds_to_analyze(best_fund_index_in_category(sorting(k))),...
        fund_name,...
        100*(perf_assessment(sorting(k))-1),'%');
    
    
end
fprintf('---------------------\n---------------------\n');
