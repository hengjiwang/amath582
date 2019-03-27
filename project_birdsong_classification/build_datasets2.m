function [training, genuses_train, testing, genuses_test] = ...
    build_datasets2(path, list, nfile, meta, time_clip, npick)
    % build datasets for the second case
    
    train_set = [];
    test_set = [];
    genuses_train = [];
    genuses_test = [];
    count_cnames = []; 
    cnames_train = [];
    cnames_test = [];

    h=waitbar(0,'please wait...');
    for k = 3:nfile
        name = list(k).name;
        song = audioread(strcat(path,name));
        info = audioinfo(strcat(path,name));
        Fs = info.SampleRate; 
        T = info.Duration;

        if T<time_clip
            continue
        end

        genus = meta.genus(index(name, meta)); 
        cname = meta.english_cname(index(name, meta));
        count_cnames = [count_cnames, cname]; 
        if sum(count_cnames==cname) < 3
            genuses_train = [genuses_train, repmat(genus, 1, npick)];
            cnames_train = [cnames_train, repmat(cname, 1, npick)];
            train = construct_data(npick, song, ...
                length(song), Fs, 2, time_clip);
            train_set = [train_set, train];
        else
            genuses_test = [genuses_test, repmat(genus, 1, npick)];
            cnames_test = [cnames_test, repmat(cname, 1, npick)];
            test = construct_data(npick, song, ...
                length(song), Fs, 2, time_clip);
            test_set = [test_set, test];
        end
        str=['building datasets...',num2str(k/nfile*100),'%'];
        waitbar(k/nfile,h, str)
    end
    delete(h)
     
    training = abs(train_set);
    testing = abs(test_set);

end

