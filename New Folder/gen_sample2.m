function [ res ] = gen_sample2(I, f, p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

x = I(1);
eps = 0.001;



N=1;
while x<I(2)
    samples(N,:) = [x, f(x)];
    N = N+1;
    r = - log(rand())/p;
    while (r>0)
        r = r - abs(f(x)-f(x+eps));
        x = x + eps;
    end
end
res = libpointer('doublePtrPtr', samples);
end

