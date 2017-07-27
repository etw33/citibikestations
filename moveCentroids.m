function [ centroids ] = moveCentroids(X, ind, K)
%moveCentroids Move cluster centroids to mean of examples assigned to them. k is
%the number of centroids.

centroids= zeros(K,size(X,2));

for i=1:K
    logicalInd= ind == i;
    centroids(i,:)= (1/sum(logicalInd) * sum(X(logicalInd,:)));
end

end

