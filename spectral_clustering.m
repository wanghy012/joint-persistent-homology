function [ index ] = spectral_clustering( feats, k )
%Divide feats into k clusters using spectral-clustering. Every row of feats
%represent a point. 
[n,~] = size(feats);
W = zeros(n,n);
dist = zeros(n,n);
for i = 1:n
    for j = 1:i-1
        dist(i,j) = sum(abs(feats(i,:)-feats(j,:)));
        dist(j,i) = dist(i,j);
    end
end
N = round(n/k);
for i=1:n
    [~,p] = sort(dist(i,:));
    W(i,p(1:N)) = 1;
    W(p(1:N),i) = 1;
    clear p;
end
D = diag(sum(W));
L =D^(-.5)*(D-W)*D^(-.5);
[eigvec,eigv]=eig(L);
eigval = diag(eigv);
[~, idx] = sort(eigval);
kvec = zeros(n,k);
for i = 1:k
    kvec(:,i) = eigvec(:,idx(i));
end

index = kmeans(kvec, k);
clear idx eigvec eigv eigval D L kvec;
end

