function reset_btn_press(hObject,~)
handles = guidata(gcbf);
%if exist('handles.new_plots_arr') && numel(handles.new_plots_arr)~=0
    for i=1:numel(handles.new_plots_arr)
        delete(handles.new_plots_arr(i));
    end
%end
handles.new_plots_arr = [];


form_h = hObject.Parent;

guidata(form_h,handles);  % Add the new handles structure to the figure
end