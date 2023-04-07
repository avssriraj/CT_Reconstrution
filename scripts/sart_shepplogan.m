clear ;

n = 512;
angle_theta = linspace(0, 180, 361);
angle_theta(end) = [];

A = @(x) radon(x, angle_theta);
AT = @(y) iradon(y, angle_theta, 'none', n)/(pi/(2*length(angle_theta)));
AINV = @(y) iradon(y, angle_theta, n);

load('shepplogannorm.mat');
x = imresize(double(normA), [n, n]);
p = A(x);
x_full = AINV(p);
i0 = 5e4;
pn = max(-log(max(poissrnd(i0.*exp(-p)),1)./i0),0);
y = pn;
x_low = AINV(y);

ATA	= AT(A(ones(size(x), 'single')));
x = zeros(size(x));
for i = 1:2e2
    x  	= x + 1e0*AT(pn - A(x))./ATA;
    x(x < 0) = 0;
    figure(1);
    colormap gray;
    imagesc(x);
    axis image off;
    title(num2str([i, 2e2], '%d / %d'));
    drawnow();
end
x_art   = gather(x);
x_art = max(x_art, 0);

wndImg  = [0, 0.03];

figure(1);
colormap(gray(256));
title('Reconstruction of Noised Phantom')

figure(2);
imagesc(x, wndImg);
axis image off;
title('Shepp Logan Input Phantom');
colormap(gray(256));

figure(3);
imagesc(y - p);
xlabel('Angle');
ylabel('Detector');
title('Poisson noise');
colormap(gray(256));