clc;
clear;

lamda = 1.5;
h = 1/25;
d = 1;
H = 0;
u = -pi:0.1:pi; %horizontal frequency component
v = -pi:0.1:pi; %vertical frequency component
size_u = length(u);
size_v = length(v);
size_h = size_u * size_v;
H = zeros(size_u,size_v); %function H
D = zeros(size_u,size_v); %the delta function
for i_ind = 1:1:size_u
    u_comp = u(i_ind);
    for j_ind = 1:1:size_v
        v_comp = v(j_ind);
        for k = -2:1:2
            for l = -2:1:2
                H(i_ind,j_ind) = H(i_ind,j_ind) +  h*exp(-i*(k*u_comp + l*v_comp));
                if ((k == 0) & (l == 0))
                    D(i_ind,j_ind) = d*exp(-i*(k*u_comp + l*v_comp));
                end
            end
        end
    end
end
[m,n] = meshgrid(-pi :0.1: pi,-pi :0.1: pi);
H_mag = abs(H);
%mesh(m,n,H_mag)
figure(1);
surf(m,n,H_mag);
axis([-pi pi -pi pi 0 1]);
title('DSFT of h(m,n),part4.1');
zlabel('Magnitude');
xlabel('horizontal frequency component');
ylabel('vertical frequency component');

G = zeros(size_u,size_v); %function G
G = D+lamda*(D-H);
G_mag = abs(G);
figure(2);
surf(m,n,G_mag);
%axis([-pi pi -pi pi 0 1]);
title('DSFT of g(m,n),part4.1');
zlabel('Magnitude');
xlabel('horizontal frequency component');
ylabel('vertical frequency component');