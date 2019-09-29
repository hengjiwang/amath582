%% load data
close all; clear all; clc;

figure(1)
tr_piano=16; % record time in seconds
y1=audioread('music1.wav'); Fs1=length(y1)/tr_piano;
plot((1:length(y1))/Fs1,y1);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
%p8 = audioplayer(y1,Fs); playblocking(p8);

figure(2)
tr_rec=14; % record time in seconds
y2=audioread('music2.wav'); Fs2=length(y2)/tr_rec;
plot((1:length(y2))/Fs2,y2);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (recorder)');
%p8 = audioplayer(y2,Fs2); playblocking(p8);

%% Gabor transform with different widths

widths = [10, 1000, 5000, 10000, 20000, 50000, 200000, 600000];


figure(3)

for j=1:length(widths)
    width = widths(j);
    subplot(2,length(widths)/2, j);
    spectrogram(y1, gausswin(width), 0.8*width, width, Fs1,'yaxis');
    title(['width = ' num2str(width)])
end

%% filter out the central frequency
width = 5000;
[s,w,t] = spectrogram(y1, gausswin(width), 0.8*width, width, Fs1);

S = abs(s);
S = S/max(S(:));

figure(4)
subplot(1,2,1)
[T,W] = meshgrid(t,w(1:50));
mesh(T,W,S(1:50,:),'FaceLighting','gouraud','LineWidth',0.6)
xlabel('time/s'); ylabel('frequency/Hz')
title('piano')

[s,w,t] = spectrogram(y2, gausswin(width), 0.8*width, width, Fs2);

S = abs(s);
S = S/max(S(:));

subplot(1,2,2)
[T,W] = meshgrid(t,w(1:200));
mesh(T,W,S(1:200,:),'FaceLighting','gouraud','LineWidth',0.6)
xlabel('time/s'); ylabel('frequency/Hz')
title('recorder')

%subplot(1,2,2)
%spectrogram(y2, width, overlap, width, Fs,'yaxis') % recorder
