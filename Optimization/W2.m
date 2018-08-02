function [val, t1, t2] = W2(diagram1, diagram2)
n1 = size(diagram1,1);
n2 = size(diagram2,1);

D = zeros(n1+n2,n1+n2);
for i=1:n1
    for j=1:n2
        D(i,j) = (diagram1(i,2)-diagram2(j,2))^2+(diagram1(i,4)-diagram2(j,4))^2;
    end
end
for i=1:n1
    D(i,n2+1:n2+n1) = (diagram1(i,2) - diagram1(i,4))^2/2;
end
for i=1:n2
    D(n1+1:n1+n2,i) = (diagram2(i,2) - diagram2(i,4))^2/2;
end
M = max(max(D));
D = M - D;
[val, m1, m2] = bipartite_matching(D);
[~,idx] = sort(m1);
t1 = m2(idx);
[~,idx] = sort(m2);
t2 = m1(idx);
val = M*(n1+n2)-val;
val = sqrt(val);
end