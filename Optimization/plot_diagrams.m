function M=plot_diagrams( d1,d2,d3 )
[~,m1,m2] = W2(d1,d2);
n1 = size(d1,1);
n2 = size(d2,1);
if nargin == 2
    M = max([d1(:,2);d2(:,2)]);
else
    M = max([d1(:,2);d2(:,2);d3(:,2)]);
end

plot([0,1.1*M],[0,1.1*M],'k-');
hold on;

axis square;
axis([0 1.1*M 0 1.1*M]);
xlabel('Death time');
ylabel('Birth time');
plot(d1(:,4),d1(:,2),'bo',d2(:,4),d2(:,2),'ro');

for i=1:n1
    if m1(i)<=n2
        plot([d1(i,4),d2(m1(i),4)],[d1(i,2),d2(m1(i),2)],'k--');
    else
        plot([d1(i,4),(d1(i,4)+d1(i,2))/2],[d1(i,2),(d1(i,4)+d1(i,2))/2],'k--');
    end
end
for i=1:n2
    if m2(i)>n1
        plot([d2(i,4),(d2(i,4)+d2(i,2))/2],[d2(i,2),(d2(i,4)+d2(i,2))/2],'k--');
    end
end
if nargin > 2
    plot(d3(:,4),d3(:,2),'gd');
end

end

