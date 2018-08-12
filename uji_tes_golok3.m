% Hanif Razin Rahmatullah
% Email  : hanifrazin@gmail.com

clc;clear all;close all;

image_folder = 'data latih 3';
image_folder_uji = 'data uji 3';

class=zeros(18,1);
class(1:6,1)=1;
class(7:12,1)=2;
class(13:18,1)=3;

class_uji=zeros(12,1);
class_uji(1:4,1)=1;
class_uji(5:8,1)=2;
class_uji(9:12,1)=3;

filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

area = zeros(total_images,1);
perimeter = zeros(total_images,1);
diameter = zeros(total_images,1);
ro = zeros(total_images,1);
ro2 = zeros(total_images,1);
co = zeros(total_images,1);
co2 = zeros(total_images,1);
solidity = zeros(total_images,1);
eccentricity = zeros(total_images,1);
slim = zeros(total_images,1);
rect = zeros(total_images,1);
narrow = zeros(total_images,1);
rpd = zeros(total_images,1);
prp = zeros(total_images,1);
minor_axis = zeros(total_images,1);
mayor_axis = zeros(total_images,1);
elongation = zeros(total_images,1);
convex_perim = zeros(total_images,1);
convexity = zeros(total_images,1);
level = zeros(total_images,1);

for n = 1:total_images
    full_name = fullfile(image_folder, filenames(n).name);
    Img = imread(full_name);

    Gray = rgb2gray(Img);
    Contrast = imadjust(Gray,stretchlim(Gray),[]);
    MedImg = medfilt2(Contrast);
    Crop = imcrop(MedImg,[105.5 9.5 193 106]);
    Resize = imresize(Crop,[75 150]);
%     Biner = Resize < 200;
%     Biner = not(Resize > 200);
    level(n) = graythresh(Resize);
    Biner = not(imbinarize(Resize,0.8));
    SE = ones(4);
    Close2 = imclose(Biner,SE);
    Open2 = imopen(Close2,SE);
    Open = bwmorph(Biner,'open');
    Close = bwmorph(Open,'close');
%     figure,imshow(Open);title(filenames(n).name);
    conv = bwconvhull(Close);
    Label = bwlabel(Close);
    stats = regionprops(Close,'all');
    conv_stats = regionprops(conv,'Perimeter');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    convex_perim(n) = conv_stats.Perimeter;
    convexity(n) = convex_perim(n)/perimeter(n);
    co(n) = (perimeter(n)^2)/area(n);
    co2(n) = (perimeter(n)^2)/(4*pi*area(n));
    ro(n) = (4*pi*area(n))/(perimeter(n)^2);
    ro2(n) = (4*pi*area(n))/(convex_perim(n)^2);
    eccentricity(n) = stats.Eccentricity;
    solidity(n) = stats.Solidity;
    diameter(n) = stats.EquivDiameter;
    
    minor_axis(n) = stats.MinorAxisLength;
    mayor_axis(n) = stats.MajorAxisLength;
    prp(n) = perimeter(n)/(mayor_axis(n)+minor_axis(n));
    narrow(n) = diameter(n)/mayor_axis(n);
    slim(n) = mayor_axis(n)/minor_axis(n);
    rpd(n) = perimeter(n)/mayor_axis(n);
    
    rect(n) = area(n)/(minor_axis(n)*mayor_axis(n));
    elongation(n) = 1 - (minor_axis(n)/mayor_axis(n));
    
end


filenames_uji = dir(fullfile(image_folder_uji, '*.jpg'));
total_images_uji = numel(filenames_uji);

area_uji = zeros(total_images_uji,1);
perimeter_uji = zeros(total_images_uji,1);
diameter_uji = zeros(total_images_uji,1);
ro_uji = zeros(total_images_uji,1);
ro2_uji = zeros(total_images_uji,1);
co_uji = zeros(total_images_uji,1);
co2_uji = zeros(total_images_uji,1);
solidity_uji = zeros(total_images_uji,1);
eccentricity_uji = zeros(total_images_uji,1);
slim_uji = zeros(total_images_uji,1);
rect_uji = zeros(total_images_uji,1);
narrow_uji = zeros(total_images_uji,1);
rpd_uji = zeros(total_images_uji,1);
prp_uji = zeros(total_images_uji,1);
minor_axis_uji = zeros(total_images_uji,1);
mayor_axis_uji = zeros(total_images_uji,1);
elongation_uji = zeros(total_images_uji,1);
convex_perim_uji = zeros(total_images_uji,1);
convexity_uji = zeros(total_images_uji,1);
level_uji = zeros(total_images_uji,1);

