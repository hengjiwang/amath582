function [counts] = count_function(keys,list)
    % returns the counts of keys in list
    counts = [];
    
    for key = keys
        count = length(find(list==key));
        counts = [counts; count];    
    end
end

