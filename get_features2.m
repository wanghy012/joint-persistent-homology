function [ feat ] = get_features2( loc, val )

% the output of this function describes the stability of every local minimum/maximum.
% The stability is defined by the difference in values from the
% local minimum/maximum to its two neighboring local maximum/minimum. Every
% line of the output is in the form of
% [location value stability] of a local minimum/maximum.

[loc, p] = bubble_sort(loc);
n = size(val);
t = val;
for i = 1:n(1)
    val(i) = t(p(i));
end
clear p;

N = 2;
feat(1,:) = [loc(1), val(1), 0];

for i = 2:n(1)-1
    if (val(i)-val(i-1))*(val(i)-val(i+1)) > 0
        feat(N,:) = [loc(i), val(i), 0];
        N = N+1;
    end
end
 
feat(N,:) = [loc(n(1)), val(n(1)), 0];

feat(1,3) = abs(feat(1,2)-feat(2,2));
for i = 2:N-1
    feat(i,3) = min(abs(feat(i,2)-feat(i-1,2)), abs(feat(i,2)-feat(i+1,2)));
end
feat(N,3) = abs(feat(N-1,2) - feat(N,2));

end

