function rgn_select_btn_press(hObject,eventdata)

handles = guidata(gcbf);

hFH = imfreehand();
pos = hFH.getPosition();

axes_h = gca; %handle to current axes
gca_tag = axes_h.Tag;

x = handles.fields.(gca_tag).x;
y = handles.fields.(gca_tag).y;

bit_map = inpolygon(x,y,pos(:,1),pos(:,2));


form_h = hObject.Parent;
arr_axes =  findobj(form_h,'Type','Axes');


tags = {arr_axes(:).Tag};

arr_added_plots_hs = [];
handles.press_counter = handles.press_counter+1;

colors = ['g','r','y','m','c','k'];



for i=1:numel(tags)

    x = handles.fields.(tags{i}).x;
    y = handles.fields.(tags{i}).y;
    
    axes_h = arr_axes(i);
    
    axes(axes_h);
    
    x_scale = axes_h.XScale;
    y_scale = axes_h.YScale;
    color = colors(handles.press_counter);
    
    x = x(bit_map);
    y = y(bit_map);
    
    hold on;
    
    if strcmp(tags{i},'xy')
        plot_h =  plot(y,x,['.' color]);
    elseif strcmp(x_scale,'log') && strcmp(y_scale ,'log')
        plot_h = loglog(x,y,['.' color]);
    elseif strcmp(x_scale,'log')
        plot_h = semilogx(x,y,['.' color]);
    elseif strcmp(y_scale,'log')
        plot_h = semilogy(x,y,['.' color]);
    else
        plot_h =  plot(x,y,['.' color]);
    end
    
    hold off;
    
    arr_added_plots_hs(i) = plot_h; %#ok<AGROW>
end


handles.new_plots_arr = arr_added_plots_hs;

guidata(form_h,handles);  % Add the new handles structure to the figure
 hFH.delete;
end