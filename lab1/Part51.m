clc;
clear;

u = -pi:0.1:pi; %horizontal frequency component
v = -pi:0.1:pi; %vertical frequency component
size_u = length(u);
size_v = length(v);
size_h = size_u * size_v;
H = zeros(size_u,size_v);
for i_ind = 1:1:size_u
    u_comp = u(i_ind);
    for j_ind = 1:1:size_v
        v_comp = v(j_ind);
        H(i_ind,j_ind) = 0.01*(1./((1-0.9*exp(-i*u_comp)).*(1-0.9*exp(-i*v_comp))));
    end
end
[m,n] = meshgrid(-pi :0.1: pi,-pi :0.1: pi);
H_mag = abs(H);
%mesh(m,n,H_mag)
surf(m,n,H_mag)
axis([-pi pi -pi pi 0 1])
title('DSFT of h(m,n),part 5.1')
zlabel('Magnitude')
xlabel('horizontal frequency component')
ylabel('vertical frequency component')

X = zeros(256,256);
X(127,127) = 1;
Y = zeros(257,257);% add a row a col with zeros for calculation conviance
for m = 1:1:256
    for n = 1:1:256
        Y(m+1,n+1)=0.01*X(m,n)+0.9*Y(m,n+1)+0.9*Y(m+1,n)-0.81*Y(m,n);
    end
end

Y_final = zeros(256,256);
for m = 1:1:256
    for n = 1:1:256
        Y_final(m,n)=Y(m+1,n+1); %get rid of the extra row and col
    end
end

imwrite(uint8(255*100*Y_final),'h_out.tif');