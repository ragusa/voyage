function generate_daily_price_files(do_txt, do_xls)
clc

%%% -------------------------------------
%%% checks
%%% -------------------------------------
if(nargin==0)
    do_txt=true;
    do_xls=true;
end
if(nargin ~=0 && nargin~=2)
    error('you need to specify nothing or specify both do_txt do_xls');
end
if (~do_txt && ~do_xls )
    disp('There is nothing to do. Bye!');
    %     return
end
%%% -------------------------------------
%%% location of the golden files
%%% -------------------------------------
dir_golden = '.\golden_daily\';

filename_list_of_existing_funds = 'fundID_list.txt';

%%% -------------------------------------
% list of fund IDs to exclude
%%% -------------------------------------
cat = load_fund_categories;
fundID_excl = cat.fundID_excl;


%%% -------------------------------------
%%% process the daily text files
%%% -------------------------------------

if(do_txt)
    
    %%% -------------------------------------
    %%% read the daily prices (copy/pasted from website)
    %%% -------------------------------------
    
    dir_daily_txt ='..\';
    listing = dir(strcat(dir_daily_txt,'daily\daily*.txt'));
    
    %%% -------------------------------------
    %%% scan each daily txt file
    %%% -------------------------------------
    
    nbr_txt_files=0;
    for i=1:length(listing)
        if ~listing(i).isdir
            % increment the nbr of text files
            nbr_txt_files =nbr_txt_files + 1;
            % generate the filename to be read
            file_to_read = strcat(dir_daily_txt,'daily\',listing(i).name);
            fprintf('Reading file %s \t %d/%d \n',file_to_read,nbr_txt_files,length(listing));
            % load data from txt file
            load_daily_txt( file_to_read, ...
                dir_golden,...
                fundID_excl,...
                filename_list_of_existing_funds )
        end
    end
    
end % done with: do_txt

%%% -------------------------------------
%%% process Excel files
%%% -------------------------------------

if(do_xls)
    
    %%% -------------------------------------
    %%% read the daily prices: Excel files from Joe
    %%% -------------------------------------
    
    % dir_excel ='..\Weekly Fund YTD 2013\';
    dir_excel ='..\YTD_xls\';
    listing = dir(dir_excel);
    
    %%% -------------------------------------
    %%% scan each daily Excel file
    %%% -------------------------------------
    
    % find the number of xls files in directory
    nbr_xls_files=0;
    for i=1:length(listing)
        if ~listing(i).isdir ...
                && isempty(findstr(listing(i).name,'asset')) ...
                && isempty(findstr(listing(i).name,'Asset')) ...
                && isempty(findstr(listing(i).name,'change')) ...
                && isempty(findstr(listing(i).name,'eoq')) ...
                && isempty(findstr(listing(i).name,'chng')) ...
                && isempty(findstr(listing(i).name,'Qchange')) ...
                && isempty(findstr(listing(i).name,'SA IRA')) ...
                && isempty(findstr(listing(i).name,'(2)')) ...
                && isempty(findstr(listing(i).name,'B7')) ...
                && isempty(findstr(listing(i).name,'~')) ...
                && isempty(findstr(listing(i).name,'oeq'))
            
            % increment the nbr of xls files
            nbr_xls_files = nbr_xls_files + 1;
            % generate the filename to be read
            file_to_read = strcat(dir_excel,listing(i).name);
            fprintf('Reading file %s \t %d/%d \n',file_to_read,nbr_xls_files,length(listing));
            % generate date based on xls filename
            date_ = sprintf('%s-%s-20%s',listing(i).name(3:4),listing(i).name(5:6),listing(i).name(1:2));
            current_date = datenum(date_);
            % load data from xls file
            load_xls( file_to_read, ...
                dir_golden,...
                filename_list_of_existing_funds,...
                fundID_excl,...
                current_date)
        end
    end
    
end % done with: do_xls

%%% -------------------------------------
%%% order by date the golden files and remove if double dates are present
%%% -------------------------------------

listing = dir(dir_golden);
for i=1:length(listing)
    if ~listing(i).isdir
        
        % read file
        file_to_read = strcat(dir_golden,listing(i).name);
        fid=fopen(file_to_read,'r');
        a = fscanf(fid,'%g %g',[2 inf]); a=a';
        fclose(fid);
        [n,m]=size(a);
        if n~=0 && m==2
            % good to continue
            % check uniqueness
            [c,ia,ic]=unique(a(:,1));
            if length(c) ~= length(a(:,1))
                warning('Non unique dates in fund ID %s',listing(i).name);
                aux=zeros(length(ia),2);
                aux(:,1)=a(ia,1);
                aux(:,2)=a(ia,2);
                clear a; a=aux; clear aux;
            end
            % sort
            [dates,perm]=sort(a(:,1));
            values=a(perm,2);
            aux=[dates values];
            % write
            fid=fopen(file_to_read,'w');
            fprintf(fid,'%g %g\n',aux');
            fclose(fid);
        end
    end
end



%%% -------------------------------------
%%% -------------------------------------

%%% -------------------------------------
%%% -------------------------------------

%%% -------------------------------------
%%% -------------------------------------

%%% -------------------------------------
%%% -------------------------------------


end

