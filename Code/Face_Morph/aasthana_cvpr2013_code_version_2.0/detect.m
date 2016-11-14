%For one picture%
%data.points has 66 sets of points%
function data = detect(image, vis)

addpath(genpath('.'));
im = imread(image);
data(1).name = image;
data(1).img = imresize(im2double(im), [300 230]);
data(1).points = [];
data(1).pose = [];

clm_model = 'model/DRMF_Model.mat';
load(clm_model);    
data = DRMF(clm_model,data,1,vis);    