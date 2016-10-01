clc;
clear;

data = load('E:\2016spring\ECE637\lab6\data.mat');
illu1 = data.illum1;
illu2 = data.illum2;
wavelength = [400:10:700];
x0 = data.x;
y0 = data.y;
z0 = data.z;
figure(1)
plot(wavelength,x0,'+-',wavelength,y0,'*-',wavelength,z0,'d-');
        legend('x0','y0','z0');
title('color match function');

A_inver = [0.2430 0.8560 -0.0440;-0.3910 1.1650 0.0870;0.0100 -0.0080 0.5630];
mat_x = zeros(3,31);
mat_x(1,:) = x0;
mat_x(2,:) = y0;
mat_x(3,:) = z0;
LMS = A_inver * mat_x;
figure(2)
plot(wavelength,LMS(1,:),'+-',wavelength,LMS(2,:),'*-',wavelength,LMS(3,:),'d-');
        legend('l0','m0','s0');
title('LMS color match function');

figure(3)
plot(wavelength,illu1,'+-',wavelength,illu2,'*-');
        legend('D65','fluorescent');
title('spectrum of D65 and fluorescent');

