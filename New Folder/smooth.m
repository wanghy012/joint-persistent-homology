function res = smooth( sample, k )
%make sampled function k-lipchitz continuous
s = get(sample, 'Value');
n = size(s,1);
cvx_begin quiet
    variable x(n,1)
    minimize( norm( x - s(:,2), 2 ) )
    subject to
        abs(x(1:n-1,1)-x(2:n,1)) <= k*abs(s(1:n-1,1)-s(2:n,1))
cvx_end
res = libpointer('doublePtrPtr',[s(:,1),x]);
end

