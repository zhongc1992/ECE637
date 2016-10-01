function [params,mean,Un]=part5(X)
[m n] = size(X);
mean = (1/n)*sum(X,2);
mean_mat = repmat(mean,1,n);
Z=(X-mean_mat)/(sqrt(n-1));
[U,S,V]=svd(Z,0);

Un=U(:,1:10);
Y = Un'*(X-mean_mat);

empty_cell=cell(26,2);
params=cell2struct(empty_cell,{'M','R'},2);

for k=1:26
    params(k).M=Y(:,k);
    for i=1:11
        params(k).M=Y(:,i*26+k)+params(k).M;
    end
params(k).M=params(k).M/12;
end

for k=1:26
    params(k).R=(Y(:,k)-params(k).M)*(Y(:,k)-params(k).M)';
    for i=1:11
        params(k).R=(Y(:,i*26+k)-params(k).M)*(Y(:,i*26+k)-params(k).M)'+params(k).R;
    end
    %params(k).R=params(k).R/11;
   
    %params(k).R=diag(diag(params(k).R/11));      %diag(X) is the main diagonal of X. diag(diag(X)) is a diagonal matrix.
    params(k).R=eye(10);          
end
 % average
%     Rwc=zeros(10,10);
%     for k=1:26
%     Rwc=params(k).R+Rwc;
%     end
%     Rwc=Rwc/26;
%     Rwc=diag(diag(Rwc));
%     for k=1:26
%      params(k).R=Rwc;
%     end