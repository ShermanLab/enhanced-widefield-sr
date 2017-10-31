%calcs how many nm in each SOFI pixels
sofi_dim = sofi_img_size(1);
meas_dim = meas_img_size(1);
sofi_pixel_nm = pixel2nm*sofi_dim/meas_dim;

sq_dim =0.4;

posVect_full_sum = [-0.07, 0.01, sq_dim ,sq_dim];
posVec_fil_sum = [0.16, 0.01, sq_dim ,sq_dim ];
posVec_full_sofi = [0.4, 0.01, sq_dim ,sq_dim];
posVec_fil_sofi = [0.63, 0.01, sq_dim ,sq_dim];

fig_Cluster_Devide = figure('Name','Cluster Devide','Units','Normalized','OuterPosition',[0.01 0.01 0.9 0.9]);

cluster_rgn_select_btn = uicontrol(fig_Cluster_Devide,'Style','pushbutton','String','Select Region',...
              'Units','normalized','Position',[0.7 0.46 0.2 0.04],'Callback',@cluster_rgn_select_btn_press);
      
axes('Position',posVec_full_sofi);
imagesc(sofi_img);
axis square;
set(gca,'XTick',[]);
set(gca,'YTick',[]);

image_title = 'SOFI image ';
if use_log_sofi == true
    image_title = [image_title '(log)'];
end

title(image_title,'FontSize',18);

sum_img_here = sum_img;

axes('Position',posVect_full_sum);
imagesc(sum_img_here);
axis square;
set(gca,'XTick',[]);
set(gca,'YTick',[]);
title('sum image','FontSize',18);


x_param =sum_img_here(:);
y_param =sofi_img(:);

l_width = 1.5;
fit_gaussian  = 1;

%seperate to clusters



%% sum img histogram
h_sum_histogram = subplot(2,2,1);

sum_h = histogram(x_param,250);
sum_vals = sum_h.Values;
sum_edges = sum_h.BinEdges;

hold on;

%get first peak border
[pks,locs,w,~] = findpeaks(sum_vals,sum_edges(1:end-1),...
    'MinPeakProminence',100,'Annotate','extents',...
    'WidthReference','halfheight');

fpeaks_lower =  locs(1)-1.5*w(1);
fpeaks_upper = locs(1)+1.5*w(1);


 h_fpeaks_upper =   plot([fpeaks_upper fpeaks_upper],[0 max(sum_vals)],'r-.','LineWidth',l_width);
 h_fpeaks_lower =     plot([fpeaks_lower fpeaks_lower],[0 max(sum_vals)],'r-.','LineWidth',l_width);

if fit_gaussian
    sum_bit_map = (sum_edges(1:end-1)<= locs(1)+w(1)) & (sum_edges(1:end-1)>= locs(1)-w(1));

    x = sum_edges(1:end-1);
    x = x(sum_bit_map);
    y = sum_vals(sum_bit_map);
    
    f = fit(x.',y.','gauss1');
    sigma = f.c1*sqrt(2);
    mu = f.b1;
%    gaussian_upper = mu+sigma;
%    gaussian_lower = mu-sigma;
    
%      h_gauss_upper = plot([gaussian_upper gaussian_upper],[0 max(sum_vals)],'-.');
%      h_gauss_lower = plot([gaussian_lower gaussian_lower],[0 max(sum_vals)],'-.');
     
     gauss_draw_x = linspace( mu-2*sigma,mu+2*sigma,1e3);
     gauss_draw_y = f.a1*exp(-((gauss_draw_x-mu)/f.c1).^2);
    h_g_plot =  plot(gauss_draw_x,gauss_draw_y,'c','LineWidth',l_width);
    legend('boxoff')
end

h_sum_histogram.Tag = 'sum img histogram';

title('sum image histogram', 'FontSize',20);
xlabel('intensity [a.u]', 'FontSize',24);
ylabel('no. of pixels', 'FontSize',24);

set(gca,'FontSize',18);
set(gca,'FontName','Ariel');

axis (gca,[0 max(sum_edges) 0 max(sum_vals)]);

