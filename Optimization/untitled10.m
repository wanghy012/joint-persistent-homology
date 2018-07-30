function [ f1, g1 ] = untitled10( f, g, lambda )
d=1;
k=0.1;

n=max(size(f));

f1 = f;
g1 = g;
F = @(x,y) norm(x-f,1)+norm(y-g,1)+lambda*norm(x-y);
h = F(f1,g1);
while d>1e-4
    fprintf('%f\n',h);
    for i=1:n
        if f1(i) == f(i)
            if lambda*abs(f1(i)-g1(i))>norm(f1-g1)
                df(i) = sign(f1(i)-g1(i))*(lambda*abs(f1(i)-g1(i))/norm(f1-g1)-1);
            else
                df(i)=0;
            end
        else 
            df(i) = sign(f1(i)-f(i))+lambda*(f1(i)-g1(i))/norm(f1-g1);
        end
        if g1(i) == g(i)
            if lambda*abs(f1(i)-g1(i))>norm(f1-g1)
                dg(i) = sign(g1(i)-f1(i))*(lambda*abs(f1(i)-g1(i))/norm(f1-g1)-1);
            else
                dg(i)=0;
            end
        else 
            dg(i) = sign(g1(i)-g(i))+lambda*(g1(i)-f1(i))/norm(f1-g1);
        end
    end
    f1 = f1 - k*df;
    g1 = g1 - k*dg;
    h2 = F(f1,g1);
    d = h - h2;
    h = h2;     
end

