function [x,y] = locate_massy2112(frame,xmin,xmax,ymin,ymax,threshold)
% returns the coordinates of the tracking point on the mass

for y = ymax:-1:ymin
    for x = xmin:xmax
        if frame(x,y)>threshold
            return
        end
    end
end

error('Failed to track!')

end

