% Hanif Razin Rahmatullah
% Email  : hanifrazin@gmail.com

clc;clear;close all;

image_folder = 'data latih';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

area = zeros(total_images,1);
perimeter = zeros(total_images,1);
diameter = zeros(total_images,1);
convex_perim = zeros(total_images,1);
ro = zeros(total_images,1);
co = zeros(total_images,1);
slim = zeros(total_images,1);
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
    Median = medfilt2(Contrast,[3 3]);
    Crop = imcrop(Median,[105.5 9.5 193 106]);
    Resize = imresize(Crop,[75 150]);
%     Biner = Resize < 200;
%     Biner = not(Resize > 200);
    Biner = not(imbinarize(Resize,0.8));
%     Biner = imbinarize(Resize,0.8);
    
    SE = ones(3);
    Close2 = imclose(Biner,SE);
    Open2 = imopen(Close2,SE);
    Close = bwmorph(Biner,'close');
    Open = bwmorph(Close,'open');
    Conv = bwconvhull(Open);
%     figure,imshow(Open);title(filenames(n).name);
    stats = regionprops(Open,'all');
    stats_conv = regionprops(Conv,'all');
    area(n) = stats.Area;
    diameter(n) = stats.EquivDiameter;
    perimeter(n) = stats.Perimeter;
    convex_perim(n) = stats_conv.Perimeter;
    ro(n) = (4*area(n))/(pi*(diameter(n)^2));
    co(n) = (4*pi*area(n))/(perimeter(n)^2);
%     co(n) = (perimeter(n)^2)/(4*pi*area(n));
    minor_axis(n) = stats.MinorAxisLength;
    mayor_axis(n) = stats.MajorAxisLength;

    rect(n) = area(n)/(minor_axis(n)*mayor_axis(n));
    elongation(n) = 1 - (minor_axis(n)/mayor_axis(n));
    
end

image_folder_uji = 'data uji';
filenames_uji = dir(fullfile(image_folder_uji, '*.jpg'));
total_images_uji = numel(filenames_uji);

area_uji = zeros(total_images_uji,1);
perimeter_uji = zeros(total_images_uji,1);
diameter_uji  = zeros(total_images_uji,1);
convex_perim_uji = zeros(total_images_uji,1);
ro_uji = zeros(total_images_uji,1);
co_uji = zeros(total_images_uji,1);
slim_uji = zeros(total_images_uji,1);
rect_uji = zeros(total_images_uji,1);
length_uji = zeros(total_images_uji,1);
width_uji = zeros(total_images_uji,1);
minor_axis_uji = zeros(total_images_uji,1);
mayor_axis_uji = zeros(total_images_uji,1);
elongation_uji = zeros(total_images_uji,1);


for n = 1:total_images_uji
    full_name_uji = fullfile(image_folder_uji, filenames_uji(n).name);
    Img_uji = imread(full_name_uji);
    
    Gray_uji = rgb2gray(Img_uji);
    Contrast_uji = imadjust(Gray_uji,stretchlim(Gray_uji),[]);
    Median_uji = medfilt2(Contrast_uji,[3 3]);
    Crop_uji = imcrop(Median_uji,[105.5 9.5 193 106]);
    Resize_uji = imresize(Crop_uji,[75 150]); 

    Biner_uji = not(imbinarize(Resize_uji,0.8));
%     Biner_uji = imbinarize(Resize_uji,0.8);
    
    SE_uji = ones(3);
    Close_uji2 = imclose(Biner_uji,SE_uji);
    Open_uji2 = imopen(Close_uji2,SE_uji);
    Close_uji = bwmorph(Biner_uji,'close');
    Open_uji = bwmorph(Close_uji,'open');
    Conv_uji = bwconvhull(Open_uji);
%     figure,imshow(Open_uji);title(filenames_uji(n).name);
%     path_uji = ['C:\Users\HANIF\Documents\MATLAB\Naive Bayes - Golok\Biner\Morph ',filenames_uji(n).name]
%     imwrite(Open_uji,path_uji,'jpg')
    
    stats_uji = regionprops(Open_uji,'all');
    stats_conv_uji = regionprops(Conv_uji,'all');
    area_uji(n) = stats_uji.Area;
    perimeter_uji(n) = stats_uji.Perimeter;
    diameter_uji(n) = stats_uji.EquivDiameter;
    convex_perim_uji(n) = stats_conv_uji.Perimeter;
    ro_uji(n) = (4*area_uji(n))/(pi*(diameter_uji(n)^2));
    co_uji(n) = (4*pi*area_uji(n))/(perimeter_uji(n)^2);
%     co_uji(n) = (perimeter_uji(n)^2)/(4*pi*area_uji(n));
    length_uji(n) = stats_uji.BoundingBox(3);
    width_uji(n) = stats_uji.BoundingBox(4);    
    minor_axis_uji(n) = stats_uji.MinorAxisLength;
    mayor_axis_uji(n) = stats_uji.MajorAxisLength;
    slim_uji(n) = mayor_axis_uji(n)/minor_axis_uji(n);
    rect_uji(n) = area_uji(n)/(mayor_axis_uji(n)*minor_axis_uji(n));
    elongation_uji(n) = 1 - (minor_axis_uji(n)/mayor_axis_uji(n));
end

trainset = [ro co rect elongation];
testset  = [ro_uji co_uji rect_uji elongation_uji];
% prepare class label for first run of svm
class=zeros(11,1);
class(1:4,1)=1;
class(5:7,1)=2;
class(8:11,1)=3;

% perform run of Naive Bayes Classifer
BayesModel = fitcnb(trainset,class);

% BayesModel = NaiveBayes.fit(trainset,class);

% save BayesModelGolok.mat BayesModel

class_uji=zeros(23,1);
class_uji(1:9,1)=1;
class_uji(10:16,1)=2;
class_uji(17:23,1)=3;

% load BayesModelGolok
% Testing
isBayes = predict(BayesModel,testset);
% disp(['   Bayes ', 'Valid '])
% disp([isBayes class_uji])
% salah_Bayes = sum(isBayes~=class_uji)
% benar_Bayes = sum(isBayes==class_uji)
% akurasi_Bayes = benar_Bayes/numel(class_uji)
% disp(['accuracy Bayes = ',num2str(akurasi_Bayes*100,'%.2f'),'%'])
C=confusionmat(class_uji,isBayes)
Akurasi = 100*(sum(diag(C))./sum(C(:)));  
disp(['accuracy Bayes = ',num2str(Akurasi,'%.2f'),'%'])