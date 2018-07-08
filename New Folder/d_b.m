function [ res ] = d_b( diag1, diag2 )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

if isNull(diag1)
    d1 = [];
else
    d1 = get(diag1, 'Value');
end
if isNull(diag2)
    d2 = [];
else
    d2 = get(diag2, 'Value');
end

[n1,~] = size(d1);
[n2,~] = size(d2);

if n1+n2 == 0
    res = 0;
    return;
end

N=1;
for i=1:n1
    for j=1:n2
        dist(N,:) = [sqrt(sum((d1(i,:)-d2(j,:)).^2)), i, j];
        N = N+1;
    end
end
for i=1:n1
    dist(N,:) = [(d1(i,2) - d1(i,1))/sqrt(2), i, 0];
    N = N+1;
end
for i=1:n2
    dist(N,:) = [(d2(i,2) - d2(i,1))/sqrt(2), 0, i];
    N=N+1;
end

[~, idx] = sort(dist(:,1));

C = zeros(n1+n2, n1+n2);
l_b = 1;
u_b = N-1;
while(l_b<u_b)
    C = zeros(n1+n2, n1+n2);
    t = round((l_b+u_b)/2) - 1;
    for i=1:t
        if dist(idx(i),2)>0 && dist(idx(i),3)>0
            C(dist(idx(i),2), dist(idx(i),3)) = 2;
            continue;
        end
        if dist(idx(i),2)==0
            C(n1 + dist(idx(i),3), dist(idx(i),3)) = 1;
            continue;
        end
        C(dist(idx(i),2), n2 + dist(idx(i),2)) = 1;
    end
    if bipartite_matching(C) < n1+n2
        l_b = t+1;
    else 
        u_b = t;
    end
end

res = dist(idx(l_b),1);     

end

