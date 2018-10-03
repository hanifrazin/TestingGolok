% Hanif Razin Rahmatullah
% Email  : hanifrazin@gmail.com

clc;clear all;close all;

image_folder = 'golok_latih';
image_folder_uji = 'golok_uji';

filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

filenames_uji = dir(fullfile(image_folder_uji, '*.jpg'));
total_images_uji = numel(filenames_uji);

class=zeros(total_images,1);
class(1:5,1)=1;
class(6:10,1)=2;
class(11:15,1)=3;
class(16:20,1)=4;
class(21:25,1)=5;
class(26:total_images,1)=6;

class_uji = class;

% if isequal(image_folder_uji,'train golok_2')
%     class_uji = class;
% end

area = zeros(total_images,1);
perimeter = zeros(total_images,1);
diameter = zeros(total_images,1);
ro = zeros(total_images,1);
ro2 = zeros(total_images,1);
ro3 = zeros(total_images,1);
co = zeros(total_images,1);
co2 = zeros(total_images,1);
solidity = zeros(total_images,1);
eccentricity = zeros(total_images,1);
eccentricity2 = zeros(total_images,1);
slim = zeros(total_images,1);
rect = zeros(total_images,1);
rect2 = zeros(total_images,1);
narrow = zeros(total_images,1);
rpd = zeros(total_images,1);
prp = zeros(total_images,1);
minor_axis = zeros(total_images,1);
mayor_axis = zeros(total_images,1);
elongation = zeros(total_images,1);
convex_perim = zeros(total_images,1);
convexity = zeros(total_images,1);
conv_area = zeros(total_images,1);
conv_hull = zeros(total_images,1);
level = zeros(total_images,1);

SE = ones(3);
SE2 = [1 1 1;1 1 1;1 1 1]

for n = 1:total_images
    full_name = fullfile(image_folder, filenames(n).name);
    Img = imread(full_name);

    Gray = rgb2gray(Img);
%     Contrast = imadjust(Gray,stretchlim(Gray),[]);
    
%     MedImg = ordfilt2(Gray,5,ones(3,3));
    Crop = imcrop(Gray,[104.5 0.5 190 70]);
    Resize = imresize(Crop,[50 150]);
    
%     Biner = Resize < 200;
%     Biner = not(Resize > 200);
    level(n) = graythresh(Resize);
    Biner = not(imbinarize(Resize,0.8));
    
    Open2 = imopen(Biner,SE2);
    Close2 = imclose(Open2,SE2);
    Open = bwmorph(Biner,'open');
    Close = bwmorph(Open,'close');
    Fill = imfill(Close2,'holes');
        
        if(n==28)
           figure,imshow(Fill);title(filenames(n).name);
        end
    
    conv = bwconvhull(Close);
    Label = bwlabel(Close);
    stats = regionprops(Fill,'all');
    conv_stats = regionprops(conv,'Perimeter');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    minor_axis(n) = stats.MinorAxisLength;
    mayor_axis(n) = stats.MajorAxisLength;
    convex_perim(n) = conv_stats.Perimeter;
    convexity(n) = convex_perim(n)/perimeter(n);
    co(n) = (perimeter(n).^2)/area(n);
    co2(n) = (perimeter(n).^2)/(4*pi*area(n));
    conv_area(n) = stats.ConvexArea;
    conv_hull(n) = conv_area(n)-area(n);
    ro(n) = (4*pi*area(n))/(perimeter(n).^2);
    ro2(n) = (4*pi*area(n))/(convex_perim(n).^2);
    ro3(n) = (4*area(n))/(pi*(mayor_axis(n).^2));
    eccentricity(n) = stats.Eccentricity;
    eccentricity2(n) = sqrt(((mayor_axis(n).^2)-(minor_axis(n).^2)))/mayor_axis(n);
    solidity(n) = stats.Solidity;
    diameter(n) = stats.EquivDiameter;
    
    prp(n) = perimeter(n)/(mayor_axis(n)+minor_axis(n));
    narrow(n) = diameter(n)/mayor_axis(n);
    slim(n) = mayor_axis(n)/minor_axis(n);
    rpd(n) = perimeter(n)/mayor_axis(n);
    
    rect(n) = area(n)/(minor_axis(n)*mayor_axis(n));
    rect2(n) = (minor_axis(n)*mayor_axis(n))/area(n);
    elongation(n) = 1 - (minor_axis(n)/mayor_axis(n));
    
