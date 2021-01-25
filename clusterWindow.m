function [ P] = clusterWindow(C,w)
%clusterPlot(C,w) runs a window of size w along the data and
% calculates the percentage of the window containing each of the clusters
% so if the entire window is all from cluster 3, then cluster 3 will be 1.0
% 
%  C is a vector of length N which records the cluster number for each
%  sample
%  Plots is a vector of size N x k where k is the number of clusters
%  The ith row of plots gives the percentage of samples in the range
%  C(i-w/2:i+w/2) which have value j for each of the j clusters...
N = length(C);  % number of samples
K = max(C); % number of clusters
P = zeros(N,K);
P(1,C(1)) = 1;
for i=2:N
    P(i,:) = P(i-1,:);
    P(i,C(i)) = P(i,C(i))+1;
    if (i>w)
        P(i,C(i-w)) = P(i,C(i-w))-1;
    end
end

end

