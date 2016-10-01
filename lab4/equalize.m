function [Y] = equalize(X)

L = 256;
H = hist(X(:),[0:255]);
total = sum(H);
Fx = zeros(1,L);
Z = zeros(1,L);

for i = 1:1:L
    Fx(i) = sum(H(1:i))/total;
end
clf;
figure(1)
plot(Fx);
title('CDF of the image');
xlabel('intensity');

Ymax = max(Fx);
Ymin = min(Fx);
Z = (L-1)*(Fx - Ymin)/(Ymax-Ymin);
[m n] = size(X);

Y = zeros(m,n,'uint8');


for i = 1:1:m
    for j = 1:1:n
    Y(i,j) = Z(X(i,j));
    end
end
road = 'E:\2016spring\ECE637\lab4\equalized_kids.jpg';
imwrite(Y,road);
    