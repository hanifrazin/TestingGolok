% Hanif Razin Rahmatullah
% Email  : hanifrazin@gmail.com

clc;clear;close all;

image_folder = 'data latih';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

area = zeros(total_images,1);
perimeter = zeros(total_images,1);
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
% %     Median = medfilt2(Contrast,[13 13]);
    Median = ordfilt2(Contrast,5,ones(3,3));
    Crop = imcrop(Median,[105.5 9.5 193 106]);
    Resize = imresize(Crop,[75 150]);
%     Biner = Resize < 200;
%     Biner = not(Resize > 200);
    Biner = imcomplement(imbinarize(Resize,0.8));
%     Biner = imbinarize(Resize,0.8);
    
    SE1 = [1 1 1;1 1 1;1 1 1]; %Close
    SE2 = [1 0 1;0 1 0;1 0 1]; %Open
    SE = strel('line', 3, 45);
    
%     SE akurasi 78,26%
%     seCros        = [0 0 1;0 1 0;1 0 0];
%     seSlash       = [1 0 1;0 1 0;1 0 1];
%     SE = strel('line', 3, 45);

%     SE akurasi 73,91%
%     seFull        = [1 1 1;1 1 1;1 1 1];
%     seVertikal    = [0 1 0;0 1 0;0 1 0];
%     SE = strel('square',3);
%     SE = strel('cube',3)
%     SE = strel('sphere',3);
%     SE = strel('rectangle',[3 3]);
    
    Open2 = imopen(Biner,SE);
    Close2 = imclose(Open2,SE); 
    
    Open = bwmorph(Biner,'open');
    Close = bwmorph(Open,'close');

    stats = regionprops(Close,'all');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    co(n) = (perimeter(n)^2)/area(n);
    ro(n) = (4*pi*area(n))/(perimeter(n)^2);
    minor_axis(n) = stats.MinorAxisLength;
    mayor_axis(n) = stats.MajorAxisLength;
    slim(n) = mayor_axis(n)/minor_axis(n);

    rect(n) = area(n)/(minor_axis(n)*mayor_axis(n));
    elongation(n) = 1 - (minor_axis(n)/mayor_axis(n));
    
end

image_folder_uji = 'data uji';
filenames_uji = dir(fullfile(image_folder_uji, '*.jpg'));
total_images_uji = numel(filenames_uji);

area_uji = zeros(total_images_uji,1);
perimeter_uji = zeros(total_images_uji,1);
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
%     figure,imhist(Gray_uji);ylim([0,200]);xlim([0,255]);
    Contrast_uji = imadjust(Gray_uji,stretchlim(Gray_uji),[]);
%     figure,imhist(Contrast_uji);ylim([0,150]);xlim([0,255]);
%     Median_uji = medfilt2(Contrast_uji,[3 3]);
    Median_uji = ordfilt2(Contrast_uji,5,ones(3,3));
    Crop_uji = imcrop(Median_uji,[105.5 9.5 193 106]);
    Resize_uji = imresize(Crop_uji,[75 150]); 

    Biner_uji = imcomplement(imbinarize(Resize_uji,0.8));
%     Biner_uji = imbinarize(Resize_uji,0.8);
    
    SE1_uji = [1 1 1;1 1 1;1 1 1];
    SE2_uji = [1 0 1;0 1 0;1 0 1];
    SE_uji = strel('line', 3, 45);
    
%     SE_uji akurasi 78,26%
%     seCros        = [0 0 1;0 1 0;1 0 0];
%     seSlash       = [1 0 1;0 1 0;1 0 1];
%     SE_uji = strel('line', 3, 45);

%     SE_uji akurasi 73,91%
%     seFull        = [1 1 1;1 1 1;1 1 1];
%     seVertikal    = [0 1 0;0 1 0;0 1 0];
%     SE_uji = strel('square',3);
%     SE_uji = strel('cube',3);
%     SE_uji = strel('sphere',3);
%     SE_uji = strel('rectangle',[3 3]);  
    
    Open_uji2 = imopen(Biner_uji,SE_uji);
    Close_uji2 = imclose(Open_uji2,SE_uji);
    
    Open_uji = bwmorph(Biner_uji,'open');
    Close_uji = bwmorph(Open_uji,'close');
   
%     figure,imshow(Close_uji2);title(filenames_uji(n).name);
%     path_uji = ['C:\Users\HANIF\Documents\MATLAB\Naive Bayes - Golok\Biner\Morph ',filenames_uji(n).name]
%     imwrite(Open_uji,path_uji,'jpg')

    stats_uji = regionprops(Close_uji,'all');
    area_uji(n) = stats_uji.Area;
    perimeter_uji(n) = stats_uji.Perimeter;
    co_uji(n) = (perimeter_uji(n)^2)/area_uji(n);
    ro_uji(n) = (4*pi*area_uji(n))/(perimeter_uji(n)^2);    
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

class_asli={'Gablogan';'Gablogan';'Gablogan';'Gablogan';'Sembelih';'Sembelih';'Sembelih';'Sorenan';'Sorenan';'Sorenan';'Sorenan'}

% perform run of Naive Bayes Classifer
BayesModel = fitcnb(trainset,class);

% BayesModel = NaiveBayes.fit(trainset,class);

save BayesGolok.mat BayesModel

class_uji=zeros(23,1);
class_uji(1:9,1)=1;
class_uji(10:16,1)=2;
class_uji(17:23,1)=3;

hasil = 'Tes';
target = 0;
class_Bayes = cell(23,1);
isBayes2 = zeros(23,1);
% load BayesModelGolok
% Testing
[isBayes,posterior] = predict(BayesModel,testset);

for i=1:numel(isBayes)
    if isequal(posterior(i,1),max(posterior(i,:)))
        hasil = 'Gablogan';
        target = 1;
    elseif isequal(posterior(i,2),max(posterior(i,:)))
        hasil = 'Sembelih';
        target = 2;
    elseif isequal(posterior(i,3),max(posterior(i,:)))
        hasil = 'Sorenan';
        target = 3;
    end
    class_Bayes{i} = hasil;
    isBayes2(i) = target;
end

% for i=1:numel(isBayes)
%     if isequal(isBayes(i),1)
%         hasil = 'Gablogan';
%     elseif isequal(isBayes(i),2)
%         hasil = 'Sembelih';
%     elseif isequal(isBayes(i),3)
%         hasil = 'Sorenan';
%     end
%     class_Bayes{i} = hasil;
% end

disp(['   Bayes ', 'Valid '])
disp([isBayes isBayes2 class_uji])
% salah_Bayes = sum(isBayes~=class_uji)
% benar_Bayes = sum(isBayes==class_uji)
% akurasi_Bayes = benar_Bayes/numel(class_uji)
% disp(['accuracy Bayes = ',num2str(akurasi_Bayes*100,'%.2f'),'%'])
confBayes=confusionmat(class_uji,isBayes)
benar_Bayes = sum(diag(confBayes))
salah_Bayes = total_images_uji - benar_Bayes
Akurasi = 100*(sum(diag(confBayes))./sum(confBayes(:)));  
disp(['accuracy Bayes = ',num2str(Akurasi,'%.2f'),'%'])
disp('Nilai Posterior');posterior
Hasil = [testset posterior];