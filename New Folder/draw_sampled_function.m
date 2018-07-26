function [  ] = draw_sampled_function( samples1, samples2 )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
    s = get(samples1, 'Value');
    plot(s(:,1),s(:,2),'b')
else
    s1 = get(samples1, 'Value');
    s2 = get(samples2, 'Value');
    plot(s1(:,1),s1(:,2),'r',s2(:,1),s2(:,2),'b')
end
end

