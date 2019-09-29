function [frames,nx,ny,nt] = load_frames(filename)
% returns the data of the input videos

vidData = cell2mat(struct2cell(load(filename)));
[nx,ny,~,nt] = size(vidData);

frames = zeros(nx,ny,nt);

for t = 1:nt
    mov(t).cdata = vidData(:,:,:,t);    
    mov(t).colormap = [];
end

for t = 1:nt
    X = frame2im(mov(t));
    frames(:,:,t) = rgb2gray(X);
end

