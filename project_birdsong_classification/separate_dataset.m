function [X_tr, y_tr, X_te, y_te] = separate_dataset(X, y)
    % separate dataset to training and test parts
    
    L = (length(y));

    inds = randperm(L);

    X = X(:,inds);
    y = y(:,inds);

    X_tr = abs(X(:, 1:floor(0.8*L)));
    X_te = abs(X(:, ceil(0.8*L)+1:end));

    y_tr = y(1:floor(0.8*L));
    y_te = y(ceil(0.8*L)+1:end);
    
end

