function plot_funds(logical_newfig, logical_norm,  funds_to_plot, my_plot_title, fundID_excl, since_when)

% check # input arg
max_nbr_arg=6;
narginchk(max_nbr_arg-1,max_nbr_arg)

% pick beginning time for plots
if(isempty(since_when))
    when=1;
else
    datenum_when=datenum(since_when);
end

% new figure?
if(logical_newfig)
    figure;
end

% folder for numbered fund files
dir_golden = '.\golden_daily\';

% list of symbols
symb='ox+sv^hv^hox+s';
len=length(symb);

leg=[];
plot_dates=[];

for i=1:length(funds_to_plot)
    
    % check if the current fund is excluded from 
    found_excluded_fund = ~isempty( find(fundID_excl==funds_to_plot(i), 1) );
    if found_excluded_fund
       continue
    end
    
    
    % load fund data
    filename=strcat(dir_golden,num2str(funds_to_plot(i)),'.txt');
    fid=fopen(filename,'r');
    if fid<0
        error('problem opening %s',filename);
    end
    a = fscanf(fid,'%g %g',[2 inf]);a=a';
    fclose(fid);
    [dates,perm]=sort(a(:,1));
    values=a(perm,2);
    
    % select symbol for plotting
    k=mod(i-1,len)+1;
    sss=sprintf('%c-',symb(k));
    
    % do acutal plot
    txt=num2str(funds_to_plot(i),'%4.4i');
    if(~isempty(since_when))
        ind=find(dates >= datenum_when);
        if(~isempty(ind))
            when=ind(1);
            % create legend
            if isempty(leg)
                leg=char(txt);
            else
                leg=char(leg,txt);
            end
            % normalize plot or not?
            if logical_norm
                norm_=values(when);
            else
                norm_=1;
            end
            plot(dates(when:end),values(when:end)/norm_,sss); hold all; axis tight
            plot_dates=[plot_dates;dates(when:end)];
        end
    else
        % create legend
        if isempty(leg)
            leg=char(txt);
        else
            leg=char(leg,txt);
        end
        % normalize plot or not?
        if logical_norm
            norm_=values(when);
        else
            norm_=1;
        end
        plot(dates(when:end),values(when:end)/norm_,sss); hold all; axis tight
        plot_dates=[plot_dates;dates(when:end)];
    end
    
    
end

plot_dates=unique(plot_dates);
plot_dates=sort(plot_dates);

title(my_plot_title);
legend(leg,'Location','EastOutside');
set(gca,'XTick',plot_dates);
if(isempty(since_when))
    date_tick='m';
else
    if(now-since_when>30)
        date_tick='m';
    else
        date_tick='dd';
    end
end
datetick('x',date_tick,'keeplimits'); % keepticks

return
end

