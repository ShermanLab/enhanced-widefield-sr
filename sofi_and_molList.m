addpath('.\matlab helper functions');

%meas param
pixel2nm = 160; %how many nm in each pxl in the measured image

% read mol list
mol_fields = get_mol_list_type();
data = get_mol_list(mol_list_path,mol_fields,1);
clear mol_fields;

%fix bugs from thunderSTORM mol list and get only relavent points in range
uncrtnty =  data.uncertainty_nm;
uncrtnty(uncrtnty>100) = 100;
data.uncertainty_nm = uncrtnty;
palm_Xs = data.x_nm;
palm_Ys = data.y_nm;
palm_frames = data.frame;

clear uncrtnty ;
%clear mol_list_path multi_tiff_full_path;

frames_bit_map =  palm_frames>=1 & palm_frames<=number_of_frames;
palm_frames = palm_frames(frames_bit_map);
palm_Xs = palm_Xs(frames_bit_map);
palm_Ys = palm_Ys(frames_bit_map);

%perform SOFI analysis
%load images
imgs = LocalizerMatlab('readccdimages',first_frame-1,number_of_frames,multi_tiff_full_path);
meas_img_size = size(imgs(:,:,1));
timelapses = ones(1,sofi_order-1)*time_lapse;

%run SOFI script
if is_bSOFI  || sofi_order>3
    [sofi_img, ~] = LocalizerMatlab('newsofi',sofi_order,0,imgs);
    sofi_img = sofi_img{1};
else
    [sofi_img, ~] = LocalizerMatlab('sofi',sofi_order,is_xc,timelapses,0,-1,imgs);
end
sofi_img_size = size(sofi_img);
sofi_dim = sofi_img_size(1);

%build log SOFi img
%log10sofi_img = log10(sofi_img + abs(min(sofi_img(:))) + 1);
log10sofi_img = log10(abs(sofi_img ));

if use_log_sofi == true
 sofi_img = log10sofi_img;
end


%create sum img
sum_img = sum(imgs,3);

clear frames_bit_map timelapses;