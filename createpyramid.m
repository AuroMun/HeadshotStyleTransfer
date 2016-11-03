function [pyramid] = createpyramid(img, levels)
    img_old = img;
    img_cur = imgaussfilt(img,2);
    for k = 1:levels-1
        % figure, imshow(img_cur);
        pyramid{k} = img_old - img_cur;
        img_old = img_cur;
        img_cur = imgaussfilt(img_cur,2);
    end
    pyramid{levels} = img_cur;
end