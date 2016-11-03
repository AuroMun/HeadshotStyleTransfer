function [energy] = getenergy(pyramid, levels)
    gauss_val = 2;
    for k = 1:levels-1
        % figure, imshow(img_cur);
        energy{k} = pyramid{k} .* pyramid{k};
        energy{k} = imgaussfilt(energy{k}, gauss_val);
        gauss_val = gauss_val * 2;
    end
end