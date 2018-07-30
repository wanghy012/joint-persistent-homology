function [ diagram ] = get_diagram(f)

n = size(f,1);

[~,idx] = sort(f,'descend');

parent = zeros(n+2,1);
diagram = [];

for i=1:n
    if parent(idx(i)) == 0 && parent(idx(i)+2) == 0
        parent(idx(i)+1) = i;
    else
        if parent(idx(i)) == 0
            parent(idx(i)+1) = parent(idx(i)+2);
            continue;
        end
        if parent(idx(i)+2) == 0
            parent(idx(i)+1) = parent(idx(i));
            continue;
        end
        t = max(parent(idx(i)+2),parent(idx(i)));
        diagram(end+1,:) = [idx(t), f(idx(t)),idx(i),f(idx(i))];
        t2 = min(parent(idx(i)+2),parent(idx(i)));
        for j=idx(i):-1:1
            if parent(j) ~= t
                break;
            end
            parent(j) = t2;
        end
        for j=idx(i)+2:n+2
            if parent(j) ~= t
                break;
            end
            parent(j) = t2;
        end
    end
end

diagram(end+1,:) = [idx(1), f(idx(1)), NaN, 0];



end

