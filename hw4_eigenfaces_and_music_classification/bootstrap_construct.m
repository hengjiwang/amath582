function [trainingset] = bootstrap_construct(num, song, length, Fs, npc)
% construct training set from a song using boostrap
    trainingset = [];
    for j = 1:num
        feature = [];
        pstart = unidrnd(length-5*Fs);
        pend = pstart + 5*Fs;
        clip = song(pstart:pend);
        [spec_clip] = spectrogram(clip,gausswin(500),200,[],Fs);
        [u,s,v] = svd(spec_clip,'econ');
        % feature = reshape(spec_clip(1:50,:),[],1);
        for j = 1:npc
            feature = [feature;u(:,j)];
        end
        trainingset = [trainingset, feature]; 
    end
end

