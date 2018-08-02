function [ u1, u2 ] = recovery_from_diagram( basis, v1, v2, lambda )
%basis'*basis = I.

u1 = v1;
u2 = v2;
[n,~] = size(basis);
k=0.01;



F = @(x,y) norm(basis*(x-v1))+norm(basis*(y-v2))+lambda*W2(get_diagram(basis*x), get_diagram(basis*y));
dh = 1;
h = F(u1,u2);
w2 = W2(get_diagram(basis*u1), get_diagram(basis*u2));
fprintf('h = %f, w2 = %f.\n',h,w2);
N=1;
while N<529
    plot(1:n,basis*u1,'r',1:n,basis*u2,'--r',1:n,basis*v1,'b',1:n,basis*v2,'--b');
    %pause(0.2);
    N = N+1;
    df1 = zeros(n,1);
    df2 = zeros(n,1);
    diag1 = get_diagram(basis*u1);
    diag2 = get_diagram(basis*u2);
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
    df1 = lambda*df1/w2;
    df2 = lambda*df2/w2;
    if norm(u1-v1)>0
        du1 = (u1-v1)/norm(u1-v1)+basis'*df1;
    else
        du1 = basis'*df1;
    end
    if norm(u2-v2)>0
        du2 = (u2-v2)/norm(u2-v2)+basis'*df2;
    else
        du2 = basis'*df2;
    end
    u1 = u1 - k*du1;
    u2 = u2 - k*du2;
    
    h1 = F(u1,u2);
    dh = h-h1;
    h = h1;
    w2 = W2(get_diagram(basis*u1), get_diagram(basis*u2));
    fprintf('iter = %d, h = %f, w2 = %f.\n',N,h,w2);
end

fprintf('Total iterations = %d\n',N);
end


% function [val, m1, m2] = W2(diagram1, diagram2)
% n1 = size(diagram1,1);
% n2 = size(diagram2,1);
% 
% D = zeros(n1+n2,n1+n2);
% for i=1:n1
%     for j=1:n2
%         D(i,j) = (diagram1(i,2)-diagram2(j,2))^2+(diagram1(i,4)-diagram2(j,4))^2;
%     end
% end
% for i=1:n1
%     D(i,n2+1:n2+n1) = (diagram1(i,2) - diagram1(i,4))^2/2;
% end
% for i=1:n2
%     D(n1+1:n1+n2,i) = (diagram2(i,2) - diagram2(i,4))^2/2;
% end
% M = max(max(D));
% D = M - D;
% [val, m1, m2] = bipartite_matching(D);
% val = M*(n1+n2)-val;
% val = sqrt(val);
% end

