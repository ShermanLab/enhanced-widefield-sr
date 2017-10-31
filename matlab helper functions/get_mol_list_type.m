function mol_list_type = get_mol_list_type()
mol_list_type = struct('frame', struct('col_num',1,'is_get',0),...
'x_nm', struct('col_num',2,'is_get',0),...
'y_nm', struct('col_num',3,'is_get',0),...
'sigma_nm', struct('col_num',4,'is_get',0),...
'intensity_photon', struct('col_num',5,'is_get',0),...
'offset_photon', struct('col_num',6,'is_get',0),...
'bkgstd_photon', struct('col_num',7,'is_get',0),...
'chi2', struct('col_num',8,'is_get',0),...
'uncertainty_nm', struct('col_num',9,'is_get',0));
end


% code to build the struct
% % 
% % data_file_loc = 'C:\Users\owner\Desktop\exported mol list\mol_list.csv';
% % delimiter = ',';
% % imprt = importdata(data_file_loc,delimiter);
% % col_names = imprt.textdata(1,1:end);
% % data = imprt.data;
% % clear imprt;
% % 
% % str = 'struct(';
% % 
% % for i = 1:length(col_names)
% %     str = [str '''' strrep(col_names{i},' ','_') ''', struct(''col_num'',' int2str(i) ',''is_get'',0),']; 
% %     str = [str '...' char(10)];
% % end
% % 
% % str = strrep(str,'"','');
% % str = strrep(str,'[','');
% % str = strrep(str,']','')