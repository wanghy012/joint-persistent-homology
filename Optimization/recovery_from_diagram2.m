function [ g1, g2 ] = recovery_from_diagram( basis, v1, v2, lambda )
A = basis*(basis'*basis)^-1*basis';
f1 = basis*v1;
f2 = basis*v2;

g1 = f1;
g2 = f2;
[n,~] = size(basis);
k=0.01;



F = @(x,y) norm(x-f1)+norm(y-f2)+lambda*W2(get_diagram(x), get_diagram(y));
dh = 1;
h = F(g1,g2);
w2 = W2(get_diagram(g1), get_diagram(g2));
fprintf('h = %f, w2 = %f.\n',h,w2);
N=1;
while N<200
    plot(1:n,f1,'r',1:n,f2,'r',1:n,g1,'b',1:n,g2,'b');
    pause(0.5);
    N = N+1;
    df1 = zeros(n,1);
    df2 = zeros(n,1);
    diag1 = get_diagram(g1);
    diag2 = get_diagram(g2);
    [w2,m1,m2] = W2(diag1,diag2);
    n1 = size(diag1,1);
    n2 = size(diag2,1);
    for i=1:n1-1
        if m1(i) <= n2
            df1(diag1(i,1))=(diag1(i,2)-diag2(m1(i),2));
            df1(diag1(i,3))=(diag1(i,4)-diag2(m1(i),4));
        else
            df1(diag1(i,1))=(diag1(i,2)-diag1(i,4))/2;
            df1(diag1(i,3))=(diag1(i,4)-diag1(i,2))/2;
        end
    end
    if m1(n1) <= n2
        df1(diag1(n1,1)) = diag1(n1,2)-diag2(m1(n1),2);
    else
        df1(diag1(n1,1)) = diag1(n1,2)/2;
    end
    for i=1:n2-1
        if m2(i) <= n1
            df2(diag2(i,1))=(diag2(i,2)-diag1(m2(i),2));
            df2(diag2(i,3))=(diag2(i,4)-diag1(m2(i),4));
        else
            df2(diag2(i,1))=(diag2(i,2)-diag2(i,4))/2;
            df2(diag2(i,3))=(diag2(i,4)-diag2(i,2))/2;
        end
    end
    if m2(n2) <= n1
        df2(diag2(n2,1)) = diag2(n2,2)-diag1(m2(n2),2);
    else
        df2(diag2(n2,1)) = diag2(n2,2)/2;
    end
    df1 = lambda*A*df1/w2;
    df2 = lambda*A*df2/w2;
    if norm(g1-f1)>0
        df1 = A*(g1-f1)/norm(g1-f1)+df1;
    end
    if norm(g2-f2)>0
        df2 = A*(g2-f2)/norm(g2-f2)+df2;
    end
    g1 = g1 - k*df1;
    g2 = g2 - k*df2;
    
    h1 = F(g1,g2);
    dh = h-h1;
    h = h1;
    w2 = W2(get_diagram(g1), get_diagram(g2));
    fprintf('h = %f, w2 = %f.\n',h,w2);
end

fprintf('Total iterations = %d\n',N);
end


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

