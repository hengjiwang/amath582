%% Load songs

close all; clear all; clc;

jay = audioread('songs/jaychou.wav');
sword = audioread('songs/swordromance.wav');
zuying = audioread('songs/zuyingsong.wav');

jay = jay(:,1);
sword = sword(:,1);
zuying = zuying(:,1);

jayinfo = audioinfo('songs/jaychou.wav');
swordinfo = audioinfo('songs/swordromance.wav');
zuyinginfo = audioinfo('songs/zuyingsong.wav');

Fs = jayinfo.SampleRate;

T_jay = jayinfo.Duration;
T_sword = swordinfo.Duration;
T_zuying = zuyinginfo.Duration;

L_jay = jayinfo.TotalSamples;
L_sword = swordinfo.TotalSamples;
L_zuying = zuyinginfo.TotalSamples;

%% Construct training dataset

ntrain = 800;
ntest = 200;
npc = 10;

jay_train = boostrap_construct(ntrain, jay, L_jay, Fs, npc);
sword_train = boostrap_construct(ntrain, sword, L_sword, Fs, npc);
zuying_train = boostrap_construct(ntrain,zuying, L_zuying, Fs, npc);


%% Plot clips

clipind = 1000000;

figure(1)
subplot(3,1,1)
plot(0:1/Fs:5,zuying(clipind:clipind+5*Fs))
title('Zuying Song')
subplot(3,1,2)
plot(0:1/Fs:5,jay(clipind:clipind+5*Fs))
title('Jay Chou')
subplot(3,1,3)
plot(0:1/Fs:5,sword(clipind:clipind+5*Fs))
title('Swordsman''s Romance')

%% Construct labels
labels = zeros(3*ntrain,1);
labels(1:ntrain) = 1;
labels(ntrain:2*ntrain) = 2;
labels(2*ntrain:3*ntrain) = 3;

%% Construct total training dataset

training = abs([jay_train';sword_train';zuying_train']);

%% Construct test dataset

jay_test = boostrap_construct(ntest, jay, L_jay, Fs, npc);
sword_test = boostrap_construct(ntest, sword, L_sword, Fs, npc);
zuying_test = boostrap_construct(ntest, zuying, L_zuying, Fs, npc);

sample = abs([jay_test';sword_test';zuying_test']);

%% Classification

class = classify(sample, training, labels);


