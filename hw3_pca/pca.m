function [u,s,v] = pca(pos1,pos2,pos3,LowPass)
% includes details of data analysis on the trajectories

% shift phase
[pos1,pos2,pos3] = shift_phase(pos1,pos2,pos3);

if nargin==3
    X = [pos1;pos2;pos3];
else
    % filter out noise in frequency domain
    x1f = fft(pos1(1,:)); x1f(10:end-10)=0;
    y1f = fft(pos1(2,:)); y1f(10:end-10)=0;
    x2f = fft(pos2(1,:)); x2f(10:end-10)=0;
    y2f = fft(pos2(2,:)); y2f(10:end-10)=0;
    x3f = fft(pos3(1,:)); x3f(10:end-10)=0;
    y3f = fft(pos3(2,:)); y3f(10:end-10)=0;

    pos1(1,:) = abs(ifft(x1f));
    pos1(2,:) = abs(ifft(y1f));
    pos2(1,:) = abs(ifft(x2f));
    pos2(2,:) = abs(ifft(y2f));
    pos3(1,:) = abs(ifft(x3f));
    pos3(2,:) = abs(ifft(y3f));

    % store all data with a 6-dimensional representation
    X = [pos1;pos2;pos3];
end
% demean data
[~,nY] = size(X);
M = repmat(mean(X,2),1,nY);
X = X - M;

% SVD
[u,s,v] = svd(X');
end

