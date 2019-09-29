function [mat] = accuracy_mat(predict, label, class)
    % return the accuray matrix between predict and label
    mat = zeros(length(class), length(class));

    vtruth = predict==label;
    
    for j = 1:length(predict)
        if vtruth(j) == 1
            i = find(class==predict(j));
            mat(i, i) = mat(i, i) + 1; 
        else
            i1 = find(class==predict(j));
            i2 = find(class==label(j));
            mat(i1, i2) = mat(i1, i2) + 1; 
        end
    end
end

