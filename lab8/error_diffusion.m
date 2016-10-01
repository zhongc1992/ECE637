clc;
clear;

T = 127;
H = [1/16,5/16,3/16;7/16,0,0];
f = imread('E:\2016spring\ECE637\lab8\house.tif');
f = double(f);
[m,n] = size(f);

fl = 255*(f/255).^2.2;
error = zeros(m+1,n+2);
b = zeros(m,n);

for i = 1:m
    for j =1:n
        fl(i,j) = fl(i,j) + sum(sum(error(i:i+1,j:j+2).*H));
        if(fl(i,j) > T)
            b(i,j) = 255;
        else
            b(i,j) = 0;
        end
        error(i+1,j+1) = fl(i,j) - b(i,j);
    end
end

RMSE = 0;
for i = 1:m
    for j = 1:n
        RMSE = RMSE+ (((fl(i,j)-b(i,j))^2)/(m*n));
    end
end
RMSE = sqrt(RMSE);

fide = fidelity(fl,b);

image(b)
colormap(gray(256));

truesize
imwrite(uint8(b),'error_diffusion.tif')