function [ seq, p ] = bubble_sort( seq )
% this function takes seq as input and output the sorted sequence as well
% as the permutation.

[n,~] = size(seq);
p = zeros(n,1);
for i=1:1:n
    p(i) = i;
end
for i=1:1:n
    for j=1:1:(n-i)
        if seq(j)>seq(j+1)
            t = seq(j);
            seq(j) = seq(j+1);
            seq(j+1) = t;
            t = p(j);
            p(j) = p(j+1);
            p(j+1) = t;
        end
    end
end
end

