function [pos] = track_mass(frames, nt, xmin, xmax, ymin, ymax,threshold)
% return the trajectory of the tracking point on the mass

pos = zeros(2,nt);

for t = 1:nt
    [x,y] = locate_mass(frames(:,:,t),xmin,xmax,ymin,ymax,threshold);
    pos(:,t) = [x,y];
end

end

