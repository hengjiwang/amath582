%% load data
close all; clear all; clc;

figure(1)
tr_piano=16; % record time in seconds
y1=audioread('music1.wav'); Fs=length(y1)/tr_piano;
plot((1:length(y1))/Fs,y1);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
p8 = audioplayer(y1,Fs); playblocking(p8);

figure(2)
tr_rec=14; % record time in seconds
y2=audioread('music2.wav'); Fs=length(y2)/tr_rec;
plot((1:length(y2))/Fs,y2);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (recorder)');
p8 = audioplayer(y2,Fs); playblocking(p8);

%% Gabor transform with different widths

widths = [10, 1000, 5000, 10000, 20000, 50000, 100000, 300000];

figure(3)

for j=1:length(widths)
    width = widths(j);
    subplot(2,length(widths)/2, j);
    spectrogram(y1, gausswin(width), 0.8*width, width, Fs,'yaxis');
    title(['widths = ' num2str(width)])
end

%% filter out the central frequency
width = 5000;
[s,w,t] = spectrogram(y1, gausswin(width), 0.8*width, width, Fs);

S = abs(s);

for j = 1:length(t)
    [m,I] = max(S(:,j));
    Sf(:,j) = S(:,j).*exp(-0.01*(w-I).^2);
end

Sf = Sf/max(Sf(:));

[T,W] = meshgrid(t,w(1:20));
mesh(T,W,Sf(1:20,:),'FaceLighting','gouraud','LineWidth',0.3)

%subplot(1,2,2)
%spectrogram(y2, width, overlap, width, Fs,'yaxis') % recorder


