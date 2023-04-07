disk = [ 0  -5  210  8;
         0   0  200  2;
       -68   18  50  1;
        18  -68  50  0;
        50   50  50  3;
       -25   95  15  6;
       -70  -65  15  4];

row = 512; col = 512; dx = 1;

x = dx * ((1:row)'-(row+1)/2); y = -dx * ((1:col)'-(col+1)/2);
xx = x(:,ones(1,row)); yy = y(:,ones(1,col))';

phantom = zeros(row,col);
for index=1:size(disk,1)
    x_cord = disk(index,1); y_cord = disk(index,2); 
    radius = disk(index,3); signal_intensity = disk(index,4);
    t = find( ((xx-x_cord)/radius).^2 + ((yy-y_cord)/radius).^2 <= 1 );
    phantom(t) = signal_intensity * ones(size(t));
end

figure(1)
imagesc(x, y, phantom'); colormap('gray'); axis('square');
title('Disk Phantom'); 

nr = 512;	dr = 1;
na = nr*2;
r = dr * ((1:nr)'-(nr+1)/2);
angle = (0:(na-1))'/na * pi;

rr = r(:,ones(1,na));
sg1 = zeros(nr, na);
for index=1:size(disk,1)
    x_cord = disk(index,1); y_cord = disk(index,2); radius = disk(index,3); signal_intensity = disk(index,4);
    tau = x_cord * cos(angle) + y_cord * sin(angle);
    tau = tau(:,ones(1,nr))';
    t = find( (rr-tau).^2 <= radius.^2 );
    if index > 1, signal_intensity = signal_intensity - disk(1,4); end
    sg1(t) = sg1(t)+signal_intensity*2*sqrt(radius^2-(rr(t)-tau(t)).^2);
end

sinogram = sg1;

if 1~=exist('lamin','var')

    lamin = zeros(row,col);
    for ia = 1:na
        
        projection_ia=sinogram(:,ia);   
        projection_smear=repmat (projection_ia,1,512);  
        rot= imrotate(projection_smear', ia*180/1024, 'bicubic','crop');  
        lamin=lamin+rot;     
    end

    figure(2)
    imagesc(x, y, lamin);
    colormap('gray');
    axis('image')
    title('Simple Backprojection of Disc Phantom')

end

sinogramfiltered=fftshift(fft(sinogram));

a = length(sinogram);
freqs=linspace(-1, 1, a/2).';
myFilter = abs(freqs);
myFilter = repmat(myFilter,1,1024);

sinogramfilt=abs(ifft(ifftshift(sinogramfiltered.*myFilter)));

if 1~=exist('bpf_recon','var')  
    bpf_recon = zeros(row,col);

    for ia = 1:na
        bpf_ia=sinogramfilt(:,ia);
        bpf_smear=repmat(bpf_ia,1,512);
        rotation= imrotate(bpf_smear', ia*180/1024, 'bicubic','crop');   
        bpf_recon=bpf_recon+rotation;
    end

    figure(3)
    imagesc(x, y, max(bpf_recon,0)); 
    colormap('gray'); 
    axis('image')
    title('Filtered Backprojection Image')

end

theta=0:180;
[R,~]=radon(phantom,theta);

RL_filtered=iradon(R, theta, 'linear','Ram-Lak', 1.0, size(phantom,1));

figure(4)
imagesc(x,y, RL_filtered); 
colormap('gray');
axis('image')
title('Filtered Backprojection Using iradon Function')
