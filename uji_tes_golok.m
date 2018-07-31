% Hanif Razin Rahmatullah
% Email  : hanifrazin@gmail.com

clc;clear;close all;

image_folder = 'data latih';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

area = zeros(total_images,1);
perimeter = zeros(total_images,1);
diameter = zeros(total_images,1);
ro = zeros(total_images,1);
co = zeros(total_images,1);
solidity = zeros(total_images,1);
eccentricity = zeros(total_images,1);
slim = zeros(total_images,1);
rect = zeros(total_images,1);
narrow = zeros(total_images,1);
rpd = zeros(total_images,1);
prp = zeros(total_images,1);
length = zeros(total_images,1);
width = zeros(total_images,1);
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
    Close = bwmorph(Biner,'close');
    Open = bwmorph(Close,'open');
%     figure,imshow(Open);title(filenames(n).name);
    conv = bwconvhull(Open2);
    Label = bwlabel(Open);
    stats = regionprops(Open,'all');
    conv_stats = regionprops(conv,'Perimeter');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    convex_perim(n) = conv_stats.Perimeter;
    convexity(n) = convex_perim(n)/perimeter(n);
    co(n) = (perimeter(n)^2)/area(n);
    ro(n) = (4*pi*area(n))/(perimeter(n)^2);
    eccentricity(n) = stats.Eccentricity;
    solidity(n) = stats.Solidity;
    diameter(n) = stats.EquivDiameter;
    length(n) = stats.BoundingBox(3);
    width(n) = stats.BoundingBox(4);
    
    minor_axis(n) = stats.MinorAxisLength;
    mayor_axis(n) = stats.MajorAxisLength;
    prp(n) = perimeter(n)/(mayor_axis(n)+minor_axis(n));
    narrow(n) = diameter(n)/mayor_axis(n);
    slim(n) = mayor_axis(n)/minor_axis(n);
    rpd(n) = perimeter(n)/mayor_axis(n);
    
    rect(n) = (minor_axis(n)*mayor_axis(n))/area(n);
    elongation(n) = 1 - (minor_axis(n)/mayor_axis(n));
    
end

image_folder_uji = 'data uji';
filenames_uji = dir(fullfile(image_folder_uji, '*.jpg'));
total_images_uji = numel(filenames_uji);

area_uji = zeros(total_images_uji,1);
perimeter_uji = zeros(total_images_uji,1);
diameter_uji = zeros(total_images_uji,1);
ro_uji = zeros(total_images_uji,1);
co_uji = zeros(total_images_uji,1);
solidity_uji = zeros(total_images_uji,1);
eccentricity_uji = zeros(total_images_uji,1);
slim_uji = zeros(total_images_uji,1);
rect_uji = zeros(total_images_uji,1);
narrow_uji = zeros(total_images_uji,1);
rpd_uji = zeros(total_images_uji,1);
prp_uji = zeros(total_images_uji,1);
length_uji = zeros(total_images_uji,1);
width_uji = zeros(total_images_uji,1);
minor_axis_uji = zeros(total_images_uji,1);
mayor_axis_uji = zeros(total_images_uji,1);
elongation_uji = zeros(total_images_uji,1);
convex_perim_uji = zeros(total_images,1);
convexity_uji = zeros(total_images,1);
level_uji = zeros(total_images,1);

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
    Close_uji = bwmorph(Biner_uji,'close');
    Open_uji = bwmorph(Close_uji,'open');
    
%     figure,imshow(Open_uji);title(filenames_uji(n).name);
%     path_uji = ['C:\Users\HANIF\Documents\MATLAB\Naive Bayes - Golok\Biner\Morph ',filenames_uji(n).name]
%     imwrite(Open_uji,path_uji,'jpg')
    conv_uji = bwconvhull(Open_uji2);
    Label_uji = bwlabel(Open_uji);
    stats_uji = regionprops(Open_uji,'all');
    conv_stats_uji = regionprops(conv_uji,'Perimeter');
    area_uji(n) = stats_uji.Area;
    perimeter_uji(n) = stats_uji.Perimeter;
    convex_perim_uji(n) = conv_stats_uji.Perimeter;
    minor_axis_uji(n) = stats_uji.MinorAxisLength;
    mayor_axis_uji(n) = stats_uji.MajorAxisLength;
    convexity_uji(n) = convex_perim_uji(n)/perimeter_uji(n);
    co_uji(n) = (perimeter_uji(n)^2)/area_uji(n);
    ro_uji(n) = (4*pi*area_uji(n))/(perimeter_uji(n)^2);
    eccentricity_uji(n) = stats_uji.Eccentricity;
    solidity_uji(n) = stats_uji.Solidity;
    diameter_uji(n) = stats_uji.EquivDiameter;
    length_uji(n) = stats_uji.BoundingBox(3);
    width_uji(n) = stats_uji.BoundingBox(4);
    
    rpd_uji(n) = perimeter_uji(n)/mayor_axis_uji(n);
    prp_uji(n) = perimeter_uji(n)/(mayor_axis_uji(n)+minor_axis_uji(n));
    narrow_uji(n) = diameter_uji(n)/mayor_axis_uji(n);
    
    slim_uji(n) = mayor_axis_uji(n)/minor_axis_uji(n);

    rect_uji(n) = (mayor_axis_uji(n)*minor_axis_uji(n))/area_uji(n);
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

