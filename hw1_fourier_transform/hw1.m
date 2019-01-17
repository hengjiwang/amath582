%% load data
clear all; close all; clc; 
load Testdata

L=15; % spatial domain 
n=64; % Fourier modes 
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x; 
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k);

[X,Y,Z]=meshgrid(x,y,z); 
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);

%% do fourier transformation on data and average the spectrum
Untave = 0;

for j=1:20 
    Un(:,:,:)=reshape(Undata(j,:),n,n,n); 
    Unt = fftn(Un);
    Untave = Untave + Unt;
end

%% locate the central frequency

% normalize spectrum
specUntave = abs(Untave);
spec1d = reshape(specUntave, n^3, 1);
specmax = max(spec1d);
specUntave = specUntave/specmax;

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
end

% plot the trajectory
figure(1)
plot3(position(:,1), position(:,2), position(:,3), 'bo-', 'Linewidth', 2)

%% print the last position

result = sprintf('The position of the marble at the 20th data is x: %.3f, y: %.3f, z: %.3f',...
    position(20,1), position(20,2),position(20,3));

disp(result)



%{ 
%% test the accuracy
j=9;
Un(:,:,:)=reshape(Undata(j,:),n,n,n); 
Unt = fftn(Un);
unft = filter.* Unt;
unf = ifftn(unft);

locunf = abs(unf);
loc1d = reshape(locunf, n^3, 1);
locmax = max(loc1d);

sortloc = sort(loc1d, 'descend');
pick = sortloc(1:10);
for q = 1:10
locmax = pick(q);
    for locz = 1:n
        [locx,locy] = find(locunf(:,:,locz) == locmax);
        if isempty(locx)~=1 && isempty(locy)~=1
            position(q,:) = [x(locx), y(locy), z(locz)];
            break
        end
    end
end
%}





