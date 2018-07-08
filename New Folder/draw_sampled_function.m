function [  ] = draw_sampled_function( samples )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
s = get(samples, 'Value');
plot(s(:,1),s(:,2))

end

