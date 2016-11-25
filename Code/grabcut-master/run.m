addpath('.\bin_graphcuts');
im = imread('face1.png');
im = imresize(im, [420 NaN]);
im_out = grabcut(im, 100);
[x, y,z] = size(im_out);
mask = im_out;
for i=1:x
    for j=1:y
        if im_out(i,j)==255 && ((i-x/2)*(i-x/2)+(j-y/2)*(j-y/2)>80*80)
            mask(i,j,1)=0;
            mask(i,j,2)=0;
            mask(i,j,3)=0;
        else
            mask(i,j,1)=1;
            mask(i,j,2)=1;
            mask(i,j,3)=1;
        end
    end
end
imshow(im.*mask);