%% load data
clear all; close all; clc; 
load Testdata

L=15; % spatial domain 
n=64; % Fourier modes 
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x; 
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k);

[X,Y,Z]=meshgrid(x,y,z); 
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);

% plot the noisy data of measurement 1
figure(1)
Un1(:,:,:)=reshape(Undata(1,:),n,n,n);
isosurface(X,Y,Z,abs(Un1),0.8)
axis([-L L -L L -L L]), grid on, drawnow
xlabel('x'); ylabel('y');zlabel('z');
pause(1)

%% do fourier transformation on data and average the spectrum
Untave = 0;

for j=1:20 
    Un(:,:,:)=reshape(Undata(j,:),n,n,n); 
    Unt = fftn(Un);
    Untave = Untave + Unt;
end

%% locate the central frequency

% normalize spectrum 1 (for comparison)
specUnt1 = abs(fftn(reshape(Undata(4,:),n,n,n)));
spec1d1 = reshape(specUnt1, n^3, 1);
specmax1 = max(spec1d1);
specUnt1 = specUnt1/specmax1;

% normalize averaged spectrum
specUntave = abs(Untave);
spec1d = reshape(specUntave, n^3, 1);
specmax = max(spec1d);
specUntave = specUntave/specmax;

% plot the isosurface in frequency domain
figure(2)

subplot(1,2,1)
isosurface(Kx,Ky,Kz,fftshift(specUnt1),0.6)
axis([-2*pi 2*pi -2*pi 2*pi -2*pi 2*pi]), grid on, drawnow
xlabel('kx'); ylabel('ky');zlabel('kz');
pause(1)

subplot(1,2,2)
isosurface(Kx,Ky,Kz,fftshift(specUntave),0.6)
axis([-2*pi 2*pi -2*pi 2*pi -2*pi 2*pi]), grid on, drawnow
xlabel('kx'); ylabel('ky');zlabel('kz');
pause(1)

% search the central frequency (with the biggest signal intensity)
for m = 1:n
    [i,j] = find(specUntave(:,:,m) == 1);
    if isempty(i)~=1 && isempty(j)~=1
        cent_freq = [i, j, m];
        break
    end
end

%% make a filter
filter = exp(-1.0*(fftshift(Kx)-k(cent_freq(2))).^2) .* ...
    exp(-1.0*(fftshift(Ky)-k(cent_freq(1))).^2) .* ...
    exp(-1.0*(fftshift(Kz)-k(cent_freq(3))).^2);

%% compute and plot the trajectory

position = zeros(20, 3);

figure(3) % for plotting the isosurface in spatial domain

subplot(1,2,1)
for j = 1:20
    % apply filter on each spectrum and ifft back
    Un(:,:,:)=reshape(Undata(j,:),n,n,n); 
    Unt = fftn(Un);
    unft = filter.* Unt;
    unf = ifftn(unft);
    
    % get the value of strongest signal 
    locunf = abs(unf);
    loc1d = reshape(locunf, n^3, 1);
    locmax = max(loc1d);
    
    % locate the strongest signal
    for locz = 1:n
        [locy,locx] = find(locunf(:,:,locz) == locmax);
        if isempty(locx)~=1 && isempty(locy)~=1
            position(j,:) = [x(locx), y(locy), z(locz)];
            break
        end
    end
    
    isosurface(X,Y,Z,locunf/locmax,0.8)
    axis([-L L -L L -L L]), grid on, drawnow
    xlabel('x'); ylabel('y');zlabel('z');
    pause(1)
    
end

% plot the trajectory
subplot(1,2,2)
plot3(position(:,1), position(:,2), position(:,3), 'bo-', 'Linewidth', 2)
axis([-L L -L L -L L]), grid on, drawnow
xlabel('x'); ylabel('y');zlabel('z');

%% print the last position

result = sprintf('The position of the marble at the 20th data is x: %.3f, y: %.3f, z: %.3f',...
    position(20,1), position(20,2),position(20,3));

disp(result)





