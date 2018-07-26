function [ res ] = get_diagram( samples, eps )

if nargin<2
    eps=0;
end

if isNull(samples)
    res = libpointer('doublePtrPtr', []);
    return;
end

s = get(samples, 'Value');
[n,~] = size(s);

if n < 2
    res = libpointer('doublePtrPtr', []);
    return;
end

increasing = 1;
N = 2;
criticalpoints(1,:) = [-Inf,-Inf];
for i=1:n-1
    if increasing == (s(i,2)>s(i+1,2))
        increasing = ~increasing;
        criticalpoints(N,:) = s(i,:);
        N = N+1;
    end
end
if s(n-1,2) > s(n,2)
    criticalpoints(N,:) = s(n,:);
    N = N+1;
end

n = N-1;


diag=[];
while n>1
    [~, arg] = min(criticalpoints(2:2:n,2));
    if criticalpoints(2*arg-1,2) > criticalpoints(2*arg+1,2)
        if criticalpoints(2*arg,2) > (criticalpoints(2*arg-1,2) + eps)
            diag(end+1,:) = [criticalpoints(2*arg-1,:), criticalpoints(2*arg,:)];
        end
        criticalpoints(2*arg,:)=[];
        criticalpoints(2*arg-1,:)=[];
    else
        if criticalpoints(2*arg,2) > (criticalpoints(2*arg+1,2) + eps)
            diag(end+1,:) = [criticalpoints(2*arg+1,:), criticalpoints(2*arg,:)];
        end
        criticalpoints(2*arg+1,:)=[];
        criticalpoints(2*arg,:)=[];
    end
    [n,~] = size(criticalpoints);
end
res = libpointer('doublePtrPtr',diag);

end

