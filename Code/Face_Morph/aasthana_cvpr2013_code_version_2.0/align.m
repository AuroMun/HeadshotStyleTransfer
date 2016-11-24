p1 = detect('face1.png', 0);
p2 = detect('face2.png', 0);

img1 = imresize(imread('face1.png'), [300 230]);
img2 = imresize(imread('face2.png'), [300 230]);

new_points1 = zeros(66+13, 2);
new_points2 = zeros(66+13, 2);
for i=1:66
    new_points1(i,:) = p1.points(i,:);
    new_points2(i,:) = p2.points(i,:);
end
for i=1:13
    new_points1(66+i,1) = p1.points(i+2,1);
    new_points1(66+i,2) = p1.points(i+2,2)*-1 + 300;
    new_points1(66+i,2) = new_points1(66+i,2) / exp((200 - new_points1(66+i,2))/300);
    new_points1(66+i,2) = new_points1(66+i,2) + 25;
    new_points2(66+i,1) = p2.points(i+2,1);
    new_points2(66+i,2) = p2.points(i+2,2)*-1 + 300;
    new_points2(66+i,2) = new_points2(66+i,2) / exp((200 - new_points2(66+i,2))/300);
    new_points2(66+i,2) = new_points2(66+i,2) + 25;
end
p1.points = new_points1;
p2.points = new_points2;
figure, imshow(img2);
axis image;
hold on;
plot(new_points2(:,1),new_points2(:,2),'r.')
%Delaunay points of mean face points
dis = (p1.points+p2.points)/2;
x = dis(:, 1); y = dis(:, 2);
tri = delaunay(x,y);

%https://github.com/GabriellaQiong/Face-Morphing/blob/master/morph.m% 
morphed_im = morph(p1.img*255, p2.img*255, p1.points, p2.points, tri, 1,0 , 0);

%Show image%
%figure, imshowpair(p2.img, morphed_im, 'montage');
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

