function [x,y] = locate_mass2121(frame,xmin,xmax,ymin,ymax,threshold)
% returns the coordinates of the tracking point on the mass

for x = xmax:-1:xmin
    for y = ymax:-1:ymin
        if frame(x,y)>threshold
            return
        end
    end
end

error('Failed to track!')

end


