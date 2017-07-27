function [ initCentroids ] = initKMeans(X, K)
%initKMeans Return k x n matrix of initial cluster centroids, where each of k
%           rows is a cluster centroid transpose, and n is the dimension of
%           each training example. k < m = number of training examples.

randInd= randperm(size(X,1)).';
initCentroids= X(randInd(1:K),:);

end

