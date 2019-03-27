%% Load songs

close all; clear all; clc;

path = ['./british-birdsong-dataset/songs/'];
list = dir(fullfile(path));

nfile = size(list,1) - 2;

meta = importfile(['./british-birdsong-dataset/birdsong_metadata.csv']);

%% Build datasets

time_clips = [10, 20, 30]; 
accuracy_cnbs = [];
accuracy_knns = [];
accuracy_rfs = [];

% time_clip = 20;

g=waitbar(0,'looping timeclips...');
ii = 0;
for time_clip = time_clips
    npick = 10;

    [training, genuses_train, testing, genuses_test] = ...
        build_datasets1(path, list, nfile, meta, time_clip, npick);

    % Classification

    % Naive Bayes
    Mdl_cnb = fitcnb(training', genuses_train');
    class_cnb = predict(Mdl_cnb, testing');
    accuracy_cnb = sum(class_cnb==genuses_test')/length(class_cnb);

    % Random Forests
    Mdl_rf = TreeBagger(200, training', genuses_train');
    class_rf = predict(Mdl_rf, testing');

    vtruth_rf = class_rf==genuses_test';
    accuracy_rf = sum(vtruth_rf)/length(class_rf);

    % KNN
    Mdl_knn = fitcknn(training', genuses_train');
    class_knn = predict(Mdl_knn, testing');

    vtruth_knn = class_knn==genuses_test';
    accuracy_knn = sum(vtruth_knn)/length(class_knn);

    accuracy_cnbs = [accuracy_cnbs; accuracy_cnb];
    accuracy_knns = [accuracy_knns; accuracy_knn];
    accuracy_rfs = [accuracy_rfs; accuracy_rf];
    
    ii = ii+1;
    str=['looping timeclips...',num2str(ii/length(time_clips)*100),'%'];
    waitbar(ii/length(time_clips), g, str)
end
delete(g)
%% Accuray matrix

list_genus = unique([genuses_train, genuses_test]);

count_genus_tr = count_function(list_genus, genuses_train);
count_genus_te = count_function(list_genus, genuses_test);

macc_knn_tr = accuracy_mat(predict(Mdl_knn, training'), ...
    genuses_train', list_genus);
macc_knn_te = accuracy_mat(class_knn, genuses_test', list_genus);

macc_rf_tr = accuracy_mat(predict(Mdl_rf, training'), ...
    genuses_train', list_genus);
macc_rf_te = accuracy_mat(class_rf, genuses_test', list_genus);

macc_cnb_tr = accuracy_mat(predict(Mdl_cnb, training'), ...
    genuses_train', list_genus);
macc_cnb_te = accuracy_mat(class_cnb, genuses_test', list_genus);

for j = 1:length(macc_knn_tr)
    macc_knn_tr(:,j) = macc_knn_tr(:,j)/count_genus_tr(j);
    macc_rf_tr(:,j) = macc_rf_tr(:,j)/count_genus_tr(j);
    macc_cnb_tr(:,j) = macc_cnb_tr(:,j)/count_genus_tr(j);
end

for j = 1:length(macc_knn_tr)
    macc_knn_te(:,j) = macc_knn_te(:,j)/count_genus_te(j);
    macc_rf_te(:,j) = macc_rf_te(:,j)/count_genus_te(j);
    macc_cnb_te(:,j) = macc_cnb_te(:,j)/count_genus_te(j);
end

%% Plot results
figure()

subplot(2,3,1)
imagesc(macc_cnb_tr);


title('training')
subplot(2,3,4)
imagesc(macc_cnb_te);
title('test')


subplot(2,3,2)
imagesc(macc_knn_tr);
title('training')
subplot(2,3,5)
imagesc(macc_knn_te);
title('test')

subplot(2,3,3)
imagesc(macc_rf_tr);
title('training')
subplot(2,3,6)
imagesc(macc_rf_te);
title('test')

%% Example spectrograms

figure()
subplot(331)
spectrogram(audioread(strcat(path,'xc82715.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Acrocephalus 1')
subplot(332)
spectrogram(audioread(strcat(path,'xc64685.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Acrocephalus 2')
subplot(333)
spectrogram(audioread(strcat(path,'xc64686.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Acrocephalus 3')

subplot(334)
spectrogram(audioread(strcat(path,'xc27145.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Corvus 1')
subplot(335)
spectrogram(audioread(strcat(path,'xc143170.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Corvus 2')
subplot(336)
spectrogram(audioread(strcat(path,'xc143002.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Corvus 3')

subplot(337)
spectrogram(audioread(strcat(path,'xc121168.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Turdus 1')
subplot(338)
spectrogram(audioread(strcat(path,'xc27962.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Turdus 2')
subplot(339)
spectrogram(audioread(strcat(path,'xc27962.flac')),gausswin(5000),2000,[],44100, 'yaxis');
title('Turdus 3')