clc;
clear;

N = 1000;
mean = [0;0];
var = [1,0;0,1];
W=mvnrnd(mean,var,N);
W=W';

Rx = [2,-1.2;-1.2,2];
[E,A] = eig(Rx);
X_bar = (A.^(1/2))*W;   
X = E*X_bar;

mean_x = (1/N)*sum(X,2);
Z=X-repmat(mean_x,1,N); %B = repmat(A,[M,N]) creates a large matrix B consisting of an M-by-N tiling of copies of A. If A is a matrix, the size of B is [size(A,1)*M, size(A,2)*N].
R = 1/(N-1)*Z*Z';
[E_new,A_new]=eig(R);
Xt_new=E_new'*X;
W2=(A_new.^(1/2))\Xt_new; %\ refer to left matrix divide
R_w=1/(N-1)*W2*W2';
figure
plot(W2(1,:),W2(2,:),'.')
title('the plot of W')
axis('equal') 
figure
plot(Xt_new(1,:),Xt_new(2,:),'.')
title('the plot of Xbar_new')
axis('equal') 
