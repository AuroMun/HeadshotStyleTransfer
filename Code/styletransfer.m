levels = 6;

img_orig = imread('Inputs/face1.png');
img_style = imread('Inputs/face2.png');
img_style = imresize(img_style, [size(img_orig,1) size(img_orig,2)]);
img_orig = double(img_orig) / 255.0;
img_style = double(img_style) / 255.0;

figure, imshow(uint8(img_orig * 255.0));
figure, imshow(uint8(img_style * 255.0));

img_orig = RGB2LAB(img_orig);
img_orig(:,:,1) = img_orig(:,:,1) / 100.0;
img_orig(:,:,2) = (img_orig(:,:,2) + 100.0) / 200.0;
img_orig(:,:,3) = (img_orig(:,:,3) + 100.0) / 200.0;
img_style = rgb2lab(img_style);
img_style(:,:,1) = img_style(:,:,1) / 100.0;
img_style(:,:,2) = (img_style(:,:,2) + 100.0) / 200.0;
img_style(:,:,3) = (img_style(:,:,3) + 100.0) / 200.0;

% When we perform warping however, we should calculate the energy initially
% and then for whatever warping is done, perform the corresponding changes
% on the energy image as well. This is to ensure we don't get noisy energy
% images which would be the case if we apply energy calculation directly on
% the warped images. (energy2 would need to be warped accordingly)

pyramid1 = createpyramid(img_orig, levels);
energy1 = getenergy(pyramid1, levels);

pyramid2 = createpyramid(img_style, levels);
energy2 = getenergy(pyramid2, levels);

gain = computegain(energy1, energy2, levels);

final_pyramid = robusttransfer(pyramid1, pyramid2, gain, levels);
final_img = reconstructimage(final_pyramid, levels);
final_img(:,:,1) = final_img(:,:,1) * 100.0;
final_img(:,:,2) = final_img(:,:,2) * 200.0 - 100.0;
final_img(:,:,3) = final_img(:,:,3) * 200.0 - 100.0;
final_img = LAB2RGB(final_img);

figure, imshow(uint8(final_img * 255.0));
