function [gain] = computegain(energy1, energy2, levels)
    cur_gauss = 1;
    for k = 1:levels-1
        gain{k} = sqrt(energy2{k} ./ (energy1{k} + 0.00001));
        % Clamp the gains
        gain{k} = max(min(gain{k}, 2.8), 0.9);
        gain{k} = imfilter(gain{k}, fspecial('gaussian', cur_gauss, cur_gauss));
        cur_gauss = cur_gauss * 2;
    end
end