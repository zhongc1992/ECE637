clc;
clear;

[X Y] = meshgrid(0:0.005:1,0:0.005:1);
size = size(X)
Z = zeros(size(1),size(1));
for i = 1:1:size(1)
    for j = 1:1:size(1)
        Z(i,j) = 1-X(i,j)-Y(i,j);
    end
end
M1=[0.640, 0.330, 0.030;0.300, 0.600, 0.100;0.150, 0.060, 0.790];%R709 primaries
M = M1';

RGB = zeros(201,201,3);
gam = 2.2;
for m = 1:1:201
    for n = 1:1:201
        RGB(m,n,:) = M\[X(m,n) Y(m,n) Z(m,n)]';
        if RGB(m,n,1)<0||RGB(m,n,2)<0||RGB(m,n,3)<0
            RGB(m,n,:)=[1 1 1];
        end
            RGB(m,n,:)=RGB(m,n,:).^(1/gam);
    end
end
image([0:.005:1],[0:.005:1],RGB);
xlabel('x')
ylabel('y')
axis('xy')
hold on
data = load('E:\2016spring\ECE637\lab6\data.mat');
illu1 = data.illum1;
illu2 = data.illum2;
wavelength = [400:10:700];
x0 = data.x;
y0 = data.y;
z0 = data.z;

x_chro = x0./(x0+y0+z0);
y_chro = y0./(x0+y0+z0);


plot(x_chro,y_chro,'-', 'MarkerSize',10);

R_CIE=[0.73467, 0.26533];
G_CIE=[0.27376, 0.71741];
B_CIE=[0.16658, 0.00886];
plot([R_CIE(1) G_CIE(1) B_CIE(1) R_CIE(1)], [R_CIE(2) G_CIE(2) B_CIE(2) R_CIE(2)],'r'); %seperately plot x and y coordinates
text(R_CIE(1),R_CIE(2),'R-CIE');
text(G_CIE(1),G_CIE(2),'G-CIE');
text(B_CIE(1),B_CIE(2),'B-CIE');

R_709=[0.640, 0.330];
G_709=[0.300, 0.600];
B_709=[0.150, 0.060, 0.790];
plot([R_709(1) G_709(1) B_709(1) R_709(1)], [R_709(2) G_709(2) B_709(2) R_709(2)],'g'); %seperately plot x and y coordinates
legend('spectral source','CIE 1931 RGB primaries','Rec. 709 RGB primaries')
text(R_709(1),R_709(2),'R-709');
text(G_709(1),G_709(2),'G-709');
text(B_709(1),B_709(2),'B-709');

D65 = [0.3127, 0.3290, 0.3583];
plot(D65(1),D65(2),'.','MarkerSize',20,'Color','k')
text(D65(1)-0.03,D65(2)+0.03,'D65');
F=[0.3333, 0.3333];
plot(F(1),F(2),'.','MarkerSize',20,'Color','m')
text(F(1),F(2)+0.03,'euqal energy')

