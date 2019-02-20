function [x,y] = locate_mass1221(frame,xmin,xmax,ymin,ymax,threshold)
% returns the coordinates of the tracking point on the mass

for x = xmin:xmax
    for y = ymax:-1:ymin
        if frame(x,y)>threshold
            return
        end
    end
end

error('Failed to track!')

end


