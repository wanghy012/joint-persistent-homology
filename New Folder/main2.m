clear all;
eps = 20;
n_min=0;


f1 = @(x) 0.03*sin(x)*(x/2+pi);
f2 = @(x) 0.03*sin(x)*(x/2-4*pi);
I = [0,6*pi];


% f1 = @sin;
% f2 = @cos;
% I = [0, 4*pi];

sr = 1.5;
N=0;
for i=1:50
    samples(i) = smooth(gen_sample(I,f1,sr),1);
    diagrams(i) = get_diagram2(samples(i),0.2);
    diag = get(diagrams(i),'Value');
    [n,~] = size(diag);
    diag(:,5) = i;
    pairs(N+1:N+n,:) = diag;
    N=N+n;
end
for i=1:50
    samples(i+50) = smooth(gen_sample(I,f2,sr),1);
    diagrams(i+50) = get_diagram2(samples(i+50),0.2);
    diag = get(diagrams(i+50),'Value');
    [n,~] = size(diag);
    diag(:,5) = i+50;
    pairs(N+1:N+n,:) = diag;
    N=N+n;
end

pairs1 = [];
pairs2 = [];
for i=1:N
    if pairs(i,1)<pairs(i,3)
        pairs1(end+1,:) = pairs(i,:);
    else
        pairs2(end+1,:) = pairs(i,:);
    end
end

[N,~] = size(pairs1);
D = zeros(N,N);
for i=1:N
    for j=i+1:N
        D(i,j) = d(pairs1(i,1:4),pairs1(j,1:4));
        D(j,i) = D(i,j);
    end
end
nodes = zeros(N,2);
for i=1:N
    nodes(i,1) = i;
end
nodes(:,2) = pairs1(:,5);
root1 = featureTree(nodes, eps, D, 0.9, featureTree.empty());
leaves = root1.leaves;
n = size(leaves,2);
for i=1:n
nodes = leaves(i).nodes;
m = size(nodes,1);
a1(i) = m;
for j=1:m
w1(nodes(j,1)) = leaves(i);
end
end

[N,~] = size(pairs2);
D = zeros(N,N);
for i=1:N
    for j=i+1:N
        D(i,j) = d(pairs2(i,1:4),pairs2(j,1:4));
        D(j,i) = D(i,j);
    end
end
nodes = zeros(N,2);
for i=1:N
    nodes(i,1) = i;
end
nodes(:,2) = pairs2(:,5);
root2 = featureTree(nodes, eps, D, 0.9, featureTree.empty());
leaves = root2.leaves;
n = size(leaves,2);
for i=1:n
nodes = leaves(i).nodes;
m = size(nodes,1);
a2(i) = m;
for j=1:m
w2(nodes(j,1)) = leaves(i);
end
end






