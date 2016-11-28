function [gain] = computegain(energy1, energy2, levels)
    cur_gauss = 1.2;
    for k = 1:levels-1
        gain{k} = sqrt(energy2{k} ./ (energy1{k} + 0.00001));
        % Clamp the gains
        gain{k} = max(min(gain{k}, 2.9), 0.1);
        gain{k} = imfilter(gain{k}, fspecial('gaussian', round(cur_gauss+1), cur_gauss));
        cur_gauss = cur_gauss * 1.2;
    end
end