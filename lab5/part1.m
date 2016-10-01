clc;
clear;

N = 1000;
mean = [0;0];
var = [1,0;0,1]
W=mvnrnd(mean,var,N);
W=W';

Rx = [2,-1.2;-1.2,2]
[E,A] = eig(Rx);
X_bar = (A.^(1/2))*W;   
X = E*X_bar;

plot(W(1,:),W(2,:),'.')
title('the plot of W')
axis('equal') 
figure
plot(X_bar(1,:),X_bar(2,:),'.')
title('the plot of Xbar')
axis('equal') 
figure
plot(X(1,:),X(2,:),'.')
title('the plot of X')
axis('equal') 