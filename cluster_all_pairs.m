function [ idx, pairs, cmin, cmax ] = cluster_all_pairs(npairs, feats, k)
% input: npairs(i) is the number of pairs in the i-th function. feats is the
% collections of all persistent pairs from each the functions. k is the
% number of clusters.

%output: pairs is all the pairs from each function, and idx gives the clustering
%result. cmin and cmax gives the connection between clusters through 
%common local minimum/maximum.

%first generate all pairs
N = max(size(npairs));
pairs = zeros(sum(npairs.*npairs),2);
C=1;
D=0;
for i=1:N
    n=npairs(i);
    for i=1:n
        for j=1:n
            pairs(C,:) = [D+i, D+j];
            C=C+1;
        end
    end
    D = D+n;
end
%clustering
idx = spectral_clustering([feats(pairs(:,1),1),feats(pairs(:,2),3)], k);
  
%get cmin, cmax
cmin=zeros(k,k);
cmax=zeros(k,k);

D=0;
for i=1:N
    n = npairs(i);
    for i=1:n
        t = idx(D+(i-1)*n+1:D+i*n);
        cmin(t,t) = cmin(t,t)+1;
        t = idx(D+i:n:D+n*(n-1)+i);
        cmax(t,t) = cmax(t,t)+1;
    end
    D = D+n^2;
end

end

