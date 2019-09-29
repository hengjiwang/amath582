% Load video

close all; clear all; clc;

v = VideoReader('videos/pendulum_waves.mp4');

frames = [];
while hasFrame(v)
    frame = rgb2gray(readFrame(v));
    vec_f = reshape(frame,[],1);
    frames = [frames, vec_f];
    % imshow(frame); shading flat;
end

h = v.Height;
w = v.Width;

%% DMD

X1 = double(frames(:,1:end-1)); X2 = double(frames(:,2:end));

[U2,Sigma2,V2] = svd(X1, 'econ');

r = 10; % reconstruction number 
U = U2(:,1:r); Sigma = Sigma2(1:r,1:r); V=V2(:,1:r);
Atilde = U'*X2*V/Sigma; % low-dimensional linear model

[W,D] = eig(Atilde);
Phi = X2*V/Sigma*W; % DMD modes

dt = 1/v.FrameRate;

mu = diag(D);
omega = log(mu)/dt; % eigenvalues of DMD modes

t = linspace(0,v.Duration,floor(v.Duration*v.FrameRate));

y0 = Phi\X1(:,1);  % initial conditions

u_modes = zeros(r,length(t));  % DMD reconstruction for every time point
for iter = 1:length(t)
    u_modes(:,iter) =(y0.*exp(omega*(t(iter))));
end

%% Plots

% plot the singular values

figure(1)
subplot(121)
plot(diag(Sigma2)/sum(diag(Sigma2)),'ro--')
xlabel('POD modes')
ylabel('energy')

% plot the eigenvalues
subplot(122)
plot(abs(omega),'ko','Linewidth',[2]); grid on; %axis([-0.02 0.02 -20 20])
xlabel('DMD modes')
ylabel('omega modules')

% plot the spatial aspects of the DMD modes

modes = abs(reshape(Phi,h,w,r));
figure(3)
for j = 1:r
    subplot(2,5,j)
    imshow(uint8(4e4*modes(:,:,j))); shading flat;
    title(['Mode',num2str(j)])
end

%% Subtraction of Background

u_dmd = Phi(:,5)*u_modes(5,:);   % DMD resconstruction with all modes

ims = reshape(frames, h,w,[]);

background = abs(reshape(u_dmd,h,w,[]));
R = double(ims)-background;
R(R>0) = 0;
background = background + R;
foreground = double(ims)-background;

%% Show results

% for j = 1:length(t)
%     imshow(uint8(2*foreground(:,:,j)))
% end

figure(4)

times = [0,1,2,5,10,20];
for j = 1:length(times)
    subplot(2,3,j)
    imshow(ims(:,:,floor(times(j)*v.FrameRate)+1));
    title([num2str(times(j)),'s'])
end

figure(5)

times = [0,1,2,5,10,20];
for j = 1:length(times)
    subplot(2,3,j)
    imshow(uint8(foreground(:,:,floor(times(j)*v.FrameRate)+1)));
    title([num2str(times(j)),'s'])
end


