function [] = plot_trajectory(pos1,pos2,pos3,mx,nx,my,ny)
% plot the trajectories of the mass recorded by the three cameras 

figure
subplot(1,3,1)
plot(pos1(1,:),pos1(2,:), '.-');
axis([mx nx my ny]);
xlabel('X'); ylabel('Y');
title('Trajectory by camera 1')

subplot(1,3,2)
plot(pos2(1,:),pos2(2,:),'.-');
axis([mx nx my ny]);
xlabel('X'); ylabel('Y');
title('Trajectory by camera 2')

subplot(1,3,3)
plot(pos3(1,:),pos3(2,:),'.-');
axis([mx nx my ny]);
xlabel('X'); ylabel('Y');
title('Trajectory by camera 3')

end

