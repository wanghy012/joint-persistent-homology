function [ res ] = d_1( s1, s2 )

if isNull(s1) || isNull(s2)
    res = 0;
    return;
end

sample1 = get(s1, 'Value');
sample2 = get(s2, 'Value');

if sample1(end,1) <= sample2(1,1)
    res = 0;
    return;
end

if sample2(end,1) <= sample1(1,1)
    res = 0;
    return;
end


res = 0;
[n1,~] = size(sample1);
[n2,~] = size(sample2);

i1=1;
i2=1;
t = sample1(1,1)<sample2(1,1);
while (t == (sample1(i1,1)<sample2(i2,1)))
    if t == 1
        i1 = i1+1;
    else
        i2 = i2+1;
    end
end
if t == 1
    t1 = sample2(1,1);
    y11 = sample1(i1-1,2) + (t1-sample1(i1-1,1))*(sample1(i1,2)-sample1(i1-1,2))/(sample1(i1,1)-sample1(i1-1,1));
    y21 = sample2(1,2);
else
    t1 = sample1(1,1);
    y11 = sample1(1,2);
    y21 = sample2(i2-1,2) + (t1-sample2(i2-1,1))*(sample2(i2,2)-sample2(i2-1,2))/(sample2(i2,1)-sample2(i2-1,1));
end

while i1<=n1 && i2<=n2
    if sample1(i1,1)<sample2(i2,1)
        t2 = sample1(i1,1);
        y12 = sample1(i1,2);
        y22 = y21+(t2-t1)*(sample2(i2,2)-y21)/(sample2(i2,1)-t1);
        i1 = i1+1;
    else
        t2 = sample2(i2,1);
        y22 = sample2(i2,2);
        y12 = y11+(t2-t1)*(sample1(i1,2)-y11)/(sample1(i1,1)-t1);
        i2 = i2+1;
    end
    if (y11-y21)*(y12-y22)<0
        s = abs(y11-y21) + abs(y12-y22);
        a = ((y11-y21)^2+(y12-y22)^2)*(t2-t1)/2/s;
        res = res + a;
    else
        a = (abs(y11-y21) + abs(y12-y22))*(t2-t1)/2;
        res = res + a;
    end
    t1 = t2;
    y11 = y12;
    y21 = y22;
end

    
    
    

    
    

    
    
    
end




