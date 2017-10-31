mol_map_img_size = meas_img_size*pixel2nm;
ratio = ceil(mol_map_img_size(1)/sofi_img_size(1));

palm_Ys_nrmlizd = palm_Ys;
palm_Xs_nrmlizd = palm_Xs;

is_for_display = 1;


subplot_n = 2;
subplot_m =5;


thunderStorm_names  = {    'frame',...
    'x_nm',...
    'y_nm',...
    'sigma_nm',...
    'intensity_photon',...
    'offset_photon',...
    'bkgstd_photon',...
    'chi2',...
    'uncertainty_nm'};
pc_names = {'frame #',...
    'x [nm]',...
    'y [nm]',...
    '\sigma [nm]',...
    'intensity [photon]',...
    'local BG [photon]',...
    'BG STD [photon]',...
    '\chi ^2',...
    '\sigma_{x,y} [nm]'};


good_names= table(pc_names','RowNames',thunderStorm_names');

loop_counter = 1;

for i = 1:ratio:max(palm_Xs_nrmlizd);
    palm_Xs_nrmlizd(palm_Xs_nrmlizd>=i & palm_Xs_nrmlizd<(i+ratio)) = loop_counter;
    loop_counter = loop_counter+1;
end

loop_counter = 1;
for i = 1:ratio:max(palm_Ys_nrmlizd);
    palm_Ys_nrmlizd(palm_Ys_nrmlizd>=i & palm_Ys_nrmlizd<(i+ratio)) = loop_counter;
    loop_counter = loop_counter+1;
end

SOFI_value = zeros(1,numel(palm_Xs_nrmlizd));
for j=1:numel(palm_Xs_nrmlizd)
    SOFI_value(j) = sofi_img(palm_Xs_nrmlizd(j),palm_Ys_nrmlizd(j));
end

min_sofi_val = min(SOFI_value);
max_sofi_val = max(SOFI_value);

params_figure = figure('Name',meas_name,'NumberTitle','off',...
                                'Units', 'normalized', 'OuterPosition',[0.1 0.1 0.8 0.84]);

                            
handles = guihandles(params_figure); % create structure of handles

loop_counter = 1;

names = fieldnames(data);

good_names_table = table(names);




subplot_nums = [1:3,6:8];
raf = 0;

for i=1:numel(names)
    
    field_name = names{i};
    
    subplot_num = subplot_nums(loop_counter);
    
    mol_list_param = data.(field_name);
    
      if subplot_num>3
        subaxis(subplot_n,subplot_m,subplot_num,'Padding', 0.02,'PaddingTop',0, 'Margin', 0.08,'SpacingHoriz',0.02,'SpacingVert',0.00,'MarginTop',00);
      else
          subaxis(subplot_n,subplot_m,subplot_num,'PaddingTop',0,'Padding', 0.02,'PaddingBottom', 0, 'Margin', 0.08,'SpacingHoriz',0.02,'SpacingVert',0.00,'MarginTop',00);
      end
      
    
    switch field_name
        case 'intensity_photon'
            indxs =  SOFI_value<=raf;
            loglog(SOFI_value(~indxs),mol_list_param(~indxs),'.b');
            hold on;          
            loglog(SOFI_value(indxs),mol_list_param(indxs),'.r');
            hold off;
        case {'sigma_nm', 'offset_photon', 'bkgstd_photon','uncertainty_nm'} %no 'chi2'
            indxs =  SOFI_value<=raf;
            semilogx(SOFI_value(~indxs),mol_list_param(~indxs),'.b');
            hold on;
            semilogx(SOFI_value(indxs),mol_list_param(indxs),'.r');
            hold off;
         
        otherwise
            continue;
    end
    loop_counter = loop_counter+1;

    param_display = cell2mat(good_names(field_name,1).Var1);
    
    if is_for_display
        ylabel(param_display,'FontSize',24,'FontName','Ariel');
         if subplot_num<3
            set(gca,'XTick',[]);            
         else 
             xlabel('SOFI value','FontSize',24,'FontName','Ariel');
             %set(gca,'XTickLabel',{'2e5'  '4e5' '6e5'});
              Xnums =  get(gca,'XTick')';
              
              labels =  cellfun(@sprintf,repmat({'%.0g'},length(Xnums),1),mat2cell(Xnums,ones(length(Xnums),1)),'UniformOutput',0) ;
              
               labels  = strrep(labels,'+0','');
              
             set(gca,'XTickLabel',labels );
         end
         set(gca,'FontSize',18);
         
    else
        title(param_display);     
    end
    axis([min_sofi_val max_sofi_val min(mol_list_param) max(mol_list_param)]);

    tagm(gca, field_name);
    handles.fields.(field_name).x = SOFI_value(~indxs);
    handles.fields.(field_name).y = mol_list_param(~indxs)';
end


subaxis(subplot_n,subplot_m,[4;9],'Padding', 0, 'Margin', 0.01,'SpacingHoriz',0.0001,'SpacingVert',0.009);
%pos_vec = [0.6 0.35 0.38 0.38];
%subplot('Position',pos_vec);
plot(ceil(palm_Ys),ceil(palm_Xs),'.','MarkerSize',8);
title('PALM Picture','FontSize',24,'FontName','Ariel');
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
tagm(gca, 'xy');

handles.fields.xy.x = ceil(palm_Xs);
handles.fields.xy.y =ceil(palm_Ys);

set(gca, 'Ydir', 'reverse')
%set(gca, 'YAxisLocation', 'Right')
%set(gca, 'Xdir', 'reverse')
%set(gca, 'XAxisLocation', 'Right')
%axis off;
axis equal tight;

rgn_select_btn = uicontrol(params_figure,'Style','pushbutton','String','Select Region',...
              'Units','normalized','Position',[0.7 0.05 0.2 0.04],'Callback',@rgn_select_btn_press);          % create structure of handles
reset_btn = uicontrol(params_figure,'Style','pushbutton','String',' Reset',...
            'Units','normalized', 'Position',[0.7 0.01 0.1 0.04], 'Callback',@reset_btn_press);    

        
handles.press_counter = 0;        
handles.rgn_select = rgn_select_btn;  % Add p to the "test" field of the handles structure
guidata(params_figure,handles);  % Add the new handles structure to the figure



clear subplot_nums subplot_num subplot_n subplot_m j i;
