function img_new = bilateral(img,g_sigma,f_sigma,window_size)
    img = double(img);
    img = img / 255.0;

    img = padarray(img, [floor(window_size/2) floor(window_size/2)]);
    
    gauss_func = @(a,b,c) exp(-((a-b)*(a-b))/2*c*c);
    inverse_gauss_func = @(a,b,c) exp(-(1.0-(a-b)*(a-b))/2*c*c);

    img_new = img;
    
    for i=1:2*floor(window_size/2)+1
        for j=1:2*floor(window_size/2)+1
            gauss_res(i,j) = gauss_func(0,i-1-floor(window_size/2),g_sigma)*gauss_func(0,j-1-floor(window_size/2),g_sigma);
        end
    end
    
    for i=floor(window_size/2)+1:size(img,1)-floor(window_size/2)
        for j=floor(window_size/2)+1:size(img,2)-floor(window_size/2)
            cur_val = gauss_res.*inverse_gauss_func(img(i,j),img(i-floor(window_size/2):i+floor(window_size/2),j-floor(window_size/2):j+floor(window_size/2)),f_sigma);
            cur_normalize = sum(sum(cur_val));
            cur_val = cur_val .* img(i-floor(window_size/2):i+floor(window_size/2),j-floor(window_size/2):j+floor(window_size/2));
            img_new(i,j) = sum(sum(cur_val)) / cur_normalize;
        end
    end
    disp(size(img_new));
    img_new = uint8(img_new*255.0);
    img = uint8(img*255.0);
end