function [pyramid] = createpyramid(img, levels)
    img_old = img;
    cur_gauss = 1.2;
    img_cur = imfilter(img, fspecial('gaussian', round(cur_gauss+1), cur_gauss));
    for k = 1:levels-1
        pyramid{k} = img_old - img_cur;
        img_old = img_cur;
        cur_gauss = cur_gauss * 1.2;
        img_cur = imfilter(img, fspecial('gaussian', round(cur_gauss+1), cur_gauss));
    end
    pyramid{levels} = img_cur;
end