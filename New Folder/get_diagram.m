function [ res ] = get_diagram( samples )

s = get(samples, 'Value');
[n,~] = size(s);

if n < 2
    res = libpointer('doublePtrPtr', []);
    return;
end

increasing = 1;
N = 2;
criticalpoints(1) = -Inf;
for i=1:n-1
    if increasing == (s(i,2)>s(i+1,2))
        increasing = ~increasing;
        criticalpoints(N) = s(i,2);
        N = N+1;
    end
end
if s(n-1,2) > s(n,2)
    criticalpoints(N) = s(n,2);
    N = N+1;
end

n = N-1;


M=1;
diag=[];
while n>1
    [~, arg] = min(criticalpoints(2:2:n));
    if criticalpoints(2*arg-1) > criticalpoints(2*arg+1)
        diag(M,:) = [criticalpoints(2*arg-1), criticalpoints(2*arg)];
        criticalpoints(2*arg)=[];
        criticalpoints(2*arg-1)=[];
        M = M+1;
    else
        diag(M,:) = [criticalpoints(2*arg+1), criticalpoints(2*arg)];
        criticalpoints(2*arg+1)=[];
        criticalpoints(2*arg)=[];
        M = M+1;
    end
    [~,n] = size(criticalpoints);
end
res = libpointer('doublePtrPtr',diag);

end

