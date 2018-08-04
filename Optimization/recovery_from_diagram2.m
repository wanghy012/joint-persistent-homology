function [ g1, g2 ] = recovery_from_diagram( basis, f1, f2, lambda )
A = basis*(basis'*basis)^-1*basis';


g1 = f1;
g2 = f2;
[n,~] = size(basis);
gamma=0.01;

figure(1);
plot([1:n],f1,'b',1:n,f2,'r');
figure(2);

d1 = get_diagram(f1);
d2 = get_diagram(f2);
plot_diagrams(d1,d2);

F = @(x,y) norm(x-f1)+norm(y-f2)+lambda*W2(get_diagram(x), get_diagram(y));
dh = 1;
h = F(g1,g2);
w2 = W2(get_diagram(g1), get_diagram(g2));
fprintf('h = %f, w2 = %f.\n',h,w2);
N=1;
while 1

    %plot(1:n,f1,'r',1:n,f2,'r',1:n,g1,'b',1:n,g2,'b');
    pause(0.2);
    N = N+1;
    df1 = zeros(n,1);
    df2 = zeros(n,1);
    diag1 = get_diagram(g1);
    diag2 = get_diagram(g2);
    plot(diag1(:,4),diag1(:,2),'b.');
    plot(diag2(:,4),diag2(:,2),'r.');
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
    if norm(g1-f1)>0
        df1 = (g1-f1)/norm(g1-f1)+df1;
    end
    if norm(g2-f2)>0
        df2 = (g2-f2)/norm(g2-f2)+df2;
    end
    g1 = A*(g1 - gamma*df1);
    g2 = A*(g2 - gamma*df2);
    
    h1 = F(g1,g2);
    dh = h-h1;
    h = h1;
    w2 = W2(get_diagram(g1), get_diagram(g2));
    fprintf('iter = %d, h = %f, w2 = %f.\n',N,h,w2);
end

fprintf('Total iterations = %d\n',N);
end