for n = 1:total_images_uji
    full_name_uji = fullfile(image_folder_uji, filenames_uji(n).name);
    Img_uji = imread(full_name_uji);
    
    Gray_uji = rgb2gray(Img_uji);
    Contrast_uji = imadjust(Gray_uji,stretchlim(Gray_uji),[]);
    MedImg_uji = medfilt2(Contrast_uji);
    Crop_uji = imcrop(MedImg_uji,[105.5 9.5 193 106]);
    Resize_uji = imresize(Crop_uji,[75 150]); 
%     Biner_uji = Resize_uji < 200;
%     Biner_uji = not(Resize_uji > 200);
    level_uji(n) = graythresh(Resize_uji);
    Biner_uji = not(imbinarize(Resize_uji,0.8));
    
    SE_uji = ones(5);
    Close_uji2 = imclose(Biner_uji,SE_uji);
    Open_uji2 = imopen(Close_uji2,SE_uji);
    Open_uji = bwmorph(Biner_uji,'open');
    Close_uji = bwmorph(Open_uji,'close');
    
%     figure,imshow(Open_uji);title(filenames_uji(n).name);
%     path_uji = ['C:\Users\HANIF\Documents\MATLAB\Naive Bayes - Golok\Biner\Morph ',filenames_uji(n).name]
%     imwrite(Open_uji,path_uji,'jpg')
    conv_uji = bwconvhull(Close_uji);
    stats_uji = regionprops(Close_uji,'all');
    conv_stats_uji = regionprops(conv_uji,'Perimeter');
    area_uji(n) = stats_uji.Area;
    perimeter_uji(n) = stats_uji.Perimeter;
    convex_perim_uji(n) = conv_stats_uji.Perimeter;
    minor_axis_uji(n) = stats_uji.MinorAxisLength;
    mayor_axis_uji(n) = stats_uji.MajorAxisLength;
    convexity_uji(n) = convex_perim_uji(n)/perimeter_uji(n);
    co_uji(n) = (perimeter_uji(n)^2)/area_uji(n);
    co2_uji(n) = (perimeter_uji(n)^2)/(4*pi*area_uji(n));
    ro_uji(n) = (4*pi*area_uji(n))/(perimeter_uji(n)^2);
    ro2_uji(n) = (4*pi*area_uji(n))/(convex_perim_uji(n)^2);
    eccentricity_uji(n) = stats_uji.Eccentricity;
    solidity_uji(n) = stats_uji.Solidity;
    diameter_uji(n) = stats_uji.EquivDiameter;
    
    rpd_uji(n) = perimeter_uji(n)/mayor_axis_uji(n);
    prp_uji(n) = perimeter_uji(n)/(mayor_axis_uji(n)+minor_axis_uji(n));
    narrow_uji(n) = diameter_uji(n)/mayor_axis_uji(n);
    
    slim_uji(n) = mayor_axis_uji(n)/minor_axis_uji(n);

    rect_uji(n) = area_uji(n)/(mayor_axis_uji(n)*minor_axis_uji(n));
    elongation_uji(n) = 1 - (minor_axis_uji(n)/mayor_axis_uji(n));
end

% trainset = [area rect co solidity rpd]; 100%
% testset  = [area_uji rect_uji co_uji solidity_uji rpd_uji]; 83%

trainset = [area rect co2 solidity rpd];
testset  = [area_uji rect_uji co2_uji solidity_uji rpd_uji];


% load BayesModelGolok
% Testing
BayesModel = fitcnb(trainset,class);
isBayes = predict(BayesModel,trainset);
isBayes2 = predict(BayesModel,testset);
% disp(['   Bayes ', 'Valid '])
% disp([isBayes class_uji])
% salah_Bayes = sum(isBayes~=class_uji)
% benar_Bayes = sum(isBayes==class_uji)
% akurasi_Bayes = benar_Bayes/numel(class_uji)
% disp(['accuracy Bayes = ',num2str(akurasi_Bayes*100,'%.2f'),'%'])
C_train=confusionmat(class,isBayes)
Akurasi_train = 100*(sum(diag(C_train))./sum(C_train(:)));  
disp(['accuracy Data Latih Bayes = ',num2str(Akurasi_train,'%.2f'),'%'])

C_test=confusionmat(class_uji,isBayes2)
Akurasi_test = 100*(sum(diag(C_test))./sum(C_test(:)));  
disp(['accuracy Data uji Bayes = ',num2str(Akurasi_test,'%.2f'),'%'])