function [ s, loc, val ] = gen_function()
% s gives the simplices
% loc gives the locations of points
% val gives the function values
s = [1,2;2,3;3,4;4,5];
loc = [rand();rand()+1;rand()+2;rand()+3;rand()+4];
val = [rand()+1;rand();rand()+1;rand();rand()+1];
end

