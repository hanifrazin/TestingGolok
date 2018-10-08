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
areas = zeros(total_images,1);
perimeter = zeros(total_images,1);
perimeters = zeros(total_images,1);
perimeters2 = zeros(total_images,1);
perimeters3 = zeros(total_images,1);
diameter = zeros(total_images,1);
ro = zeros(total_images,1);
co = zeros(total_images,1);
level = zeros(total_images,1);

SE = [1 1 1;1 1 1;1 1 1];
SE2 = [1 1 1;1 1 1;1 1 1];

for n = 1:total_images
    full_name = fullfile(image_folder, filenames(n).name);
    Img = imread(full_name);

    Gray = rgb2gray(Img);
    Crop = imcrop(Gray,[104.5 0.5 190 70]);
    Resize = imresize(Crop,[50 150]);
    
%     Biner = Resize < 200;
%     Biner = not(Resize > 200);
    level(n) = graythresh(Resize);
    Biner = not(imbinarize(Resize,0.8));
    
    Open2 = imopen(Biner,SE);
    Close2 = imclose(Open2,SE);
    Open = bwmorph(Biner,'open');
    Close = bwmorph(Open,'close');
    Fill = imfill(Close2,'holes');
        
%         if(n==28)
%            figure,imshow(Fill);title(filenames(n).name);
%         end
    
    conv = bwconvhull(Close);
    Label = bwlabel(Close);
    cc = bwboundaries(Fill);
    B = cc{:,1};
    cc2 = bwconncomp(Fill);
    stats = regionprops(Fill,'all');
    conv_stats = regionprops(conv,'Perimeter');
    area(n) = stats.Area;
    areas(n) = sum(Fill(:));
    perimeter(n) = stats.Perimeter;
    perimeters(n) = computePerimeterFromBoundary(B);
    B1 = sqrt(diff(B(:,1)).^2 + diff(B(:,2)).^2);
    perimeters2(n) = sum(B1);
    perimeters3(n) = computePerimeterFromBoundaryOld(B);
    co(n) = (perimeters(n).^2)/areas(n);
    ro(n) = (4*pi*areas(n))/(perimeters(n).^2);
end

area_uji = zeros(total_images_uji,1);
areas_uji = zeros(total_images_uji,1);
perimeter_uji = zeros(total_images_uji,1);
perimeters_uji = zeros(total_images_uji,1);
ro_uji = zeros(total_images_uji,1);
co_uji = zeros(total_images_uji,1);
level_uji = zeros(total_images_uji,1);

for n = 1:total_images_uji
    full_name_uji = fullfile(image_folder_uji, filenames_uji(n).name);
    Img_uji = imread(full_name_uji);
    
    Gray_uji = rgb2gray(Img_uji);
    Crop_uji = imcrop(Gray_uji,[104.5 0.5 190 70]);
    Resize_uji = imresize(Crop_uji,[50 150]); 
    
%     Biner_uji = Resize_uji < 200;
%     Biner_uji = not(Resize_uji > 200);
    level_uji(n) = graythresh(Resize_uji);
    Biner_uji = not(imbinarize(Resize_uji,0.8));
    bin = imbinarize(Resize_uji);
    Open_uji2 = imopen(Biner_uji,SE2);
    Close_uji2 = imclose(Open_uji2,SE2);
    Open_uji = bwmorph(Biner_uji,'open');
    Close_uji = bwmorph(Open_uji,'close');
    Fill_uji = imfill(Close_uji2,'holes');
%         if(n==16)    
%         figure,imshow(Fill_uji);title(filenames_uji(n).name);
%         end
%         path_uji = ['C:\Users\HANIF\Documents\MATLAB\Testing Golok\Biner\Invers ',filenames_uji(n).name]
%         imwrite(Biner_uji,path_uji,'jpg')
%    
%     path_uji = ['C:\Users\HANIF\Documents\MATLAB\Naive Bayes - Golok\Biner\Morph ',filenames_uji(n).name]
%     imwrite(Open_uji,path_uji,'jpg')
    conv_uji = bwconvhull(Close_uji);
    stats_uji = regionprops(Fill_uji,'all');
    area_uji(n) = stats_uji.Area;
    areas_uji(n) = sum(Fill_uji(:));
    cc_uji = bwboundaries(Fill_uji);
    B_uji = cc_uji{:,1};
    perimeter_uji(n) = stats_uji.Perimeter;
    [perimeters_uji(n),delta,corner,even] = computePerimeterFromBoundarys(B_uji);
    co_uji(n) = (perimeters_uji(n).^2)/areas_uji(n);
    ro_uji(n) = (4*pi*areas_uji(n))/(perimeters_uji(n).^2);
end

latih = [areas perimeters ro co];
uji =  [areas_uji perimeters_uji ro_uji co_uji];

% load BayesModelGolok
% Testing
BayesModel = fitcnb(latih,class);

% save BayesGolok.mat BayesModel

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
hasil = '';

[j k] = size(posterior2);
Poster_Bayes_Uji = zeros(j,1);
for i=1:j
    Poster_Bayes_Uji(i) = max(posterior2(i,:));
end

Result_Bayes = cell(total_images,1);
for i=1:numel(isBayes2)
    if isequal(isBayes2(i),1)
        hasil = 'Gablogan';
    elseif isequal(isBayes2(i),2)
        hasil = 'Sembelih';
    elseif isequal(isBayes2(i),3)
        hasil = 'Sorenan';
    elseif isequal(isBayes2(i),4)
        hasil = 'Ujung Turun';
    elseif isequal(isBayes2(i),5)
        hasil = 'Petok';
    elseif isequal(isBayes2(i),6)
        hasil = 'Bukan Golok Betawi';
    end
    Result_Bayes{i} = hasil;
end

X=[uji Poster_Bayes_Uji];
Y=[uji posterior2];

T_Latih=transpose(latih);
T_Uji = transpose(uji);
T_Poster=transpose(posterior2);

function [keliling,delta,isCorner,isEven] = computePerimeterFromBoundarys(B)
    delta = diff(B).^2;
    if(size(delta,1) > 1)
        isCorner  = any(diff([delta;delta(1,:)],1),2); % Count corners.
        isEven    = any(~delta,2);
        keliling = sum(isEven,1)*0.980 + sum(~isEven,1)*1.406 - sum(isCorner,1)*0.091;
    else
        keliling = 0; % if the number of pixels is 1 or less.
    end
end
function perimeter = computePerimeterFromBoundaryOld(B)

    delta = diff(B).^2;
    perimeter = sum(sqrt(sum(delta,2)));
end