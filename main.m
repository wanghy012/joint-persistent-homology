clear all;

k=25;%number of clusters
clear all;
k=25;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D=0;
N=1;
for i=1:0
    [s,loc,val] = gen_function();
    feat = get_features(s, loc, val);
    [n,~] = size(feat);
    npairs(N) = n;
    N=N+1;
    feats(D+1:D+n,:) = feat;
    D = D + n;
    clear feat s loc val;
end

for i=1:5
    for j=1:20
        [s,loc,val] = gen_function();
        val(2*i) = val(2*i) -2;
        feat = get_features(s, loc, val);
        [n,~] = size(feat);
        npairs(N)=n;
        N=N+1;
        feats(D+1:D+n,:) = feat;
        D = D + n;
    end
end

[idx,pairs,cmin,cmax] = cluster_all_pairs(npairs, feats, k);


        
        


       