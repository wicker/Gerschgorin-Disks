% Author: Jenner Hanni
% Tested in Matlab 2011b on Linux machines. 
%
% This file creates a simple, discrete-time system. 
%
% Released under the MIT License. 
% Copyright (c) 2012 Jenner Hanni <jeh.wicker@gmail.com>


clear all

% Create a simple discrete-time system.
A_simple = [0 1; -5 -2]
B_simple = [0; 3]
C_simple = [1 0]
D_simple = 0

sys_simple = ss(A_simple,B_simple,C_simple,D_simple,0.25)

A_eig_simple = eig(sys_simple)

