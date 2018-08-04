basis=ones(100,1);

for i=1:10
    basis(:,2*i) = sin((1:100)*i*2*pi/100)';
    basis(:,2*i+1) = cos((1:100)*i*2*pi/100)';
end

P = basis*(basis'*basis)^-1*basis';

