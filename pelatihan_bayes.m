% Hanif Razin Rahmatullah
% Email  : hanifrazin@gmail.com

clc;clear;close all;

image_folder = 'data latih 3';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

area = zeros(total_images,1);
perimeter = zeros(total_images,1);
ro = zeros(total_images,1);
co = zeros(total_images,1);
rect = zeros(total_images,1);
length = zeros(total_images,1);
width = zeros(total_images,1);
minor_axis = zeros(total_images,1);
mayor_axis = zeros(total_images,1);
elongation = zeros(total_images,1);

for n = 1:total_images
    full_name = fullfile(image_folder, filenames(n).name);
    Img = imread(full_name);
    Gray = rgb2gray(Img);
    Contrast = imadjust(Gray,stretchlim(Gray),[]);
    MedImg = ordfilt2(Contrast,5,ones(3,3));
    Crop = imcrop(MedImg,[105.5 9.5 193 106]);
    Resize = imresize(Crop,[75 150]);
    Biner = not(imbinarize(Resize,0.8));
    
    Close = bwmorph(Biner,'close');
    Open = bwmorph(Close,'open');
    stats = regionprops(Close,'all');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    co(n) = (perimeter(n)^2)/area(n);
    ro(n) = (4*pi*area(n))/(perimeter(n)^2);
    minor_axis(n) = stats.MinorAxisLength;
    mayor_axis(n) = stats.MajorAxisLength;
    rect(n) = area(n)/(minor_axis(n)*mayor_axis(n));
    elongation(n) = 1 - (minor_axis(n)/mayor_axis(n));
end

trainset = [ro co rect elongation];

% prepare class label for first run of naive bayes
class=zeros(18,1);
class(1:6,1)=1;
class(7:12,1)=2;
class(13:18,1)=3;

% perform run of Naive Bayes Classifer
BayesModel = fitcnb(trainset,class);

% BayesModel = NaiveBayes.fit(trainset,class);

save BayesGolok.mat BayesModel