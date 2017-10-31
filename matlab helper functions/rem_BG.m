function trunc_BG_img = rem_BG(img,num_bins,percent_BG_in_signal,remove_str)

if strcmp(remove_str,'none')
    trunc_BG_img = img;
    return;
end


[sofi_vals,sofi_edges] = histcounts(img(:),num_bins);

sofi_edges = sofi_edges(1:end-1);


switch remove_str
    case {'mask','mean'}
        [pks,locs,w,~] = findpeaks(sofi_vals,sofi_edges,'MinPeakProminence',100,'Annotate','extents','WidthReference','halfheight');
     %   first_pos_i = find(locs>=0,1,'first');
        first_pos_i =1;
        
        sofi_bit_map  = (sofi_edges<= (locs(first_pos_i)+1.5*w(first_pos_i))) & (sofi_edges>= locs(first_pos_i)-1.5*w(first_pos_i));
        
        x = sofi_edges(sofi_bit_map);
        y = sofi_vals(sofi_bit_map');
        
        
        f = fit(x',y','gauss1');
        sigma = f.c1*sqrt(2);
        mu = f.b1;
end






switch remove_str
    case 'mask'
   
        BG_cutoff= norminv(1-percent_BG_in_signal,mu,sigma);
    case 'mean'
        BG_cutoff = mu;

end

img(img<=BG_cutoff) = 0;
trunc_BG_img = img;


end