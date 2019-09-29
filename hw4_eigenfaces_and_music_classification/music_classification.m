%% Load songs

close all; clear all; clc;

x1 = audioread('songs/rap1.wav');
x2 = audioread('songs/rap2.wav');
x3 = audioread('songs/rap3.wav');

y1 = audioread('songs/classical1.wav');
y2 = audioread('songs/classical2.wav');
y3 = audioread('songs/classical3.wav');

z1 = audioread('songs/folk1.wav');
z2 = audioread('songs/folk2.wav');
z3 = audioread('songs/folk3.wav');

x1info = audioinfo('songs/rap1.wav');

Fs = x1info.SampleRate;


x = [x1;x2;x3];
y = [y1;y2;y3];
z = [z1;z2;z3];

L_x = length(x);
L_y = length(y);
L_z = length(z);

clear x1 x2 x3 y1 y2 y3 z1 z2 z3 x1info;

%% Construct training dataset

ntrain = 800;
ntest = 200;
npc = 2;

acc_lda = [];
acc_cnb = [];
acc_ctree = [];

hwait=waitbar(0,'please wait...');

for kk = 1:5

    testind = unidrnd(floor(0.8*L_x));

    % separate a frytion for extryting training data
    x_tr = x([1:testind-1, testind+ceil(0.2*L_x):end]);
    y_tr = y([1:testind-1, testind+ceil(0.2*L_y):end]);
    z_tr = z([1:testind-1, testind+ceil(0.2*L_z):end]);

    % separate a frytion for extryting test data
    x_te = x([testind:testind+floor(0.2*L_x)]);
    y_te = y([testind:testind+floor(0.2*L_y)]);
    z_te = z([testind:testind+floor(0.2*L_z)]);

    % extryt training data
    x_train = bootstrap_construct(ntrain, x_tr, length(x_tr), Fs, npc);
    y_train = bootstrap_construct(ntrain, y_tr, length(y_tr), Fs, npc);
    z_train = bootstrap_construct(ntrain,z_tr, length(z_tr), Fs, npc);

%     %% Plot clips
% 
%     clipind = 1000000;
% 
%     figure(1)
%     subplot(3,1,1)
%     plot(0:1/Fs:5,z(clipind:clipind+5*Fs))
%     title('z')
%     subplot(3,1,2)
%     plot(0:1/Fs:5,x(clipind:clipind+5*Fs))
%     title('x')
%     subplot(3,1,3)
%     plot(0:1/Fs:5,y(clipind:clipind+5*Fs))
%     title('y')

    % %% Constructions

    % Construct labels

    labels = [ones(ntrain,1);2*ones(ntrain,1);3*ones(ntrain,1)];

    % Construct total training dataset

    training = abs([x_train';y_train';z_train']);

    % Construct test dataset

    test_labels = [ones(ntest,1);2*ones(ntest,1);3*ones(ntest,1)];

    x_test = bootstrap_construct(ntest, x_te, length(x_te), Fs, npc);
    y_test = bootstrap_construct(ntest, y_te, length(y_te), Fs, npc);
    z_test = bootstrap_construct(ntest, z_te, length(z_te), Fs, npc);

    sample = abs([x_test';y_test';z_test']);

    % %% Classification

    class = classify(sample, training, labels);
    accuracy = sum(class==test_labels)/length(class);

    Mdl_ctree = fitctree(training, labels);
    class_ctree = predict(Mdl_ctree, sample);
    accuracy_ctree = sum(class_ctree==test_labels)/length(class);

    Mdl_cnb = fitcnb(training, labels);
    class_cnb = predict(Mdl_cnb, sample);
    accuracy_cnb = sum(class_cnb==test_labels)/length(class);
    
    acc_lda = [acc_lda; accuracy];
    acc_ctree = [acc_ctree; accuracy_ctree];
    acc_cnb = [acc_cnb; accuracy_cnb];
    
    waitbar(kk/5,hwait,'running...');
end    
    
close(hwait);

%%

figure(5)
plot(acc_lda(1:5), 'ro-');
hold on;
plot(acc_ctree(1:5), 'bo-');
hold on;
plot(acc_cnb(1:5), 'go-');
ylim([0 1])
legend({'LDA','Binary Tree', 'Naive Bayes'},'Location','southeast');
xlabel('experiment')
ylabel('accuracy')
title('Test 3')


%%

figure

subplot(1,3,1)
pstart = 100000;
pend = pstart + 5*Fs;
clip = x(pstart:pend);
spectrogram(clip,gausswin(500),200,[],Fs,'yaxis');
title('rap')


subplot(1,3,2)
pstart = 100000;
pend = pstart + 5*Fs;
clip = y(pstart:pend);
spectrogram(clip,gausswin(500),200,[],Fs,'yaxis');
title('classical')


subplot(1,3,3)
pstart = 100000;
pend = pstart + 5*Fs;
clip = z(pstart:pend);
spectrogram(clip,gausswin(500),200,[],Fs,'yaxis');
title('folk')

