clc;
clear;

%Question 1
% race = imread('race.tif');
%  kids = imread('kids.tif');
%  gam15 = imread('gamma15.tif');
%  linear = imread('linear.tif');
 
% figure(1);
% hist(race(:),[0:255]);
% title('Histogram of race.tif Image');
% xlabel('pixel intensity');
% ylabel('number of pixels');
% figure(2);
% hist(kids(:),[0:255]);
% title('Histogram of kids.tif Image');
% xlabel('pixel intensity');
% ylabel('number of pixels');

%Question 2
% y_kid = equalize(kids);
% hist(y_kid(:),[0:255]);
% title('Histogram of equalized kids.tif Image');
% xlabel('pixel intensity');
% ylabel('number of pixels');
% image(y_kid+1);
% axis('image');
% graymap = [0:255; 0:255; 0:255]'/255;
% colormap(graymap);

%Question 3
% p3_kids = stretch(kids,70,180);
% hist(p3_kids(:),[0:255]);
% title('Histogram of stretched kids.tif Image');
% xlabel('pixel intensity');
% ylabel('number of pixels');

%Question 4.2
%gam(200);

%Qestion  4.3
gam=2.85
[img] = imread('linear.tif');
colormap(gray(256));
subplot(1,2,1)
imshow(img)
title('linear image')

X=double(img);
X=round(255*(X/255).^(1/gam));
colormap(gray(256));
subplot(1,2,2)
imshow(uint8(X))
title('output image(gamma = 2.85)')



% [img] = imread('gamma15.tif');
% colormap(gray(256));
% subplot(1,2,1)
% imshow(img)
% title('gamma15 image')
% 
% Y=double(img);
% Y=255*(Y/255).^1.5;
% Y=round(255*(Y/255).^(1/gam));
% colormap(gray(256));
% subplot(1,2,2)
% imshow(uint8(Y))
% title('image (gamma = 2.85)')
