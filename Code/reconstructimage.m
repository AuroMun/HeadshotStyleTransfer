function [img_final] = reconstructimage(pyramid, levels)
    img_final = pyramid{levels};
    for k = levels-1:-1:1
        %figure, imshow(uint8(img_final));
        img_final = img_final + pyramid{k};
    end
end