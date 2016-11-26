%addpath('.\bin_graphcuts');
%im = imread('face1.png');
%im = imresize(im, [420 NaN]);
function [masked] = masker(img)
    im_out = grabcut(im, 50);
    [x, y, z] = size(im_out);
    masked = im_out;
    for i=1:x
        for j=1:y
            if im_out(i,j)==255 && ((i-x/2)*(i-x/2)+(j-y/2)*(j-y/2)>80*80)
                masked(i,j,1)=0;
                masked(i,j,2)=0;
                masked(i,j,3)=0;
            else
                masked(i,j,1)=1;
                masked(i,j,2)=1;
                masked(i,j,3)=1;
            end
        end
    end
    %imshow(im.*masked);
end
    