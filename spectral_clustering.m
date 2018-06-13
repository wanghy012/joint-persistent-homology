function [ index ] = spectral_clustering( L, k )
%k-spectral clustering on graph laplacian L

[n,~] = size(L);
[eigvec,eigv]=eig(L);
eigval = real(diag(eigv));
[~, idx] = sort(eigval);
kvec = zeros(n,k);
for i = 1:k
    kvec(:,i) = real(eigvec(:,idx(i)));
end

index = kmeans(kvec, k);
clear idx eigvec eigv eigval L kvec;
end

