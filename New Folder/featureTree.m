classdef featureTree < handle
    
    properties
        nodes %nodes in this feature. Array of integers and tags.
        D %distance matrix between pairs
        subfeatures %Array of subfeatures
        parent
        eps 
        conf % =1 if there's a conflict
        r % the speed that eps shrink
        leaves %the set of leaves of the tree
    end
    
    methods
        function res = featureTree(nodes,eps,D,r,parent)
            if nargin<1
                return;
            end
            res.nodes = nodes;
            [~,f] = mode(nodes(:,2));
            res.conf = (f>1);
            res.eps = eps;
            res.D = D;
            res.subfeatures = featureTree.empty();
            res.r = r;
            res.parent = parent;
            if ~res.conf
                res.leaves = res;
            else
                res.leaves = featureTree.empty();
                e = eps;
                while 1
                    e = e*r;
                    G = graph(D<e);
                    bins = conncomp(G);
                    if ~isempty(find(bins==2))
                        break;
                    end
                end
                i=1;
                t = find(bins == i);
                while(~isempty(t))
                    i=i+1;
                    newnode = featureTree(nodes(t,:),e,D(t,t),r,res);
                    res.subfeatures(end+1) = newnode;
                    res.leaves = [res.leaves, newnode.leaves];
                    t = find(bins == i);
                end
            end
        end
        
        
            
    end
    
end

