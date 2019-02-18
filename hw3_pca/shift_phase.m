function [vec1,vec2,vec3] = shift_phase(vec1,vec2,vec3)
% return phase shifted trajectories

nt1 = length(vec1(1,:));
nt2 = length(vec2(1,:));
nt3 = length(vec3(1,:));

[~,p1] = min(vec1(1,1:30));
[~,p2] = min(vec2(1,1:30));
[~,p3] = min(vec3(2,1:30));

pmin = min([p1,p2,p3]);
tstart1 = 1+p1-pmin;
tstart2 = 1+p2-pmin;
tstart3 = 1+p3-pmin;
nFrame = min([nt1-tstart1, nt2-tstart2, nt3-tstart3]);

vec1 = vec1(:,tstart1:tstart1+nFrame-1);
vec2 = vec2(:,tstart2:tstart2+nFrame-1);
vec3 = vec3(:,tstart3:tstart3+nFrame-1);

% vec1 = vec1(:,p1:p1+200);
% vec2 = vec2(:,p2:p2+200);
% vec3 = vec3(:,p3:p3+200);

end

