function [x,y] = locate_mass(frame,xmin,xmax,ymin,ymax,threshold)
% returns the coordinates of the tracking point on the mass

for x = xmin:xmax
    for y = ymin:ymax
        if frame(x,y)>threshold
            return
        end
    end
end

error('Failed to track!')

end

