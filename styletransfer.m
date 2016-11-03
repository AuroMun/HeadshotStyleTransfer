img = imread('face1.jpg');
img = imresize(img, [300 NaN]);
pyramid = createpyramid(img,3);