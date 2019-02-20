%% Load frames

close all; clear all; clc;

[frames1_1,nx,ny,nt1_1] = load_frames('cam1_1.mat');
[frames2_1,~,~,nt2_1] = load_frames('cam2_1.mat');
[frames3_1,~,~,nt3_1] = load_frames('cam3_1.mat');

[frames1_2,~,~,nt1_2] = load_frames('cam1_2.mat');
[frames2_2,~,~,nt2_2] = load_frames('cam2_2.mat');
[frames3_2,~,~,nt3_2] = load_frames('cam3_2.mat');

[frames1_3,~,~,nt1_3] = load_frames('cam1_3.mat');
[frames2_3,~,~,nt2_3] = load_frames('cam2_3.mat');
[frames3_3,~,~,nt3_3] = load_frames('cam3_3.mat');

[frames1_4,~,~,nt1_4] = load_frames('cam1_4.mat');
[frames2_4,~,~,nt2_4] = load_frames('cam2_4.mat');
[frames3_4,~,~,nt3_4] = load_frames('cam3_4.mat');

%% Play video

play_video('cam2_4.mat')

%% Plot selected frame

[~,xx] = max(frames2_4(340,305,:));

figure(1)
surf(frames2_3(:,:,xx)); colormap('gray'); shading flat; colorbar;

%% 
%%%%%%%%%%%%%%%%%%% Part 1 %%%%%%%%%%%%%%%%%%%%%

close all;

% obtain the trajectory separately from three cameras
pos1_1 = track_mass(frames1_1,nt1_1,200,400,200,350,250,1212);
pos2_1 = track_mass(frames2_1,nt2_1,1,nx,200,400,250,1212);
pos3_1 = track_mass(frames3_1,nt3_1,200,nx,200,ny,245,1212);

plot_trajectory(pos1_1, pos2_1, pos3_1,1,nx,1,ny)

% PCA

[u,s,v] = pca(pos1_1, pos2_1, pos3_1);
Y = u*s; % produce the principle components

% Plot results
figure

subplot(1,3,1)
energies = max(s,[],1);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')
title('Percentage of energies')

subplot(1,3,2)
plot(Y(:,1),'r'); hold on;
plot(Y(:,2),'b'); hold on;
plot(Y(:,3),'g');
axis([0 length(pos_new1) -150 150])
legend('1st','2nd','3rd')
title('Top 3 principle components')

subplot(1,3,3)
plot(Y(:,4),'k'); hold on;
plot(Y(:,5),'c'); hold on;
plot(Y(:,6),'m');
axis([0 length(pos_new1) -150 150])
legend('4th','5th','6th')
title('Last 3 principle components')

% Reconstruct trajectories
s(:,2:6) = 0;
X_new = u*s*v';

pos_new1 = X_new(:,1:2)';
pos_new2 = X_new(:,3:4)';
pos_new3 = X_new(:,5:6)';

plot_trajectory(pos_new1, pos_new2, pos_new3,-240,240,-320,320)

%% 
%%%%%%%%%%%%%%%%%%% Part 2 %%%%%%%%%%%%%%%%%%%%%

% obtain the trajectory separately from three cameras
pos1_2 = track_mass(frames1_2,nt1_2,200,nx,300,400,240,2112);
pos2_2 = track_mass(frames2_2,nt2_2,1,nx,180,400,248,2112);
pos3_2 = track_mass(frames3_2,nt3_2,200,350,250,500,230,-2112);

plot_trajectory(pos1_2, pos2_2, pos3_2,1,nx,1,ny)

% PCA

[u,s,v] = pca(pos1_2, pos2_2, pos3_2);
Y = u*s; % produce the principle components

% Plot results
figure

subplot(1,3,1)
energies = max(s,[],1);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')
title('Percentage of energies')

subplot(1,3,2)
plot(Y(:,1),'r'); hold on;
plot(Y(:,2),'b'); hold on;
plot(Y(:,3),'g');
axis([0 length(pos_new1) -150 150])
legend('1st','2nd','3rd')
title('Top 3 principle components')