% BayesModel = NaiveBayes.fit(trainset,class);

% save BayesModelGolok.mat BayesModel

class_uji=zeros(23,1);
class_uji(1:9,1)=1;
class_uji(10:16,1)=2;
class_uji(17:23,1)=3;

% load BayesModelGolok
% Testing
% testset = trainset;
% class_uji = class;

BayesModel = fitcnb(trainset,class);
isBayes = predict(BayesModel,testset);
disp(['   Bayes ', 'Valid '])
disp([isBayes class_uji])
salah_Bayes = sum(isBayes~=class_uji)
benar_Bayes = sum(isBayes==class_uji)
akurasi_Bayes = benar_Bayes/numel(class_uji);
disp(['accuracy Bayes = ',num2str(akurasi_Bayes*100,'%.2f'),'%'])

SVMModel = fitcecoc(trainset,class);
isSVM = predict(SVMModel,testset);
disp(['   SVM ', 'Valid '])
disp([isSVM class_uji])
salah_SVM = sum(isSVM~=class_uji);
benar_SVM = sum(isSVM==class_uji);
akurasi_SVM = benar_SVM/numel(class_uji);
disp(['accuracy SVM = ',num2str(akurasi_SVM*100,'%.2f'),'%'])

DecTreeModel = fitctree(trainset,class,'MinParent',3);
view(DecTreeModel,'mode','graph')
isDecTree = predict(DecTreeModel,testset);
disp(['Dec Tree ', 'Valid '])
disp([isDecTree class_uji])
salah_DecTree = sum(isDecTree~=class_uji);
benar_DecTree = sum(isDecTree==class_uji);
akurasi_DecTree = benar_DecTree/numel(class_uji);
disp(['accuracy Decision Tree = ',num2str(akurasi_DecTree*100,'%.2f'),'%'])

k=8
KNNModel = fitcknn(trainset,class,'NumNeighbors',k);
isKNN = predict(KNNModel,testset);
disp(['    KNN ', ' Valid '])
disp([isKNN class_uji])
[IndexKnn,ValKnn_Index] = knnsearch(trainset,testset,'k',k,'distance','euclidean');
[m,n]=size(IndexKnn);
class_knnindex = cell(m,n);
class_detailKnn_Index = cell(m,n);
hasil = 'kelas';
hasil2 = 'detail kelas';
for i=1:m
    for j=1:n
        val = IndexKnn(i,j);
        if (val >= 1)  && (val <= 4)
            hasil = 'Gablogan';
            hasil2 = ['Gablogan-0' num2str(val)];
        elseif (val >= 5)  && (val <= 7)
            hasil = 'Sembelih';
            hasil2 = ['Sembelih-0' num2str(val)];
        elseif (val >= 8)  && (val <= 11)
            hasil = 'Sorenan';
            if (val == 10)  || (val == 11)
                hasil2 = ['Sorenan-' num2str(val)];
            else
                hasil2 = ['Sorenan-0' num2str(val)];
            end
        end
        class_knnindex{i,j} = hasil;
        class_detailKnn_Index{i,j} = hasil2;
    end
end

salah_KNN = sum(isKNN~=class_uji);
benar_KNN = sum(isKNN==class_uji);
akurasi_KNN = benar_KNN/numel(class_uji);
disp(['accuracy KNN = ',num2str(akurasi_KNN*100,'%.2f'),'%'])

% Backpropagation
load('TrainBackprop23.mat');
train = transpose(trainset);
test = transpose(testset);
target = transpose(class);
isBackProp = round(sim(TrainBackprop23,transpose(testset)));
disp([' Backprop ', 'Valid '])
disp([isBackProp' class_uji])

% PNN (Probabilistic Neural Network)
T = ind2vec(target); 
net = newpnn(train,T);
view(net);
Y = sim(net,test);
isPNN = vec2ind(Y);
disp(['    PNN ', ' Valid '])
disp([isPNN' class_uji])

salah_JST = sum(transpose(isPNN)~=class_uji);
benar_JST = sum(transpose(isPNN)==class_uji);
akurasi_JST = benar_JST/numel(class_uji);
disp(['accuracy PNN = ',num2str(akurasi_JST*100,'%.2f'),'%'])
