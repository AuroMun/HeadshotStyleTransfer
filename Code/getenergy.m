function [energy] = getenergy(pyramid, levels)
    cur_gauss = 2;
    for k = 1:levels-1
        % figure, imshow(img_cur);
        energy{k} = pyramid{k} .* pyramid{k};
        energy{k} = imfilter(energy{k}, fspecial('gaussian', cur_gauss, cur_gauss));
        cur_gauss = cur_gauss * 2;
    end
end