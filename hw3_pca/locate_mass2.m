function [x,y] = locate_mass2(frame,xmin,xmax,ymin,ymax)
% returns the coordinates of the tracking point on the mass

crop_area = frame(xmin:xmax, ymin:ymax);
[~, ind] = max(crop_area(:));
[x, y] = ind2sub(size(crop_area),ind);
x = x + xmin;
y = y + ymin;

end



