clear all;
k = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generate functions and their features
D=0;
N=1;
for i=1:0
    [s,loc,val] = gen_function();
    feat = get_features(s, loc, val, 0.2);
    [n,~] = size(feat);
    npairs(N) = n;
    N=N+1;
    feats(D+1:D+n,:) = feat;
    D = D + n;
end

for i=1:5
    for j=1:20
        [s,loc,val] = gen_function();
        val(2*i) = val(2*i) -2;
        feat = get_features(s, loc, val, 0.2);
        [n,~] = size(feat);
        npairs(N)=n;
        N=N+1;
        feats(D+1:D+n,:) = feat;
        D = D + n;
    end
end
clear s loc val feat;

%clustering
[idx,pairs,cmin,cmax] = cluster_all_pairs(npairs, feats, k);

for i=1:k^2
    cmin(i,i)=0;
    cmax(i,i)=0;
end
W=cmin;
D = diag(sum(W));
L =D^(-.5)*(D-W)*D^(-.5);
idx_min = spectral_clustering(L,5);
W=cmax;
D = diag(sum(W));
L =D^(-.5)*(D-W)*D^(-.5);
idx_max = spectral_clustering(L,5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testing
avgdiff = zeros(5,5);
count = zeros(5,5);
[N,~] = size(idx);
for i=1:N
    x = idx_min(idx(i));
    y = idx_max(idx(i));
    avgdiff(x,y) = avgdiff(x,y)+pairs(i,4)-pairs(i,2);
    count(x,y) = count(x,y)+1;
end
avgdiff = avgdiff./count;
    
        


       