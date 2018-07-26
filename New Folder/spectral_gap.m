function [ res, cluster, v1,v2 ] = spectral_gap( dsim )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

[n,~] = size(dsim);
L = zeros(n,n);
for i=1:n
    [~,idx] = sort(dsim(i,:));
    L(i,idx(1:round(n/3))) = 1;
    L(idx(1:round(n/3)),i) = 1;
    L(i,i) = 0;
end

D = diag(sum(L));
L = diag(ones(n,1)) - D^-1*L;
[eigvector,eigv]=eig(L);
eigval = diag(eigv);
[eigval, idx] = sort(eigval);
res = eigval;
v1 = eigvector(:,idx(1));
v2 = eigvector(:,idx(2));
cluster = kmeans(real(eigvector(:,idx(1:2))),2);
end

