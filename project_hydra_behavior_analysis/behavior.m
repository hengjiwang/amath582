%% import video

close all; clear all; clc;

v = VideoReader('20141218_somersaulting.avi');

frames = [];

j = 0;

while j < 2000
    frame = rgb2gray(readFrame(v));
    vec_f = reshape(frame,[],1);
    frames = [frames, vec_f];
    % imshow(frame); shading flat;
    j = j + 1;
end

h = v.Height;
w = v.Width;

%%

frames=double(frames);
frames = frames-repmat(mean(frames),262*362,1);

%% 



[u, s, v] = svd(frames(:,300:500), 'econ');

%%

for j = 1:8
    subplot(2,4,j)
    aa = reshape(u(:,j),262,362);
    imshow(uint8(1e4*aa))
end


