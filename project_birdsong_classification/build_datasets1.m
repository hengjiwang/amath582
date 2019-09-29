function [training, genuses_train, testing, genuses_test] = ...
    build_datasets1(path, list, nfile, meta, time_clip, npick)

    % build training and test datasets for case 1
    
    data_set = [];
    genuses = [];
    
    % Feature extraction
    
    h=waitbar(0,'please wait');
    for k = 3:(nfile+2)
        name = list(k).name;
        song = audioread(strcat(path,name));
        info = audioinfo(strcat(path,name));
        Fs = info.SampleRate; 
        T = info.Duration;

        if T<time_clip
            continue
        end

        genus = meta.genus(index(name, meta)); 

        genuses = [genuses, repmat(genus, 1, npick)];
        data = construct_data(npick, song, length(song), Fs, 2, time_clip);
        data_set = [data_set, data];

        str=['building datasets...',num2str(k/nfile*100),'%'];
        waitbar(k/nfile,h, str)
    end
    delete(h)
    
    % Separate training and test datasets
    
    L = (length(genuses'));
    
    [training, genuses_train, testing, genuses_test] = ...
        separate_dataset(data_set, genuses);
    
end

