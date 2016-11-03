img_orig = imread('face1.jpg');
img_style = imread('face2.jpg');
img_orig = imresize(img_orig, [300 NaN]);
img_style = imresize(img_style, [300 NaN]);

% When we perform warping however, we should calculate the energy initially
% and then for whatever warping is done, perform the corresponding changes
% on the energy image as well. This is to ensure we don't get noisy energy
% images which would be the case if we apply energy calculation directly on
% the warped images. (energy2 would need to be warped accordingly)

pyramid1 = createpyramid(img_orig,3);
energy1 = getenergy(pyramid1,3);

pyramid2 = createpyramid(img_style,3);
energy2 = getenery(pyramid2,3);

gain = computegain(energy1, energy2);

final_pyramid = robusttransfer(pyramid1, pyramid2, gain);

