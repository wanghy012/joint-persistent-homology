function [ s, loc, val ] = gen_function()
% s gives the simplices
% loc gives the locations of points
% val gives the function values
s = [1,2;2,3;3,4;4,5;5,6;6,7;7,8;8,9;9,10;10,11];
loc = [0;1;2;3;4;5;6;7;8;9;10]+0.1*randn(11,1);
val = [-10;2;0;2;0;2;0;2;0;2;0]+1*randn(11,1);
end

