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

avg1 = sum(sum(feats(:,[1 3])))/2/D;
avg2 = sum(sum(feats(:,[2 4])))/2/D;


%clustering
[idx,pairs,idx_min,idx_max] = cluster_all_pairs(npairs, feats, k);

%%
count = zeros(2*k,2*k);
Ey2 = zeros(2*k,1);
Ey1 = zeros(2*k,1);
for i=1:k^2
    a = idx_min(i);
    b = idx_max(i) + 5;
    t = pairs(idx == i,:);
    t1 = median(t(:,3)-t(:,1));
    t2 = median(t(:,4)-t(:,2));
    count(a,b) = count(a,b)+1;
    Ey2(a) = Ey2(a)-t2;
    Ey2(b) = Ey2(b)+t2;
    Ey1(a) = Ey1(a)-t1;
    Ey1(b) = Ey1(b)+t1;
end
count = count + count';
D = diag(sum(count));
L=D-count;
x(:,2)=pinv(L)*Ey2 + avg2;
x(:,1)=pinv(L)*Ey1 + avg1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testing
% avgdiff = zeros(5,5);
% count = zeros(5,5);
% [N,~] = size(idx);
% for i=1:N
%     x = idx_min(idx(i));
%     y = idx_max(idx(i));
%     avgdiff(x,y) = avgdiff(x,y)+pairs(i,4)-pairs(i,2);
%     count(x,y) = count(x,y)+1;
% end
% avgdiff = avgdiff./count;
%     
%         


       