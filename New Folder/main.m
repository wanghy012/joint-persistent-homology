clear all;

sr = 2;
f1 = @(x) sin(x);
f2 = @(x) sin(2*x);
I = [0,4*pi];

for i=1:2:50
    samples(i) = gen_sample(I, f1, sr);
    samples(i+1) = gen_sample(I, f2, sr);
    diagrams(i) = get_diagram(samples(i));
    diagrams(i+1) = get_diagram(samples(i+1));
end

dsim = zeros(50,50);
for i=1:50
    for j=i+1:50
        dsim(i,j) = d_1(samples(i),samples(j));
        dsim(j,i) = dsim(i,j);
    end
end

[gap1,cluster1] = spectral_gap(dsim);

dsim = zeros(50,50);
for i=1:50
    for j=i+1:50
        dsim(i,j) = d_w1(diagrams(i),diagrams(j));
        dsim(j,i) = dsim(i,j);
    end
end

[gap2,cluster2,v1,v2] = spectral_gap(dsim);


dsim = zeros(50,50);
for i=1:50
    for j=i+1:50
        dsim(i,j) = d_b(diagrams(i),diagrams(j));
        dsim(j,i) = dsim(i,j);
    end
end

[gap3,cluster3] = spectral_gap(dsim);



