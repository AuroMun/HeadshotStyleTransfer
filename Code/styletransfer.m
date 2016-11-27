levels = 18;
compute_masks = 1;
origFace = 'face28.png';
styleFace = 'face30.png';
origPath = fullfile('./Inputs/', origFace);
stylePath = fullfile('./Inputs/', styleFace);
addpath('./Face_Morph/aasthana_cvpr2013_code_version_2.0');
addpath('./grabcut-master');
addpath('./grabcut-master/bin_graphcuts');
img_orig = imread(origPath);
img_style_backup = imread(stylePath);
img_style_backup = imresize(img_style_backup, [300 230]);
img_style = alignFunction(origFace, styleFace);
img_orig = imresize(img_orig, [300 230]);
img_orig_backup = img_orig;
img_orig_old = img_orig;
img_style = imresize(img_style, [300 230]);

% Add a small noise so that patches of same color don't cause issues in
% grab cut (Same color patch grab cut cannot do anything)
img_style = uint8(img_style*255.0) + uint8(rand(size(img_style))*5);
img_style = min(img_style, 255);
img_orig = img_orig + uint8(rand(size(img_orig))*5);
img_orig = min(img_orig, 255);

%figure, imshow(imresize(imread('Inputs/face52.png'), [300 230]));
%figure, imshow(img_orig);
%figure, imshow(img_style);

if compute_masks == 1
    mask3 = masker(img_style, 1);
end
maskx = rgb2gray(mask3);
maskx = imclose(maskx, strel('disk', 3));
maskx = imclose(maskx, strel('disk', 3));
maskx = double(maskx);
maskx = imfilter(maskx, fspecial('gaussian', 10, 5));

background_img(:,:,1) = (1-maskx).*double(img_style(:,:,1))/255.0;
background_img(:,:,2) = (1-maskx).*double(img_style(:,:,2))/255.0;
background_img(:,:,3) = (1-maskx).*double(img_style(:,:,3))/255.0;
for i=1:8
    background_img(:,:,1) = imgaussfilt(ordfilt2(background_img(:,:,1), 25*25, true(25)), 10, 'FilterSize', 11, 'Padding', 'replicate');
    background_img(:,:,2) = imgaussfilt(ordfilt2(background_img(:,:,2), 25*25, true(25)), 10, 'FilterSize', 11, 'Padding', 'replicate');
    background_img(:,:,3) = imgaussfilt(ordfilt2(background_img(:,:,3), 25*25, true(25)), 10, 'FilterSize', 11, 'Padding', 'replicate');
end

% Darken it a bit since we have performed many max operations
background_img = background_img/1.2;

%figure, imshow(uint8(background_img*255.0));

if compute_masks == 1
    mask2 = masker(img_orig, 1);
end
mask = rgb2gray(mask2);
mask = imclose(mask, strel('disk', 3));
mask = imopen(mask, strel('disk', 3));
mask = imerode(mask, strel('disk', 1));

mask = double(mask);
orig_mask = mask;
% Blur the mask to avoid sudden changes so that the gains work well
mask = imfilter(mask, fspecial('gaussian', 10, 5));

img_orig = double(img_orig);
img_style = double(img_style);

img_orig(:,:,1) = img_orig(:,:,1).*mask;
img_orig(:,:,2) = img_orig(:,:,2).*mask;
img_orig(:,:,3) = img_orig(:,:,3).*mask;

img_style = imresize(img_style, [size(img_orig,1) size(img_orig,2)]);
img_orig = double(img_orig) / 255.0;
img_style = double(img_style) / 255.0;

figure, imshow(uint8(img_orig * 255.0));
figure, imshow(uint8(img_style * 255.0));

img_orig = RGB2LAB(img_orig);
img_style = RGB2LAB(img_style);

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
final_img = LAB2RGB(final_img);

img_style = LAB2RGB(img_style);

background_img = double(background_img);
orig_mask = imfilter(orig_mask, fspecial('gaussian', 5, 2));
final_img(:,:,1) = final_img(:,:,1).*orig_mask + background_img(:,:,1).*(1-orig_mask);
final_img(:,:,2) = final_img(:,:,2).*orig_mask + background_img(:,:,2).*(1-orig_mask);
final_img(:,:,3) = final_img(:,:,3).*orig_mask + background_img(:,:,3).*(1-orig_mask);

final_img = uint8(final_img * 255.0);

%figure, imshow(final_img);

% High boost filtering
gauss_fin_img = imfilter(final_img, fspecial('gaussian', 3, 3));
final_img = final_img + (final_img-gauss_fin_img)*0.7;

%figure, imshow(final_img);
montage([img_orig_backup, img_style_backup, final_img]);
