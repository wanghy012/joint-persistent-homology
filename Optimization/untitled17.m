mask = zeros(100,40);
s = zeros(100,40);
for i=1:20
    for t = 1:100
        if rand()<0.4
            mask(t,i)=1;
            s(t,i) = f1(t)+rand()*0;
        end
    end
end
for i=21:40
    for t = 1:100
        if rand()<0.4
            mask(t,i)=1;
            s(t,i) = f2(t)+rand()*0;
        end
    end
end