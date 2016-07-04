function load_xls( file_to_read, ...
    dir_golden,...
    filename_list_of_existing_funds,...
    fundID_excl,...
    current_date)

warning OFF BACKTRACE
%%% -------------------------------------
% open existing list of fund IDs
fh_list_funds=fopen(filename_list_of_existing_funds,'r');
numerical_list_of_funds = fscanf(fh_list_funds,'%g',[1 Inf]);
n_fundID_list_original=length(numerical_list_of_funds);
fclose(fh_list_funds);
%%% -------------------------------------

%%% -------------------------------------
% read xls file
data = xlsread(file_to_read,'Sheet2');
[n m] = size(data);
if(n==0 && m==0)
    data = xlsread(file_to_read);
end

% check a few things
[n m] = size(data);
if(m~=4 && m~=5 && m~=6)
    n
    m
    data
    file_to_read
    current_date
    error('load xls: m/=4,5,6');
end

% go through the xls data
for i=1:n
    current_fundID = data(i,1);
    
    found_excluded_fund = ~isempty( find(fundID_excl==current_fundID, 1) );
    
    found_NaN = isnan(data(i,4));
    
    if ~found_excluded_fund
        % check if NaN
        if found_NaN
            error('found NaN in a standard fund ... \t fund ID=%d, index i=%d\n',current_fundID,i');
        end
        % check if new fund
        found_new_fund_ID = isempty( find(numerical_list_of_funds==current_fundID, 1) );
        if found_new_fund_ID
            numerical_list_of_funds = [numerical_list_of_funds current_fundID];
        end
        
        % open file for the current fund ID
        fh_current_fund = fopen(strcat(dir_golden,num2str(current_fundID),'.txt'),'a+');
        frewind(fh_current_fund);

        % check if date already exists in file
        a = fscanf(fh_current_fund,'%g %g',[2 inf]);a=a';
        if isempty(a)
            found_date= ~isempty([]);
        else
            found_date = ~isempty ( find(a(:,1)==current_date, 1) );
        end
        
        if ~found_date
            % we need to add that daily price value to the fund database
            % get the daily price
            daily_price = data(i,3);
            fseek(fh_current_fund, 0, 'eof');
            fprintf(fh_current_fund,'%d \t %g\n',current_date,daily_price);
        end
        fclose(fh_current_fund);
        
    else % this is an excluded fund, we expect to find NaN
        if ~found_NaN
            warning('found an excluded fund BUT it does not have NaN \t fund ID=%d, index i=%d',current_fundID,i);
            fprintf('%g \t',data(i,:));fprintf('\n');
        end
        
    end
    
end
%%% -------------------------------------
% has the list of fund IDs increased ?
if(n_fundID_list_original~=length(numerical_list_of_funds))
    [c,ia,ic]=unique(numerical_list_of_funds);
    if length(c) ~= length(numerical_list_of_funds)
        numerical_list_of_funds
        ia
        error('Duplicate funds in numerical_list_of_funds');
    end
    warning('list of fund IDs has increased by %d ',n_fundID_list_original-length(numerical_list_of_funds));
    % replace existing list of fund IDs
    fh_list_funds=fopen(filename_list_of_existing_funds,'w');
    fprintf(fh_list_funds,'%g\n',numerical_list_of_funds);
    fclose(fh_list_funds);
end
%%% -------------------------------------

warning ON BACKTRACE

end

