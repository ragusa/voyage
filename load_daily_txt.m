function load_daily_txt( file_to_read, ...
                         dir_golden,...
                         fundID_excl,...
                         filename_list_of_existing_funds )


%%% -------------------------------------
% open existing list of fund IDs
fh_list_funds=fopen(filename_list_of_existing_funds,'r');
numerical_list_of_funds = fscanf(fh_list_funds,'%g',[1 Inf]);
n_fundID_list_original=length(numerical_list_of_funds);
fclose(fh_list_funds);
%%% -------------------------------------


%%% -------------------------------------
% load daily data
fid=fopen(file_to_read);
C=textscan(fid,'%s');
fclose(fid);
A=C{1}; clear C;
n=length(A);
%%% -------------------------------------

% get date from the file name itself
current_date = datenum(file_to_read(end-13:end-4));

% get first fund ID
current_fundID = str2num(A{1});

found_excluded_fund = ~isempty( find(fundID_excl==current_fundID, 1) );
if ~found_excluded_fund
    % check if new fund
    found_new_fund_ID = isempty( find(numerical_list_of_funds==current_fundID, 1) );
    if found_new_fund_ID
        numerical_list_of_funds = [numerical_list_of_funds current_fundID]; 
    end
    % open file for the current fund ID
    fh_current_fund = fopen(strcat(dir_golden,num2str(current_fundID),'.txt'),'a+');
    frewind(fh_current_fund);
end

% get the rest of the data
for i=2:n

    % find the location of a % symbol
    FoundPercent = strcmp(A{i}(end),'%');
    if FoundPercent
        if ~found_excluded_fund
            % check if date already exists in file
            a = fscanf(fh_current_fund,'%g %g',[2 inf]);a=a';
            if isempty(a)
                found_date = ~isempty([]); % gives false
            else
                found_date = ~isempty ( find(a(:,1)==current_date, 1) );
            end
            if ~found_date
                % we need to add that daily price value to the fund database
                % get the daily price
                daily_price = str2num(A{i-2});
                fseek(fh_current_fund, 0, 'eof');
                fprintf(fh_current_fund,'%d \t %g\n',current_date,daily_price);
            end
            fclose(fh_current_fund);
        end
        
        % prepare for the next fund ID
        if(i==n), break, end
        current_fundID = str2num(A{i+1});
        found_excluded_fund = ~isempty( find(fundID_excl==current_fundID, 1) );
        if ~found_excluded_fund
            found_new_fund_ID = isempty( find(numerical_list_of_funds==current_fundID, 1) );
            if found_new_fund_ID
                numerical_list_of_funds = [numerical_list_of_funds current_fundID];
            end
            % open file for the current fund ID
            fh_current_fund = fopen(strcat(dir_golden,num2str(current_fundID),'.txt'),'a+');
            frewind(fh_current_fund);
        end
    end
    
    % check if NaN
    FoundNA= (strcmp(A{i},'N/A') && strcmp(A{i-2},'N/A') );
    FoundNA2=(strcmp(A{i},'N/A') && strcmp(A{i-1},'N/A') && ~strcmp(A{i+1},'N/A') );
    FoundNA3= (strcmp(A{i},'N/A') && ~strcmp(A{i+2},'N/A') && ~strcmp(A{i+1},'N/A') );
    if (FoundNA || FoundNA2 || FoundNA3)
        % prepare for the next fund ID
        if(i==n), break, end
        current_fundID = str2num(A{i+1});
        found_excluded_fund = ~isempty( find(fundID_excl==current_fundID, 1) );
        if ~found_excluded_fund
            found_new_fund_ID = isempty( find(numerical_list_of_funds==current_fundID, 1) );
            if found_new_fund_ID
                numerical_list_of_funds = [numerical_list_of_funds current_fundID];
            end
            % open file for the current fund ID
            fh_current_fund = fopen(strcat(dir_golden,num2str(current_fundID),'.txt'),'a+');
            frewind(fh_current_fund);
        end
    end
    
    
%     if current_fundID==772
%         disp('found')
%     end
end

fclose('all');

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
    fh_list_funds=fopen(filename_list_of_existing_funds,'w');
    fprintf(fh_list_funds,'%g\n',numerical_list_of_funds);
    fclose(fh_list_funds);
end
%%% -------------------------------------



end

