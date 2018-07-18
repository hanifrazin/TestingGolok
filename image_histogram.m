% function histgram=image_histogram(x)
%% To find the Histogram of a particular image without using inbuilt function %%
close all;
clear all;
clc
% p=[1 1 1 2 2 3 3 4 4 4 5 6 6 9];
x=imread('cameraman.tif');% To read image

[M,N]=size(x);

t=1:256;
n=0:255;
count=0;

for z=1:256
    for i=1:M
        for j=1:N
            
            if x(i,j)==z-1
                count=count+1;
            end
        end
    end
            t(z)=count;
            count=0;
end
% disp(t')

histgram=stem(n,t); 
grid on;
ylabel('no. of pixels with intensity levels---->');
xlabel('intensity levels---->'); title('HISTOGRAM OF THE IMAGE')