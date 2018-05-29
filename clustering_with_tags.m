function [ index ] = clustering_with_tags( feats, tag, k )
% cluster feats with tags. Every row of feats is a point. tag(i) is the tag
% for i-th point. k(i) is the number of clusters for tag i.
[n,~] = size(k);
[m,~] = size(feats);
C=0;
index = zeros(m,1);
for i = 1:n 
    %for each tag i, collect the features with this tag
    N=1;
    for j = 1:m
        if tag(j) == i
            feat(N,:) = feats(j,:);
            t(N) = j;
            N = N+1;
        end
    end
    
    %divide feat into k(i) clusters and add the result to the output
    res = spectral_clustering(feat, k(i));
    for j = 1:N-1
        index(t(j)) = res(j)+C;
    end
    C = C+k(i);
    
    clear feat t;
end

