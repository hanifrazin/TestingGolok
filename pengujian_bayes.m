% Adi Pamungkas, S.Si, M.Si
% Website: https://pemrogramanmatlab.com/
% Email  : hanifrazin@gmail.com

clc;clear;close all;

image_folder = 'data uji';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

area = zeros(1,total_images);
perimeter = zeros(1,total_images);
diameter = zeros(1,total_images);
ro = zeros(1,total_images);
co = zeros(1,total_images);
solidity = zeros(1,total_images);
eccentricity = zeros(1,total_images);
slim = zeros(1,total_images);
rect = zeros(1,total_images);
narrow = zeros(1,total_images);
rpd = zeros(1,total_images);
prp = zeros(1,total_images);
length = zeros(1,total_images);
width = zeros(1,total_images);

for n = 1:total_images
    full_name = fullfile(image_folder, filenames(n).name);
    Img = imread(full_name);

    Gray = rgb2gray(Img);
    Contrast = imadjust(Gray,stretchlim(Gray),[]);
    MedImg = medfilt2(Contrast);
    Crop = imcrop(MedImg,[105.5 9.5 193 106]);
    Resize = imresize(Crop,[75 150]);
    Biner = Resize < 200;

    SE1 = ones(3);
    SE2 = ones(2);
    Close = bwmorph(Biner,'close',2);
    Open = bwmorph(Close,'open');

    conv = bwconvhull(Open);
    stats = regionprops(conv,'all');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    co(n) = (perimeter(n)^2)/area(n);
    ro(n) = 4*pi*area(n)/(perimeter(n)^2);
    eccentricity(n) = stats.Eccentricity;
    solidity(n) = stats.Solidity;
    diameter(n) = stats.EquivDiameter;
    length(n) = stats.BoundingBox(3);
    width(n) = stats.BoundingBox(4);
    slim(n) = length(n)/width(n);
    rect(n) = (length(n)*width(n))/area(n);
    rpd(n) = perimeter(n)/diameter(n);
    prp(n) = perimeter(n)/(length(n)+width(n));
    narrow(n) = diameter(n)/length(n);
    testset = [co]';
end

load BayesModelGolok
% Testing
isLabels = predict(BayesModel,testset);

% [label,Posterior,Cost] = predict(BayesModel,testset)
% isLabels = BayesModel.predict(testset)
% kelas_uji_asli = data
%accuracy = mean(isLabels==predict)*100


