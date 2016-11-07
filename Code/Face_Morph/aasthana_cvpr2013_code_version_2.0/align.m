p1 = detect('face1.png', 0);
p2 = detect('face2.png', 0);

%Delaunay points of mean face points
dis = (p1.points+p2.points)/2;
x = dis(:, 1); y = dis(:, 2);
tri = delaunay(x,y);

%https://github.com/GabriellaQiong/Face-Morphing/blob/master/morph.m% 
morphed_im = morph(p1.img*255, p2.img*255, p1.points, p2.points, tri, 1,0 , 0);

%Show image%
imshowpair(p1.img, morphed_im, 'montage');


