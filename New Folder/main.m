clear all;

k=2;
sr = 1;
%f1 = @(x) (x<1)*k + (x>4 && x<5)*(k+1) + (x>5)*1;
%f2 = @(x) (x<1)*(k+1) + (x>4 && x<5)*k + (x>5)*1;

f1 = @sin;
f2 = @cos;

I = [0,4*pi];
N = 60;
for i=1:2:N
    samples(i) = gen_sample(I, f1, sr);
    samples(i+1) = gen_sample(I, f2, sr);
    diagrams(i) = get_diagram(samples(i));
    diagrams(i+1) = get_diagram(samples(i+1));
end

dsim = zeros(N,N);
for i=1:N
    for j=i+1:N
        dsim(i,j) = d_1(samples(i),samples(j));
        dsim(j,i) = dsim(i,j);
    end
end

[gap1,cluster1] = spectral_gap(dsim);
a = zeros(2,2);
for i=1:N
    a(mod(i,2)+1,cluster1(i)) = a(mod(i,2)+1,cluster1(i))+1;
end
accuracy1 = max(a(1,1)+a(2,2), a(1,2)+a(2,1))/N;
    

dsim = zeros(N,N);
for i=1:N
    for j=i+1:N
        dsim(i,j) = d_b(diagrams(i),diagrams(j));
        dsim(j,i) = dsim(i,j);
    end
end

[gap2,cluster2,v1,v2] = spectral_gap(dsim);
a = zeros(2,2);
for i=1:N
    a(mod(i,2)+1,cluster2(i)) = a(mod(i,2)+1,cluster2(i))+1;
end
accuracy2 = max(a(1,1)+a(2,2), a(1,2)+a(2,1))/N;


dsim = zeros(N,N);
for i=1:N
    for j=i+1:N
        dsim(i,j) = d_w1(diagrams(i),diagrams(j));
        dsim(j,i) = dsim(i,j);
    end
end

[gap3,cluster3] = spectral_gap(dsim);
a = zeros(2,2);
for i=1:N
    a(mod(i,2)+1,cluster3(i)) = a(mod(i,2)+1,cluster3(i))+1;
end
accuracy3 = max(a(1,1)+a(2,2), a(1,2)+a(2,1))/N;



