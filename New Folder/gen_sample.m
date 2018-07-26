function [ res ] = gen_sample(I, f, p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

x = I(1);

N=1;
x = x - log(rand())/p;
samples = [];
while x<I(2)
    samples(N,:) = [x, f(x)+rand()*0];
    N = N+1;
    x = x - log(rand())/p;
end
res = libpointer('doublePtrPtr', samples);
end