end

area_uji = zeros(total_images_uji,1);
perimeter_uji = zeros(total_images_uji,1);
diameter_uji = zeros(total_images_uji,1);
ro_uji = zeros(total_images_uji,1);
ro2_uji = zeros(total_images_uji,1);
ro3_uji = zeros(total_images_uji,1);
co_uji = zeros(total_images_uji,1);
co2_uji = zeros(total_images_uji,1);
solidity_uji = zeros(total_images_uji,1);
eccentricity_uji = zeros(total_images_uji,1);
eccentricity2_uji = zeros(total_images_uji,1);
slim_uji = zeros(total_images_uji,1);
rect_uji = zeros(total_images_uji,1);
rect2_uji = zeros(total_images_uji,1);
narrow_uji = zeros(total_images_uji,1);
rpd_uji = zeros(total_images_uji,1);
prp_uji = zeros(total_images_uji,1);
minor_axis_uji = zeros(total_images_uji,1);
mayor_axis_uji = zeros(total_images_uji,1);
elongation_uji = zeros(total_images_uji,1);
convex_perim_uji = zeros(total_images_uji,1);
convexity_uji = zeros(total_images_uji,1);
conv_area_uji = zeros(total_images_uji,1);
conv_hull_uji = zeros(total_images_uji,1);
level_uji = zeros(total_images_uji,1);

for n = 1:total_images_uji
    full_name_uji = fullfile(image_folder_uji, filenames_uji(n).name);
    Img_uji = imread(full_name_uji);
    
    Gray_uji = rgb2gray(Img_uji);
%     Contrast_uji = imadjust(Gray_uji,stretchlim(Gray_uji),[]);
    
%     MedImg_uji = ordfilt2(Gray_uji,25,ones(7,7));
    Crop_uji = imcrop(Gray_uji,[104.5 0.5 190 70]);
    Resize_uji = imresize(Crop_uji,[50 150]); 
    
%     Biner_uji = Resize_uji < 200;
%     Biner_uji = not(Resize_uji > 200);
    level_uji(n) = graythresh(Resize_uji);
    Biner_uji = not(imbinarize(Resize_uji));
    bin = imbinarize(Resize_uji,0.8);
    Open_uji2 = imopen(Biner_uji,SE2);
    Close_uji2 = imclose(Open_uji2,SE2);
    Open_uji = bwmorph(Biner_uji,'open');
    Close_uji = bwmorph(Open_uji,'close');
    Fill_uji = imfill(Close_uji2,'holes');
