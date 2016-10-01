function label = classify(T,params,mean,Un)

T_t=Un'*(T-mean); %reduce the dimension of the input image
class='abcdefghijklmnopqrstuvwxyz';

MAD_min=(T_t-params(1).M)'/(params(1).R)*(T_t-params(1).M)+log(det(params(1).R));
label=class(1);
for k=2:26
MAD=(T_t-params(k).M)'/(params(k).R)*(T_t-params(k).M)+log(det(params(k).R));
if MAD<MAD_min
label=class(k);
MAD_min=MAD;
end
end

