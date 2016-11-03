function [gain] = computegain(energy1, energy2, levels)
    for k = 1:levels-1
        gain{k} = sqrt(energy2{k} ./ (energy1{k} + 0.0000001));
    end
end