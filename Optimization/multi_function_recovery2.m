function [ f ] = multi_function_recovery( P, mask, s, lambda)
%h = sum(norm(maski.*(fi-si))) + lambda*sum(w2(D(fi),D(fj)))

[n,k] = size(mask);
f = zeros(n,k);
initialization();
iter=0;
gamma = 0.1;

plot(f)
pause(1);

while iter<500
    iterate();
    fprintf('iter = %d, h = %f.\n',iter,h);
    plot2();
    
end



    function plot2()
        cla;
        hold on;
        for i=1:20
            d = get_diagram(f(:,i));
            t(i) = plot(d(:,4),d(:,2),'bo');
        end
        for i=21:40
            d = get_diagram(f(:,i));
            t(i) = plot(d(:,4),d(:,2),'ro');
        end
        pause(0.2);
    end

    

    function initialization()
        for i=1:k
            t = [];
            t2 = 0;
            for j=1:n
                if mask(j,i)==1
                    t2 = t2+1;
                    t(t2,:) = [j,s(j,i)];
                end
            end
            for j=1:t(1,1)
                f(j,i) = j*t(1,2)/t(1,1);
            end
            for j=2:t2
                for j2 = 1:t(j,1)-t(j-1,1)
                    f(j2+t(j-1,1),i) = t(j-1,2)+j2*(t(j,2)-t(j-1,2))/(t(j,1)-t(j-1,1));
                end
            end
            for j=1:n-t(t2,1)
                f(j+t(t2,1),i) = t(t2,2)*(1-j/(n-t(t2,2)));
            end
        end
        f = P*f;
    end

    function iterate()
        iter = iter+1;
        df = zeros(n,k);
        h=0;
        
        %derivative in w2
        for i=1:k
            t = get_diagram(f(:,i));
            diag(i) = libpointer('doublePtrPtr',t);
        end
        for i=1:k-1
            for j=i+1:k
                [val,m1,m2] = W2(diag(i),diag(j));
                if val > eps
                    h = h+val*lambda;
                    diag1 = get(diag(i),'Value');
                    diag2 = get(diag(j),'Value');
                    n1 = size(diag1,1);
                    n2 = size(diag2,1);
                    df2 = zeros(n,1);
                    for i1=1:n1-1
                        if m1(i1) <= n2
                            df2(diag1(i1,1))=(diag1(i1,2)-diag2(m1(i1),2));
                            df2(diag1(i1,3))=(diag1(i1,4)-diag2(m1(i1),4));
                        else
                            df2(diag1(i1,1))=(diag1(i1,2)-diag1(i1,4))/2;
                            df2(diag1(i1,3))=(diag1(i1,4)-diag1(i1,2))/2;
                        end
                    end
                    if m1(n1) <= n2
                        df2(diag1(n1,1)) = diag1(n1,2)-diag2(m1(n1),2);
                    else
                        df2(diag1(n1,1)) = diag1(n1,2)/2;
                    end
                    df(:,i) = df(:,i) + df2/val;
                    df2 = zeros(n,1);
                    for i1=1:n2-1
                        if m2(i1) <= n1
                            df2(diag2(i1,1))=(diag2(i1,2)-diag1(m2(i1),2));
                            df2(diag2(i1,3))=(diag2(i1,4)-diag1(m2(i1),4));
                        else
                            df2(diag2(i1,1))=(diag2(i1,2)-diag2(i1,4))/2;
                            df2(diag2(i1,3))=(diag2(i1,4)-diag2(i1,2))/2;
                        end
                    end
                    if m2(n2) <= n1
                        df2(diag2(n2,1)) = diag2(n2,2)-diag1(m2(n2),2);
                    else
                        df2(diag2(n2,1)) = diag2(n2,2)/2;
                    end
                    df(:,j) = df(:,j) + df2/val;
                    
                end
            end
        end
        df = df * lambda;
        
        %derivative in l2 distance between s and f 
        for i=1:k
            t = mask(:,i).*(f(:,i)-s(:,i));
            if norm(t)>eps
                h = h + norm(t);
                df(:,i) = df(:,i) + t/norm(t);
            end
        end
        
        %gradient descent
        f = P*(f - gamma*df);
    end


end

