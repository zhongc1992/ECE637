clc;
clear;

h = 1/81;
H = 0;
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
        for k = -4:1:4
            for l = -4:1:4
                H(i_ind,j_ind) = H(i_ind,j_ind) +  h*exp(-i*(k*u_comp + l*v_comp));
            end
        end
    end
end
[m,n] = meshgrid(-pi :0.1: pi,-pi :0.1: pi);
H_mag = abs(H);
%mesh(m,n,H_mag)
surf(m,n,H_mag)
axis([-pi pi -pi pi 0 1])
title('DSFT of h(m,n),part 3.1')
zlabel('Magnitude')
xlabel('horizontal frequency component')
ylabel('vertical frequency component')