clc;
clear;

T = 127;
f = imread('E:\2016spring\ECE637\lab8\house.tif');
f = double(f);
[m,n] = size(f);
b = zeros(m,n);
b((f>127)) = 255;
RMSE = 0;
for i = 1:m
    for j = 1:n
        RMSE = RMSE+ (((f(i,j)-b(i,j))^2)/(m*n));
    end
end
RMSE = sqrt(RMSE);

fide = fidelity(f,b);
imwrite(uint8(f),'original.tif')
imwrite(uint8(b),'binary.tif')


