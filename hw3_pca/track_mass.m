function [pos] = track_mass(frames, nt, xmin, xmax, ymin, ymax,threshold,order)
% return the trajectory of the tracking point on the mass

pos = zeros(2,nt);

if order == 1212
    for t = 1:nt
        [x,y] = locate_mass1212(frames(:,:,t),xmin,xmax,ymin,ymax,threshold);
        pos(:,t) = [x,y];
    end
    
elseif order == 1221
    for t = 1:nt
        [x,y] = locate_mass1221(frames(:,:,t),xmin,xmax,ymin,ymax,threshold);
        pos(:,t) = [x,y];
    end
    
elseif order == 2112
    for t = 1:nt
        [x,y] = locate_mass2112(frames(:,:,t),xmin,xmax,ymin,ymax,threshold);
        pos(:,t) = [x,y];
    end 

elseif order == 2121
    for t = 1:nt
        [x,y] = locate_mass2121(frames(:,:,t),xmin,xmax,ymin,ymax,threshold);
        pos(:,t) = [x,y];
    end
    
elseif order == -2112
    for t = 1:nt
        [x,y] = locate_mass_y2112(frames(:,:,t),xmin,xmax,ymin,ymax,threshold);
        pos(:,t) = [x,y];
    end    
    
    
    
end
    
end

