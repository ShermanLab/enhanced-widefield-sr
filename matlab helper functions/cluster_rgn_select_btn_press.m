function cluster_rgn_select_btn_press(hObject,eventdata)

hFH = imrect();
pos = hFH.getPosition();
delete(hFH);
xmin = pos(1);
%ymax = pos(4);
width = pos(3);

assignin('base','selection_min',xmin);
assignin('base','selection_max',xmin+width);

axes_tag = get(gca,'Tag');
h_fig = figure('Units','normalized','Position',[0.2,0.5,0.65,0.4]);

switch axes_tag
    %   case 'filtered sofi img (log scale)'
    case 'sofi histogram'
        selected_log10Sofi = evalin('base','log10sofi_img');
        selected_log10Sofi(~(xmin<=selected_log10Sofi & (xmin+width)>= selected_log10Sofi)) = 0;
  
        
        h_base_sub = evalin('base','h_sofi_histogram');
        new_h =  copyobj(h_base_sub,h_fig);
        subplot(1,2,1,new_h );
        axis([xmin xmin+width 0 100]);
        
        
        
        subplot(1,2,2);
        imagesc(selected_log10Sofi);
        title('filtered sofi img (log scale)','FontSize',22);
        colorbar;
        axis square;
        set(new_h,'FontSize',18);
        
        

        assignin('base','selected_log10Sofi',selected_log10Sofi);
        
        %    case 'filtered sum_img'
    case 'sum img histogram'
        selected_sum_img = evalin('base','sum_img');
        selected_sum_img (~(xmin<=selected_sum_img & (xmin+width)>= selected_sum_img)) = 0;
        
        h_base_sub = evalin('base','h_sum_histogram');
        new_h =  copyobj(h_base_sub,h_fig);
        subplot(1,2,1,new_h );
        axis([xmin xmin+width 0 350]);
        
        
        
        subplot(1,2,2);
        imagesc(selected_sum_img);
        title('filtered sum img (log scale)','FontSize',22);
        colorbar;
        axis square;
        set(new_h,'FontSize',18);
        
end
    evalin('base','is_selected_cutoff = 1');
     before_after_btn = uicontrol(h_fig,'Style','pushbutton','String','Before\After',...
              'Units','normalized','Position',[0.5 0.05 0.2 0.04],'Callback',@before_after_btn_press);


end