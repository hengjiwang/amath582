%% load music

close all; clear all; clc;

load handel
v = y'/2;

figure(1)
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

figure(2)
for j = 1:length(widths)
    width = widths(j);
    subplot(2,length(widths)/2, j);
    spectrogram(v,gausswin(width),translt,[],Fs,'yaxis')
    title(['widths = ' num2str(width)])
end

%% oversampling & undersampling

width = 500;
translts = [-4000, -2000, -1000, -100, 0, 100, 200, 499];

figure(3)
for j = 1:length(translts)
    translt = translts(j);
    subplot(2,length(translts)/2, j);
    spectrogram(v,gausswin(width),translt,width,Fs,'yaxis')
    translt = width-translt;
    title(['translation = ' num2str(translt)])
end

%% try different Gabor windows

width = 500;
translt = 0;

tt = (-(width-1)/2:(width-1)/2)';

% construct a shannon window
shanwidth = 400;
shanwin = zeros(length(tt),1);
shanwin(width/2-shanwidth/2: width/2+shanwidth/2) = 1.0;

figure(4)
subplot(1,3,1)
spectrogram(v,gausswin(width),translt, width, Fs,'yaxis') % gaussian window
title('Gaussian window')
subplot(1,3,2)
spectrogram(v,(1-tt.^2).*gausswin(width),translt, width, Fs,'yaxis') % mexican hat wavelet
title('Mexican hat wavelet')
subplot(1,3,3)
spectrogram(v,shanwin,translt, width, Fs,'yaxis') % shannon window
title('Shannon window')

