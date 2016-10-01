function BetterSpecAnal(img)

N = 64;
z=zeros(N,N);
Z=zeros(N,N);

[m,n] = size(img); %get the size of this img
%Y axis is the row = 512,X axis is the col = 768
stx = m/2-5*N/2;%get the start point of 25 windows at the center
sty = n/2-5*N/2;%this is a dynamic range,varies with different image size

W = hamming(64)*hamming(64)'; %hamming window
for k=1:5
    for l=1:5
        z = W.*img((sty+N*(l-1)):(sty-1+N*l),(stx+N*(k-1)):(stx-1 + N*k));%pick a window and multiply by hamming window
        Z = abs(fft2(z)).^2 + Z; %Sum up
    end
end
% Compute the power spectrum for the NxN region
Z = (1/N^2)*(Z);
Z = Z/25;

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


