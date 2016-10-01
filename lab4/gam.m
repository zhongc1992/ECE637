
function [] = gam(gray_level)

pattern=[255,255,0,0;255,255,0,0;0,0,255,255;0,0,255,255];%create the checkboard pattern
single_line=zeros(16,256); %create a single dot line

for j=1:4:256
    for i=1:4:16
        single_line(i:i+3,j:j+3)=pattern;
    end
end
% single_line=double(single_line/255);
% colormap(gray(256))
% imshow(single_line)

gray_line=ones(16,256)*gray_level;
img=zeros(256,256);

for i=1:32:240
    img(i:i+15,:)=single_line;
end

for i=17:32:256
    img(i:i+15,:)=gray_line;
end

image(img+1);
axis('image');
graymap = [0:255; 0:255; 0:255]'/255;
colormap(graymap);
title('the test image');













