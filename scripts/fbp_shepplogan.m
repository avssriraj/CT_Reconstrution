load sl_sinogram.mat; sinogram = R; 

dr=1;
[rays, views] = size(sinogram);
row=rays; col=rays; dx=dr;
angle = (0:(views-1))'/views * pi;
r = dr * ((1:rays)'-(rays+1)/2);

x = dx * ((1:row)'-(row+1)/2);
y = -dx * ((1:col)'-(col+1)/2);
xx = x(:,ones(1,col));
yy = y(:,ones(1,col))';


figure(1)
imagesc( r, angle/pi*2719, sinogram'); colormap('gray'); axis('image')
title('Sinogram of Shepp Logan')
xlabel('Angle')
ylabel('Ray Positions')
 
lamin = zeros(row,col);  
for index = 1:views
projection_ia=sinogram(:,index);
projection_smear=repmat (projection_ia,1,2719);
rot= imrotate(projection_smear, index*180/180, 'bicubic','crop'); 
lamin=lamin+rot;
end

figure(2)
imagesc(x, y, lamin'); colormap('gray'); axis('image')
title('Simple Backprojection of Shepp Logan')

theta=0:179;      
RamLak_filtered=iradon(sinogram, theta, 'linear','Ram-Lak', 1.0, size(sinogram,1));

figure(3)
imagesc(RamLak_filtered); colormap('gray');  
title('Shepp Logan using Iradon Filtered Backprojection')