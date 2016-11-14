p2 = detect('face1.png', 0);
p1 = detect('face2.png', 0);

figure, imshow(imread('face1.png'));
figure, imshow(imread('face2.png'));

%Delaunay points of mean face points
dis = (p1.points+p2.points)/2;
x = dis(:, 1); y = dis(:, 2);
tri = delaunay(x,y);

%https://github.com/GabriellaQiong/Face-Morphing/blob/master/morph.m% 
morphed_im = morph(p1.img*255, p2.img*255, p1.points, p2.points, tri, 1,0 , 0);

%Show image%
imshowpair(p2.img, morphed_im, 'montage');
morphed_im = im2double(morphed_im);
orig = p2.img;

for i=1:size(orig,1)
    for j=1:size(orig,2)
        if ~(morphed_im(i,j,1) == 0 && morphed_im(i,j,2) == 0 && morphed_im(i,j,3) == 0) 
            orig(i,j,:) = morphed_im(i,j,:);
        end
    end
end

figure, imshow(orig);

