function [ feat, tag ] = get_features2( loc, val )

% the output of this function describes the stability of every local minimum/maximum.
% The stability is defined by the difference in values from the
% local minimum/maximum to its two neighboring local maximum/minimum. Each
% row of the output is in the form of
% [location value stability] of a local minimum/maximum. The tag is 1
% when its a local minimum, and 2 when its a local maximum.

[loc, idx] = sort(loc);
n = size(val);
val = val(idx);

clear p;

%get the location and value of each local minimum/maximum
N = 1;
feat(N,:) = [loc(1), val(1), 0];
N = N+1;
for i = 2:n(1)-1
    if (val(i) > val(i-1)) == (val(i) >= val(i+1))
        feat(N,:) = [loc(i), val(i), 0];
        N = N+1;
    end
end
feat(N,:) = [loc(n(1)), val(n(1)), 0];

%get the stability and tag of each local minimum/maximum
if feat(1,2) >= feat(2,2)
    feat(1,3) = feat(1,2)-feat(2,2);
    t = 2;
    tag(1,1) = t;
else
    feat(1,3) = feat(2,2)-feat(1,2);
    t = 1;
    tag(1,1) = t;
end
for i = 2:N-1
    t = 3-t;
    feat(i,3) = min(abs(feat(i,2)-feat(i-1,2)), abs(feat(i,2)-feat(i+1,2)));
    tag(i,1) = t;
end
feat(N,3) = abs(feat(N,2)-feat(N-1,2));
tag(N,1) = 3-t;











