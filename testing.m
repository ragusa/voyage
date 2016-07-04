function testing

dir_golden = '.\golden_daily\';

listing = dir(dir_golden);
for i=1:length(listing)
    if ~listing(i).isdir
        
        listing(i).name
        % read file        
        file_to_read = strcat(dir_golden,listing(i).name);
        fid=fopen(file_to_read,'r');
        a = fscanf(fid,'%g %g',[2 inf]); a=a';
        fclose(fid);
        % uniqueness
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

