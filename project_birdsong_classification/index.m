function [ind] = index(name, list)
% return the index of a song in metadata
    ind = find(list.file_id==str2num(name(isstrprop(name,'digit'))));
end

