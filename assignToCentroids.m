function [ ind ] = assignToCentroids(X, centroids)
%assignToCentroids Assign each example in X to the closest cluster
%centroid, return a vector of the indices describing the assignments

m= size(X,1);
ind= zeros(m,1);

for i=1:m
    squaredDist= sum((X(i,:).' - centroids.').^2);
    [~, I]= min(squaredDist);
    ind(i)= I;
end


end

