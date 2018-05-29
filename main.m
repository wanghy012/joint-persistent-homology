clear all;

N=1000;%number of functions
k=[2;3];%number of clusters for each tag


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C=0;
for i=1:N
    [~,loc,val] = gen_function();
    [feat, tag] = get_features2(loc, val);
    [n,m] = size(feat);
    feats(C+1:C+n,:) = feat;
    tags(C+1:C+n,:) = tag;
    C = C+n;
    clear feat tag loc val;
end
idx = clustering_with_tags(feats(:,1), tags, k);
num = zeros(5,1);
sum = zeros(5,m);
for i = 1:C
    num(idx(i)) = num(idx(i))+1;
    sum(idx(i),:) = sum(idx(i),:) + feats(i,:);
end
avg = sum./repmat(num,1,m) %the average of each feature after clustering
       