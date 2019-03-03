%% Load images

close all; clear all; clc

ims = [];

for i = 1:39
    if i<10
        path = strcat('CroppedYale/yaleB0',num2str(i),'/');
    else
        path = strcat('CroppedYale/yaleB',num2str(i),'/');
    end
    
    files = dir(strcat(path,'*.pgm'));
    for j = 1:length(files)
        im = imread(strcat(path,files(j).name));
        im = reshape(im, [], 1);
        ims = [ims, im];
    end
end

ims = double(ims);

%% Demean data

[npixel, nimage] = size(ims);
M = repmat(mean(ims,1),npixel,1);
ims = ims - M;

%% SVD

[u,s,v] = svd(ims, 'econ');

%% Plot S

energies = max(s,[],1);
energies = energies/sum(energies);

figure(1)
subplot(1,2,1)
plot(energies, 'ro--')
xlabel('PC')
ylabel('energy')
title('Energies')

subplot(1,2,2)
plot(log(energies), 'ro--')
xlabel('PC')
ylabel('log(energy)')
title('Log scale energies')

%% Plot U

figure(2)

% plot top 12 principle components
for j = 1:12
    subplot(3,4,j)
    eigenface = reshape(u(:,j),[192,168]);
    pcolor(eigenface); shading flat; colormap gray; axis ij;
    title(['PC',num2str(j)])
end

%% Plot V

figure(3)

% plot the composition of the top 12 components
for j = 1:12
    subplot(3,4,j)
    comsposition = v(j,:);
    plot(comsposition)
end

%% Load uncropped images

ims_uncrop = [];

path = 'yalefaces_uncropped/yalefaces/';

for i = 1:15
    if i < 10
        files = dir(strcat(path, 'subject0', num2str(i), '.*'));
    else 
        files = dir(strcat(path, 'subject', num2str(i), '.*'));
    end
    for j = 1:length(files)
        im = imread(strcat(path,files(j).name));
        im = reshape(im, [], 1);
        ims_uncrop = [ims_uncrop, im];
    end
end

ims_uncrop = double(ims_uncrop);

%% Demean uncropped data

[npixel, nimage] = size(ims_uncrop);
M = repmat(mean(ims_uncrop,1),npixel,1);
ims_uncrop = ims_uncrop - M;

%% SVD on uncropped data

[u2,s2,v2] = svd(ims_uncrop, 'econ');

%% Plot S

energies2 = max(s2,[],1);
energies2 = energies2/sum(energies2);

figure(1)
subplot(1,2,1)
plot(energies2, 'ro--')
xlabel('PC')
ylabel('energy')
title('Energies')

subplot(1,2,2)
plot(log(energies2), 'ro--')
xlabel('PC')
ylabel('log(energy)')
title('Log scale energies')

%% Plot U

figure(2)

% plot top 12 principle components
for j = 1:12
    subplot(3,4,j)
    eigenface = reshape(u2(:,j),[243,320]);
    pcolor(eigenface); shading flat; colormap gray; axis ij;
    title(['PC',num2str(j)])
end

%% Plot V

figure(3)

% plot the composition of the top 12 components
for j = 1:12
    subplot(3,4,j)
    comsposition = v2(j,:);
    plot(comsposition)
end

%%

figure(4)
subplot(1,2,1)
plot(log(energies), 'ro--')
xlabel('PC')
ylabel('log(energy)')
title('Cropped')

subplot(1,2,2)
plot(log(energies2), 'bo--')
xlabel('PC')
ylabel('log(energy)')
title('Uncropped')
