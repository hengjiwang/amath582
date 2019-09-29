function [trainingset] = construct_data(num, song, len, Fs, npc, tclip)
% construct training set from a song using boostrap
    trainingset = [];
    for j = 1:num
        feature = [];
        pstart = unidrnd(len-tclip*Fs);
        pend = pstart + tclip*Fs;
        clip = song(pstart:pend);
        [spec_clip] = spectrogram(clip,gausswin(5000),...
           2000,[],Fs);
        
        [u,s,v] = svd(spec_clip,'econ');
        for j = 1:npc
            feature = [feature;u(1:1000,j)];
        end
        trainingset = [trainingset, feature]; 
    end
end


