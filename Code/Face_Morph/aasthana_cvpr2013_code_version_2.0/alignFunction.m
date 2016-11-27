function img = alignFunction(orig, style)
    origPath = fullfile('./Inputs/', orig);
    stylePath = fullfile('./Inputs/', style);
    p1 = detect(origPath, 0); % Content image
    p2 = detect(stylePath, 0); % Style image

    img1 = imresize(imread(origPath), [300 230]);
    img2 = imresize(imread(stylePath), [300 230]);

    figure, imshow(img1);
    figure, imshow(img2);

    border_points = 3;
    new_points1 = zeros(66+13+(border_points+1)*4, 2);
    new_points2 = zeros(66+13+(border_points+1)*4, 2);
    for i=1:66
        new_points1(i,:) = p1.points(i,:);
        new_points2(i,:) = p2.points(i,:);
    end
    for i=1:13
        new_points1(66+i,1) = p1.points(i+2,1);
        new_points1(66+i,2) = (p1.points(i+2,2)-p1.points(1,2))*-1 + p1.points(1,2);
        new_points1(66+i,2) = new_points1(66+i,2) / exp((200 - new_points1(66+i,2))/300);
        new_points1(66+i,2) = new_points1(66+i,2) + 35;
        new_points2(66+i,1) = p2.points(i+2,1);
        new_points2(66+i,2) = (p2.points(i+2,2)-p2.points(1,2))*-1 + p2.points(1,2);
        new_points2(66+i,2) = new_points2(66+i,2) / exp((200 - new_points2(66+i,2))/300);
        new_points2(66+i,2) = new_points2(66+i,2) + 35;
    end
    for i=1:border_points+1
        new_points1(66+13+i,1) = 0; new_points1(66+13+i,2) = (i-1)*0/border_points + (border_points-i+1)*300/border_points;
        new_points2(66+13+i,1) = 0; new_points2(66+13+i,2) = (i-1)*0/border_points + (border_points-i+1)*300/border_points;
        new_points1(66+13+(border_points+1)+i,1) = 230; new_points1(66+13+(border_points+1)*1+i,2) = (i-1)*0/border_points + (border_points-i+1)*300/border_points;
        new_points2(66+13+(border_points+1)+i,1) = 230; new_points2(66+13+(border_points+1)*1+i,2) = (i-1)*0/border_points + (border_points-i+1)*300/border_points;
        new_points1(66+13+(border_points+1)*2+i,1) = (i-1)*0/border_points + (border_points-i+1)*230/border_points; new_points1(66+13+(border_points+1)*2+i,2) = 0;
        new_points2(66+13+(border_points+1)*2+i,1) = (i-1)*0/border_points + (border_points-i+1)*230/border_points; new_points2(66+13+(border_points+1)*2+i,2) = 0;
        new_points1(66+13+(border_points+1)*3+i,1) = (i-1)*0/border_points + (border_points-i+1)*230/border_points; new_points1(66+13+(border_points+1)*3+i,2) = 300;
        new_points2(66+13+(border_points+1)*3+i,1) = (i-1)*0/border_points + (border_points-i+1)*230/border_points; new_points2(66+13+(border_points+1)*3+i,2) = 300;
    end
    p1.points = new_points1;
    p2.points = new_points2;

    %Delaunay points
    % We need to warp style image to the content image
    dis = p1.points;
    x = dis(:, 1); y = dis(:, 2);
    tri = delaunay(x,y);

    %https://github.com/GabriellaQiong/Face-Morphing/blob/master/morph.m%
    % Warps given 2 images to the triangulation specified considering
    % weightages as the second last parameter. Here since its 0, we would warp
    % the style image (p2) to the specified triangulation of the content image
    % (p1) and then return that as the final morphed style image
    morphed_im = morph(uint8(p2.img*255), uint8(p1.img*255), p2.points, p1.points, tri, 1, 0, 0);

    morphed_im = im2double(morphed_im);

    new_style_img = morphed_im;
    figure, imshow(new_style_img);
    figure, imshow(new_style_img);
    axis image;
    hold on;
    plot(new_points1(:,1),new_points1(:,2),'r.')

    %imwrite(new_style_img, '../../Inputs/final.png');
    img = new_style_img;

