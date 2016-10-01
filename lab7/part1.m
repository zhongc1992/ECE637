clc;
clear;

x = imread('E:\2016spring\ECE637\lab7\img14sp.tif');
y = imread('E:\2016spring\ECE637\lab7\img14g.tif');
x = double(x);
y = double(y);
[m,n] = size(x);
a = floor(m/20);
b = floor(n/20);
Y = reshape(y(20:20:512,20:20:768),a*b,1);% a column vector, put every col of y one after another into Y

row = 1;
for j = 20:20:760   % should match the order of Y, search through each column
    for i = 20:20:500
        Z(row,:) = reshape(x(i-3:i+3,j-3:j+3),1,49);
        row = row +1;  
    end
end

Rzz = (Z'*Z)/(a*b);
rzy = (Z'*Y)/(a*b);
theta = Rzz\rzy;

x_bord = zeros(m+6,n+6);
x_bord(4:m+3,4:n+3)=x;
for i = 1:1:m
    for j = 1:1:n
        temp = reshape(x_bord(i:i+6,j:j+6),1,49);
        x(i,j) = (temp*theta);
    end
end
imshow(uint8(x));
reshape(theta,7,7);
