function [ fund_name, fund_class_name, fund_class_ID ] = get_fund_header( fundID, console_print)

% clc

if nargin == 0
    warning('Need fundID at least');
    return
elseif nargin == 1
    console_print=true;
elseif nargin == 2
    % all good
else
    error('Wrong number of arguments');
end

%%% ------------------
%%% find the class and the class name
%%% ------------------
cat = load_fund_categories;

[~,nbr_cat]=size(cat.fund);

fund_class_ID_=[];
for i=1:nbr_cat
    ind = find( cat.fund{i}(:) == fundID );
    if ~isempty(ind)
        if length(ind)~=1
            fprintf('Category id=%d \nCategory name %s \n',i,cat.names(i,:));
            cat.fund{i}
            error('More than 1 fundID in that category');
        else
            fund_class_ID_ = [fund_class_ID_ i];
            fund_class_name = cat.names(i,:);
        end
    end
end

% sort and remove doubles, if any
fund_class_ID = unique(fund_class_ID_);
if length(fund_class_ID) ~= length(fund_class_ID_)
    length(fund_class_ID)
    length(fund_class_ID_)
    fund_class_ID
    fund_class_ID_
    error('doubles in fund classes!!!')
end

% check if found
if length(fund_class_ID) ~= 1
    warning('We did not find fund %d',fundID);
    fund_class_ID_ =-999;
    fund_class_name = 'not found!!!';
    fund_class_ID = NaN;
end

%%% ------------------
%%% find the fund name
%%% ------------------

fund_name = 'not found!!!';

fid = fopen('fund_names_10_30_2014.csv');
a=textscan(fid,'%d %s','Delimiter',',');
fclose(fid);
b=a{2};

all_funds_ID=a{1};
ind = find( all_funds_ID == fundID);
if isempty(ind)
    warning('fundID is not in the global list fund');
else
    if length(ind)>1
        ind
        all_funds_ID(ind)
        error('fundID is appearing more than once if global fund list')
    else
        fund_name = b{ind};
    end
    
end
        
        
%%% ------------------
%%% console print out
%%% ------------------

if console_print
    fprintf('Fund ID \t\t\t%d\nFund name \t\t\t%s\nFund class name \t%s\nFund class ID \t\t%d\n',...
        fundID,...
        fund_name,...
        fund_class_name,...
        fund_class_ID);
end
        

end