%         if(n==16)    
%         figure,imshow(Fill_uji);title(filenames_uji(n).name);
%         end
%         path_uji = ['C:\Users\HANIF\Documents\MATLAB\Testing Golok\Morfologi\Close ',filenames_uji(n).name]
%         imwrite(Close_uji2,path_uji,'jpg')
%    
%     path_uji = ['C:\Users\HANIF\Documents\MATLAB\Naive Bayes - Golok\Biner\Morph ',filenames_uji(n).name]
%     imwrite(Open_uji,path_uji,'jpg')
    conv_uji = bwconvhull(Close_uji);
    stats_uji = regionprops(Fill_uji,'all');
    conv_stats_uji = regionprops(conv_uji,'Perimeter');
    area_uji(n) = stats_uji.Area;
    perimeter_uji(n) = stats_uji.Perimeter;
    convex_perim_uji(n) = conv_stats_uji.Perimeter;
    minor_axis_uji(n) = stats_uji.MinorAxisLength;
    mayor_axis_uji(n) = stats_uji.MajorAxisLength;
    convexity_uji(n) = convex_perim_uji(n)/perimeter_uji(n);
    co_uji(n) = (perimeter_uji(n).^2)/area_uji(n);
    co2_uji(n) = (perimeter_uji(n).^2)/(4*pi*area_uji(n));
    conv_area_uji(n) = stats_uji.ConvexArea;
    conv_hull_uji(n) = conv_area_uji(n)-area_uji(n);
    ro_uji(n) = (4*pi*area_uji(n))/(perimeter_uji(n).^2);
    ro2_uji(n) = (4*pi*area_uji(n))/(convex_perim_uji(n).^2);
    ro3_uji(n) = (4*area_uji(n))/(pi*(mayor_axis_uji(n).^2));
    eccentricity_uji(n) = stats_uji.Eccentricity;
    eccentricity2_uji(n) = sqrt(((mayor_axis_uji(n).^2)-(minor_axis_uji(n).^2)))/mayor_axis_uji(n);
    solidity_uji(n) = stats_uji.Solidity;
    diameter_uji(n) = stats_uji.EquivDiameter;
    
    rpd_uji(n) = perimeter_uji(n)/mayor_axis_uji(n);
    prp_uji(n) = perimeter_uji(n)/(mayor_axis_uji(n)+minor_axis_uji(n));
    narrow_uji(n) = diameter_uji(n)/mayor_axis_uji(n);
    
    slim_uji(n) = mayor_axis_uji(n)/minor_axis_uji(n);

    rect_uji(n) = area_uji(n)/(mayor_axis_uji(n)*minor_axis_uji(n));
    rect2_uji(n) = (mayor_axis_uji(n)*minor_axis_uji(n))/area_uji(n);
    elongation_uji(n) = 1 - (minor_axis_uji(n)/mayor_axis_uji(n));
end

% KLASIFIKASI MUTU MUTIARA BERDASARKAN BENTUK DAN UKURAN MENGGUNAKAN K-NEAREST NEIGHBOR
% Penulis :	Ardiyallah Akbar
% Tahun	: 2017
% Akurasi Latih : 93.33%
% Akurasi Uji : 72%
% Akurasi Non : 80%

latih = [area perimeter ro co];
uji =  [area_uji perimeter_uji ro_uji co_uji];

% load BayesModelGolok
% Testing
BayesModel = fitcnb(latih,class);

save BayesGolok.mat BayesModel

tic;
[isBayes,posterior] = predict(BayesModel,latih);
[isBayes2,posterior2] = predict(BayesModel,uji);

% salah_Bayes = sum(isBayes~=class_uji)
% benar_Bayes = sum(isBayes==class_uji)
% akurasi_Bayes = benar_Bayes/numel(class_uji)
% disp(['accuracy Bayes = ',num2str(akurasi_Bayes*100,'%.2f'),'%'])
C_train=confusionmat(class,isBayes)
benar_train = sum(diag(C_train))
salah_train = total_images-sum(diag(C_train))
Akurasi_train = 100*(sum(diag(C_train))./sum(C_train(:)));  
Table_train = table(isBayes,class)
disp(['accuracy Data Latih Bayes = ',num2str(Akurasi_train,'%.2f'),'%'])

C_test=confusionmat(class_uji(1:25),isBayes2(1:25))
benar_test = sum(diag(C_test))
salah_test = sum(isBayes2(1:25)~=class_uji(1:25))
Akurasi_test = 100*(sum(diag(C_test))./sum(C_test(:)));  
Table_test = table(isBayes2(1:25),class_uji(1:25))
disp(['accuracy Data uji Bayes = ',num2str(Akurasi_test,'%.2f'),'%'])

C_test_non=confusionmat(class_uji(26:30),isBayes2(26:30))
benar_test_non = sum(diag(C_test_non))
salah_test_non = numel(class_uji(26:30))-sum(diag(C_test_non))
Akurasi_test_non = 100*(sum(diag(C_test_non))./sum(C_test_non(:)));  
Table_test_non = table(isBayes2(26:30),class_uji(26:30))
disp(['accuracy Data uji Bayes Non Betawi = ',num2str(Akurasi_test_non,'%.2f'),'%'])
toc;

T_Latih=transpose(latih);
T_Uji = transpose(uji);
T_Poster=transpose(posterior2);