function [mol_struct,data_mat,file_title]= get_mol_list_struct(file_loc)
%read title line
fid = fopen(file_loc, 'rt'); 
tline = fgets(fid);
fclose(fid);

tline  = tline(1:(end-1));
file_title = tline;
tline = strrep(tline,'"',[]);
tline = strrep(tline,' ',[]);
tline = strrep(tline,'[','_');
tline = strrep(tline,']','');

headers = strsplit(tline,',');

%read csv file
data_mat = csvread(file_loc,1,0);

% format csv to struct
for i=1:length(headers)
    mol_struct.(headers{i}).data = data_mat(:,i);
    mol_struct.(headers{i}).index = i;
end

