function [] = play_video(filename)
% play the input video

vidData = cell2mat(struct2cell(load(filename)));
[nx,ny,nc,nt] = size(vidData);

for t = 1 : nt
    mov(t).cdata = vidData(:,:,:,t);    
    mov(t).colormap = [];
end

figure

for t = 1 : nt
    [X] = frame2im(mov(t));
    imshow(X);drawnow
end

end

