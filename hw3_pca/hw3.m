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
surf(frames2_4(:,:,xx)); colormap('gray'); shading flat; colorbar;

%% 
%%%%%%%%%%%%%%%%%%% Part 1 %%%%%%%%%%%%%%%%%%%%%

% obtain the trajectory separately from three cameras
pos1_1 = track_mass(frames1_1,nt1_1,200,400,200,350,250);
pos2_1 = track_mass(frames2_1,nt2_1,1,nx,200,400,250);
pos3_1 = track_mass(frames3_1,nt3_1,200,nx,200,ny,245);

plot_trajectory(pos1_1, pos2_1, pos3_1,nx,ny)

% PCA

[u,s,v] = pca(pos1_1, pos2_1, pos3_1);
Y = s*v'; % produce the principle components

% Plot results
figure
energies = max(s,[],2);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')

figure
plot(Y(1,:),'r'); hold on;
plot(Y(2,:),'g'); hold on;
plot(Y(3,:),'b')
legend('1st','2nd','3rd')
title('Top 3 principle components')

%% 
%%%%%%%%%%%%%%%%%%% Part 2 %%%%%%%%%%%%%%%%%%%%%

% obtain the trajectory separately from three cameras
pos1_2 = track_mass(frames1_2,nt1_2,200,nx,300,ny,250);
pos2_2 = track_mass(frames2_2,nt2_2,1,nx,237,500,248);
pos3_2 = track_mass(frames3_2,nt3_2,200,350,250,500,245);

plot_trajectory(pos1_2, pos2_2, pos3_2,nx,ny)

% PCA

[u,s,v] = pca(pos1_2, pos2_2, pos3_2);
Y = s*v'; % produce the principle components

% Plot results
figure
energies = max(s,[],2);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')

figure
plot(Y(1,:),'r'); hold on;
plot(Y(2,:),'g'); hold on;
plot(Y(3,:),'b'); 
%legend('1st','2nd','3rd')
title('Top 3 principle components')

%%
%%%%%%%%%%%%%%%%%%% Part 3 %%%%%%%%%%%%%%%%%%%%%
% obtain the trajectory separately from three cameras
pos1_3 = track_mass(frames1_3,nt1_3,200,400,200,400,250);
pos2_3 = track_mass(frames2_3,nt2_3,150,nx,250,450,251);
pos3_3 = track_mass(frames3_3,nt3_3,150,350,250,500,245);

plot_trajectory(pos1_3, pos2_3, pos3_3,nx,ny)

% PCA

[u,s,v] = pca(pos1_3, pos2_3, pos3_3,'lowpass');
Y = s*v'; % produce the principle components

% Plot results
figure
energies = max(s,[],2);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')

figure
plot(Y(1,:),'r'); hold on;
plot(Y(2,:),'g'); hold on;
plot(Y(3,:),'b')
legend('1st','2nd','3rd')
title('Top 3 principle components')

%%
%%%%%%%%%%%%%%%%%%% Part 4 %%%%%%%%%%%%%%%%%%%%%
% obtain the trajectory separately from three cameras
pos1_4 = track_mass(frames1_4,nt1_4,200,400,300,420,245);
pos2_4 = track_mass(frames2_4,nt2_4,150,350,200,340,240);
pos3_4 = track_mass(frames3_4,nt3_4,100,250,250,550,230);

plot_trajectory(pos1_4, pos2_4, pos3_4,nx,ny)

% PCA

[u,s,v] = pca(pos1_4, pos2_4, pos3_4,'lowpass');
Y = s*v'; % produce the principle components

% Plot results
figure
energies = max(s,[],2);
plot(energies/sum(energies), 'ro--')
ylabel('% of energy')

figure
plot(Y(1,:),'r'); hold on;
plot(Y(2,:),'g'); hold on;
plot(Y(3,:),'b')
legend('1st','2nd','3rd')
title('Top 3 principle components')

%%

for j =1:314
    a = frames1_2(:,:,j);
    b = a(200:nx,300:ny)>250;
    imshow(b)
end



