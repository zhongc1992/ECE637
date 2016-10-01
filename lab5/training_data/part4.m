function part4(X)
[p,n]=size(X);
mu=1/n*sum(X,2);
Z=(X-repmat(mu,1,n))/(sqrt(n-1));
[U,S,V]=svd(Z,0);


%first 12 eigenimages
% Um=U(:,1:12);
% for i=1:12
% subplot(4,3,i)
% imagesc(reshape(Um(:,i),64,64))
% colormap(gray(256))
% axis equal
% end

% projection coefficients
% Un=U(:,1:10);
% color=['c','m','y','k'];
% Y=Un'*(X(:,1:4)-repmat(mu,1,4));  %n*n
% figure
% hold on
% for i=1:4
% plot(Y(1:10,i),'Color',color(i))
% xlim([1 10]) 
% end
% legend('a','b','c','d')
% hold off


%6 resynthesized versions
c=[1,5,10,15,20,30];
figure 
imagesc(reshape(X(:,1),64,64))
colormap(gray(256))
figure
for i=1:6
subplot(3,2,i)
Un=U(:,1:c(i));
Y=Un'*(X-repmat(mu,1,n));  %n*n
X_new=Un*Y+repmat(mu,1,n);
imagesc(reshape(X_new(:,1),64,64))
colormap(gray(256))
end



