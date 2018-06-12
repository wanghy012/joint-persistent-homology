function [ feat ] = get_features( s, loc, val )
% this function gives the pairing of points according to persistent
% homology. Each row in the output is in the form of
% [loc_of_birth val_of_birth loc_of_death val_of_death]

[val, p] = sort(val);

n = size(loc);
t = loc;
for i = 1:1:n(1)
    loc(i,:) = t(p(i),:);
end
clear t;

p1 = zeros(n);
for i=1:n(1)
    p1(p(i)) = i;
end

m = size(s);
t = s;
for i = 1:1:m(1)
    for j = 1:1:m(2)
        s(i,j) = p1(t(i,j));
    end
    s(i,:) = sort(s(i,:))';
end
clear t p p1;


% begin computing features
N = 1;
tag = zeros(n(1),1);
for i = 1:n(1)
    for j = 1:m(1)
        if s(j,2) == i
            if tag(i) == 0
                tag(i) = tag(s(j,1));
            end
            if tag(i) ~= tag(s(j,1));
                if tag(i) < tag(s(j,1))
                    t = tag(s(j,1));
                    t1 = tag(i);
                else
                    t = tag(i);
                    t1 = tag(s(j,1));
                end
                feat(N,:) = [loc(t), val(t), loc(i), val(i)];
                N = N+1;
                for k = 1:n(1)
                    if tag(k) == t
                        tag(k) = t1;
                    end
                end
            end
        end
    end
    if tag(i) == 0
        tag(i) = i;
    end
end
 
                   
            
            
    


end

