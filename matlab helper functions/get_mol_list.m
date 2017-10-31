function mol_list_data = get_mol_list(data_file_loc , mol_list_struct,is_get_all)

%this function reads molecular lists
%the variable data_filename is already set before this segment
%mol_list_struct - a struct with the column name and column number in data
%                  file.

delimiter = ',';
imprt = importdata(data_file_loc,delimiter);
data = imprt.data;

clear imprt;

struct_fields = fieldnames(mol_list_struct);

for i=1:numel(struct_fields)
    
    field_name = struct_fields{i};
   
    if is_get_all
        mol_list_struct.(field_name) = data(:,mol_list_struct.(field_name).col_num);
    elseif mol_list_struct.(field_name).is_get 
        %struct fields are NOT numbered the same as the columns
        mol_list_struct.(field_name) = data(:,mol_list_struct.(field_name).col_num);
    end
    
end

mol_list_data = mol_list_struct;

clear col_num; clear struct_fields;