subplot(1,3,3)
plot(Y(:,4),'k'); hold on;
plot(Y(:,5),'c'); hold on;
plot(Y(:,6),'m');
axis([0 length(pos_new1) -150 150])
legend('4th','5th','6th')
title('Last 3 principle components')

% Reconstruct trajectories
s(:,2:6) = 0;
X_new = u*s*v';

pos_new1 = X_new(:,1:2)';
pos_new2 = X_new(:,3:4)';
pos_new3 = X_new(:,5:6)';

plot_trajectory(pos_new1, pos_new2, pos_new3,-240,240,-320,320)


%%
%%%%%%%%%%%%%%%%%%% Part 3 %%%%%%%%%%%%%%%%%%%%%
% obtain the trajectory separately from three cameras

close all;

pos1_3 = track_mass(frames1_3,nt1_3,230,430,280,400,250,2112);
pos2_3 = track_mass(frames2_3,nt2_3,150,nx,200,450,245,2112);
pos3_3 = track_mass(frames3_3,nt3_3,150,350,250,500,245,-2112);

plot_trajectory(pos1_3, pos2_3, pos3_3,1,nx,1,ny)

% PCA

[u,s,v] = pca(pos1_3, pos2_3, pos3_3);
Y = u*s; % produce the principle components

% Plot results
figure

subplot(1,3,1)
energies = max(s,[],1);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')
title('Percentage of energies')

subplot(1,3,2)
plot(Y(:,1),'r'); hold on;
plot(Y(:,2),'b'); hold on;
plot(Y(:,3),'g');
axis([0 length(pos_new1) -150 150])
legend('1st','2nd','3rd')
title('Top 3 principle components')

subplot(1,3,3)
plot(Y(:,4),'k'); hold on;
plot(Y(:,5),'c'); hold on;
plot(Y(:,6),'m');
axis([0 length(pos_new3) -150 150])
legend('4th','5th','6th')
title('Last 3 principle components')

% Reconstruct trajectories
s(:,4:6) = 0;
X_new = u*s*v';

pos_new1 = X_new(:,1:2)';
pos_new2 = X_new(:,3:4)';
pos_new3 = X_new(:,5:6)';

plot_trajectory(pos_new1, pos_new2, pos_new3,-240,240,-320,320)


%%
%%%%%%%%%%%%%%%%%%% Part 4 %%%%%%%%%%%%%%%%%%%%%

close all

% obtain the trajectory separately from three cameras
pos1_4 = track_mass(frames1_4,nt1_4,200,400,300,420,230,2112);
pos2_4 = track_mass(frames2_4,nt2_4,150,380,200,400,245,2112);
pos3_4 = track_mass(frames3_4,nt3_4,100,250,250,550,220,-2112);

plot_trajectory(pos1_4, pos2_4, pos3_4,1,nx,1,ny)

% PCA

[u,s,v] = pca(pos1_4, pos2_4, pos3_4);
Y = u*s; % produce the principle components

% Plot results
figure

subplot(1,3,1)
energies = max(s,[],1);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')
title('Percentage of energies')

subplot(1,3,2)
plot(Y(:,1),'r'); hold on;
plot(Y(:,2),'b'); hold on;
plot(Y(:,3),'g');
axis([0 length(pos_new1) -150 150])
legend('1st','2nd','3rd')
title('Top 3 principle components')

subplot(1,3,3)
plot(Y(:,4),'k'); hold on;
plot(Y(:,5),'c'); hold on;
plot(Y(:,6),'m');
axis([0 length(pos_new3) -150 150])
legend('4th','5th','6th')
title('Last 3 principle components')

% Reconstruct trajectories
s(:,4:6) = 0;
X_new = u*s*v';

pos_new1 = X_new(:,1:2)';
pos_new2 = X_new(:,3:4)';
pos_new3 = X_new(:,5:6)';

plot_trajectory(pos_new1, pos_new2, pos_new3,-240,240,-320,320)

%%

for j =1:314
    a = frames1_1(:,:,j);
    b = a(200:350,250:500)>230;
    imshow(b)
end

mean

