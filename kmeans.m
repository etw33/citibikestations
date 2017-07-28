% Initial visualization. Each x represents a station
hold off;
am= X(:,9);
pm= X(:,18);
plot(am,pm,'x');
xlabel('Availability percentage 8-9am');
ylabel('Availability percentage 5-6pm');
%%
% Initialize variables (X is a variable already in the environment)
K= 3;
numIter= 100;
numRandomInits= 100;
optInd= zeros(size(X,1),1);
optCentroids= zeros(K, size(X,2));
minJ= intmax;
% Because K-means is susceptible to local optima, randomly initialize more
% than once
for i=1:numRandomInits
    ind= zeros(size(X,1),1);
    centroids= initKMeans(X,K);
    for j=1:numIter
        ind= assignToCentroids(X, centroids);
        centroids= moveCentroids(X,ind,K);
    end
    J= computeCost(X,centroids,ind);
    % If the cost is lower than the min cost so far, record indices and
    % centroids
    if J < minJ
        minJ= J;
        optCentroids= centroids;
        optInd= ind;
    end
end
%%
hold off;
%plot clusters
plot(am(optInd == 1),pm(optInd == 1),'bo');
hold on;
plot(am(optInd == 2),pm(optInd == 2),'gx');
plot(am(optInd == 3),pm(optInd == 3),'r+');
plot(optCentroids(:,9),optCentroids(:,18),'m*');
xlabel('Availability percentage 8-9am');
ylabel('Availability percentage 5-6pm');

%%
hold off;
%plot availability throughout day for each station (the number for cluster
%can take on 1, 2, or 3)
cluster= optInd == 3;
X_c= X(cluster,:);
figure;
for i=1:size(X_c,1)
   plot(X_c(i,:),'-');
   axis([0 25 0 1]);
   hold on;
end
xlabel('Hour of day');
ylabel('Availability percentage');