%% filtered sum_img_here

h_filtered_sum_img_here = axes('Position',posVec_fil_sum);
filtered_sum_img_here = sum_img_here;
filtered_sum_img_here(filtered_sum_img_here<=fpeaks_upper ) = 0;
imagesc(filtered_sum_img_here);
title('filtered sum image', 'FontSize',20);
h_filtered_sum_img_here.Tag ='filtered sum_img_here';
set(gca,'XTick',[]);
set(gca,'YTick',[]);

colorbar;
set(gca,'FontSize',18);
axis square;

%% SOFI histogram
h_sofi_histogram = subplot(2,2,2);

sofi_h =  histogram(y_param,500);
sofi_vals = sofi_h.Values;
sofi_edges = sofi_h.BinEdges;

first = find(sofi_vals>10,1, 'first');
last = find(sofi_vals>10, 1,'last');

hold on;

[pks,locs,w,~] = findpeaks(sofi_vals,sofi_edges(1:end-1),'MinPeakProminence',50,'WidthReference','halfheight');

first_pos_i =1;

fpeaks_lower =  locs(first_pos_i)-1.5*w(first_pos_i);
fpeaks_upper = locs(first_pos_i)+1.5*w(first_pos_i);

h_fpeaks_upper =  plot([fpeaks_upper fpeaks_upper],[0 max(sofi_vals)] ,'r-.','LineWidth',l_width);
h_fpeaks_lower = plot([fpeaks_lower fpeaks_lower],[0 max(sofi_vals)],'r-.','LineWidth',l_width);

if fit_gaussian

    sofi_bit_map  = (sofi_edges(1:end-1)<= locs(first_pos_i)+1.5*w(first_pos_i)) & (sofi_edges(1:end-1)>= locs(first_pos_i)-1.5*w(first_pos_i));
    x = sofi_edges(1:end-1);
    x = x(sofi_bit_map);
    y = sofi_vals(sofi_bit_map');
    
    
    f = fit(x',y','gauss1');
    sigma = f.c1*sqrt(2);
    mu = f.b1;
    gaussian_upper = mu+sigma;
    gaussian_lower = mu-sigma;
    
    
    gauss_draw_x = linspace( mu-2*sigma,mu+2*sigma,1e3);
    gauss_draw_y = f.a1*exp(-((gauss_draw_x-mu)/f.c1).^2);
    plot(gauss_draw_x,gauss_draw_y,'c','LineWidth',l_width);
    
    %this calculates the upper border according to the user input of
    %p_false_alarm. NORMINV calcs the inverse of the CDF of the normal
    %distribution. 
    p_fa_upper_border= norminv(1-p_false_alarm,mu,sigma);      
    legend('boxoff')
    
end

h_sofi_histogram.Tag = 'sofi histogram';
axis tight;

if use_log_sofi == true
    x_title = 'log(SOFI val) [a.u]';
    main_title = 'SOFI image histogram (log)';
else
    x_title = 'SOFI val [a.u]';
    main_title = 'SOFI image histogram';
end
xlabel(x_title, 'FontSize',24);
ylabel('no. of pixels', 'FontSize',24);
set(gca,'FontSize',18);
set(gca,'FontName','Ariel');

title(main_title, 'FontSize',20);

%% filtered SOFI img
h_filtered_sofi_img = axes('Position',posVec_fil_sofi);
filtered_log10Sofi = sofi_img;
if fit_gaussian
    filtered_log10Sofi( abs(filtered_log10Sofi)<p_fa_upper_border) = 0;
else
    filtered_log10Sofi(fpeaks_upper>filtered_log10Sofi & filtered_log10Sofi>fpeaks_lower) = 0;
end

imagesc(filtered_log10Sofi>0);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

image_title = 'filtered SOFI image';
if use_log_sofi == true
    image_title = [image_title ' (log)'];
    
end

title(image_title , 'FontSize',20);
colormap parula;
colorbar;
set(gca,'FontSize',18);
h_filtered_sofi_img.Tag = 'filtered SOFI img (log scale)';
axis square;








