%% load music

close all; clear all; clc;

load handel
v = y'/2;
plot((1:length(v))/Fs,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');

%% play music

p8 = audioplayer(v, Fs);
playblocking(p8);

%% Gabor transform with different widths

widths = [2, 10, 100, 500, 5000, 10000, 20000, length(v)];
translt = 0;

figure(1)
for j = 1:length(widths)
    width = widths(j);
    subplot(2,length(widths)/2, j);
    spectrogram(v,width,translt,[],Fs,'yaxis')
end

%% oversampling & undersampling

width = 500;
translts = [-4000, -2000, -1000, -100, 0, 100, 200, 499];

figure(2)
for j = 1:length(translts)
    translt = translts(j);
    subplot(2,length(translts)/2, j);
    spectrogram(v,width,translt,width,Fs,'yaxis')
end

%% try different Gabor windows

width = 500;
translt = 0;

tt = (-(width-1)/2:(width-1)/2)';

% construct a shannon window
shanwidth = 20;
shanwin = tt;
shanwin(1:-shanwidth/2) = 0.0;
shanwin(shanwidth/2:500) = 0.0;


figure(3)
subplot(1,3,1)
spectrogram(v,gausswin(width),translt, width, Fs,'yaxis') % gaussian window
subplot(1,3,2)
spectrogram(v,(1-tt.^2).*gausswin(width),translt, width, Fs,'yaxis') % mexican hat wavelet
subplot(1,3,3)
spectrogram(v,shanwin,translt, width, Fs,'yaxis') % gaussian window


