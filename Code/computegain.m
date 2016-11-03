function [gain] = computegain(energy1, energy2, levels)
    gauss_cur = 1;
    for k = 1:levels-1
        gain{k} = sqrt(energy2{k} ./ (energy1{k} + 0.00001));
        % Clamp the gains
        gain{k} = imgaussfilt(max(min(gain{k}, 2.8), 0.9), 3 * gauss_cur);
        gauss_cur = gauss_cur * 2;
    end
end