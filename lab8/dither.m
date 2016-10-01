clc;
clear;
N = 2;%N^2 is the total elements in an index matrix

f = imread('E:\2016spring\ECE637\lab8\house.tif');
f = double(f);
[m,n] = size(f);

fl = 255*(f/255).^2.2; %gamma corrected version of image

I2N = [1 2;3 0];
I4N = [4*I2N+1 4*I2N+2;4*I2N+3 4*I2N];
I8N = [4*I4N+1 4*I4N+2;4*I4N+3 4*I4N];
%I8N = [4*I4N+1 4*I4N+2;4*I4N+3 4*I4N];

T2N = 255*(double(I2N) + 0.5)./((N)^2);
T4N = 255*(double(I4N) + 0.5)./((2*N)^2);
T8N = 255*(double(I8N) + 0.5)./((4*N)^2);

b2N = zeros(m,n);
b4N = b2N;
b8N = b2N;

for i = 1:m
    for j = 1:n
        if (fl(i,j) > T2N(mod(i,N)+1,mod(j,N)+1))
            b2N(i,j) = 255;
        end
        if (fl(i,j) > T4N(mod(i,2*N)+1,mod(j,2*N)+1))
            b4N(i,j) = 255;
        end
        if (fl(i,j) >T8N(mod(i,4*N)+1,mod(j,4*N)+1))
            b8N(i,j) = 255;
        end
    end
end

RMSE = 0;
for i = 1:m
    for j = 1:n
        RMSE = RMSE+ (((fl(i,j)-b8N(i,j))^2)/(m*n));
    end
end
RMSE = sqrt(RMSE);

fide = fidelity(fl,b8N);

figure(1)
imshow(b2N);
truesize;
colormap;
figure(2)
imshow(b4N);
truesize;
figure(3)
imshow(b8N);
truesize;

imwrite(uint8(b2N),'dithering2N.tif')
imwrite(uint8(b4N),'dithering4N.tif')
imwrite(uint8(b8N),'dithering8N.tif')

