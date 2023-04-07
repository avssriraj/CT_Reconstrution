clear all
I1 = imread('SheppLogan_Phantom.png');
I = rgb2gray(I1);
theta = 0:179;
[R,xp] = radon(I,theta);
imagesc(theta,xp,R);
colormap(gray);
save("shepplogan_sinogram.mat",'R')
