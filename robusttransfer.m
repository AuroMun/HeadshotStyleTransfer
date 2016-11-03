function [final_pyramid] = robusttransfer(pyramid1, pyramid2, gain)
    for k = 1:levels-1
        final_pyramid{k} = pyramid1{k} .* gain{k};
    end
    final_pyramid{levels} = pyramid2{levels};
end