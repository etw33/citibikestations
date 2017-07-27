function [ cost ] = computeCost(X, centroids, ind)
%computeCost Computes the cost of when the examples in X are assigned to 
%the cluster centroids in centroids as described by vector ind.

cost= 0;
for i=1:size(X,1)
    cost= cost + sum((X(i,:).' - centroids(ind(i),:).').^2);
end
cost= cost/size(X,1);

end

