clc
clear
close

img = rand(512);%generate a 512X512 matrix on (0,1)
img = img - 0.5;%map the matrix into (-0.5,0.5)
img_scaled=255*(img+0.5);
imwrite(uint8(img_scaled),'rand_img.tif');%generate the actual image

y = zeros(513,513); %adding a zero col and zero row for calculation
yf = zeros(512,512); %image after filtered

for k = 1:512 %k cols, for x axis
    for l = 1:512 %l rows, for y axis
        y(k+1,l+1) = 3*img(k,l)+0.99*y(k,l+1)+0.99*y(k+1,l)-0.9801*y(k,l);
        yf(k,l) = y(k+1,l+1) + 127;
    end
end

imwrite(uint8(yf),'rand_filterd.tif')

N = 512;
% Compute the power spectrum for the NxN region
Z = (1/N^2)*abs(fft2(yf)).^2;

% Use fftshift to move the zero frequencies to the center of the plot
Z = fftshift(Z);

% Compute the logarithm of the Power Spectrum.
Zabs = log( Z );


% Plot the result using a 3-D mesh plot and label the x and y axises properly. 

x = 2*pi*((0:(N-1)) - N/2)/N;
y = 2*pi*((0:(N-1)) - N/2)/N;
figure 
mesh(x,y,Zabs)
xlabel('\mu axis')
ylabel('\nu axis')

BetterSpecAnal(yf)




