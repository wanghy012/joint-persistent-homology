function [ idx, pairs, cmin, cmax ] = cluster_all_pairs(npairs, feats, k)
% input: npairs(i) is the number of pairs in the i-th function. feats is the
% collections of all persistent pairs from each the functions. k is the
% number of pairs.

%output: pairs is all the pairs from each function, and idx gives the clustering
%result. cmin and cmax gives the connection between clusters through 
%common local minimum/maximum.

%first generate all pairs
N = max(size(npairs));
pairs = zeros(sum(npairs.*npairs),4);
C=1;
D=0;
for a=1:N
    n=npairs(a);
    for i=1:n
        for j=1:n
            pairs(C,:) = [feats(D+i,1:2), feats(D+j,3:4)];
            C=C+1;
        end
    end
    D = D+n;
end

%clustering
[n,~] = size(pairs);
W = zeros(n,n);
dist = zeros(n,n);
for i = 1:n
    for j = 1:i-1
        dist(i,j) = sum(abs(pairs(i,[1,3])-pairs(j,[1,3])));
        dist(j,i) = dist(i,j);
    end
end
N = round(n/k^2);
for i=1:n
    [~,p] = sort(dist(i,:));
    W(i,p(1:N)) = 1;
    W(p(1:N),i) = 1;
    clear p;
end
D = diag(sum(W));
L =D^(-.5)*(D-W)*D^(-.5);
idx = spectral_clustering(L, k^2);
  
%get cmin, cmax
cmin=zeros(k^2,k^2);
cmax=zeros(k^2,k^2);

D=0;
N = max(size(npairs));
for i=1:N
    n = npairs(i);
    for j=1:n
        t = idx(D+(j-1)*n+1:D+j*n);
        cmin(t,t) = cmin(t,t)+1;
        clear t;
        t = idx(D+j:n:D+n*(n-1)+j);
        cmax(t,t) = cmax(t,t)+1;
        clear t;
    end
    D = D+n^2;
end

end

