function [energy] = getenergy(pyramid, levels)
    cur_gauss = 1.2;
    for k = 1:levels-1
        % figure, imshow(img_cur);
        energy{k} = pyramid{k} .* pyramid{k};
        energy{k} = imfilter(energy{k}, fspecial('gaussian', round(cur_gauss+1), cur_gauss));
        cur_gauss = cur_gauss * 1.2;
    end
end