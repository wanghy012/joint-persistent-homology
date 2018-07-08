function [ res ] = d_w1( diag1, diag2 )
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


C = zeros(n1+n2, n1+n2);
for i=1:n1
    for j=1:n2
        C(i,j) = sqrt(sum((d1(i,:)-d2(j,:)).^2));
    end
end
for i=1:n1
    for j=1:n1
        C(i, n2+j) = (d1(i,2)-d1(i,1))/sqrt(2);
    end
end
for i=1:n2
    for j=1:n2
        C(n1+i, j) = (d2(j,2)-d2(j,1))/sqrt(2);
    end
end

M = max(max(C));
C = M - C;

res = M*(n1+n2) - bipartite_matching(C);


  

end

