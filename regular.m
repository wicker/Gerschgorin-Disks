% Author: Jenner Hanni
% Tested in Matlab 2011b on Linux machines. 

% Calculating the invariant-related values for a given system

% Released under the MIT License. 
% Copyright (c) 2012 Jenner Hanni <jeh.wicker@gmail.com>

clear all

% A is a 4x4 square matrix (n = 4)
% B is a 4x3 square matrix (m = 2)

n = 4;        
m = 2;         

q = floor(n/m)

dim_r = n - q * m
dim_s = m - dim_r

val_dim_r = q + 1
val_dim_s = q

% Results:
%
% q = 2
% dim_r = 0
% dim_s = 2
% val_dim_r = 3
% val_dim_s = 2
% 
% This means there are 0 invariants of value 3
% and 2 invariants of value 2
