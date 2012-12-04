% Author: Jenner Hanni
% Tested in Matlab 2011b on Linux machines. 
% This is a script to reproduce the results of Tehrani's paper on placing 
% the eigenvalues of a control system by way of Gershgorin's Theorem.

% Tehrani, H. A. "Assignment of Eigenvalues in a Disc D (c, r) of 
% Complex Plane with Application of the Gerschgorin Theorem." 
% World Applied Sciences Journal 5.5 (2008): 576-581.

% Released under the MIT License. 
% Copyright (c) 2012 Jenner Hanni <jeh.wicker@gmail.com>


clear all

% Create Tehrani system, discrete-time system
% Choose parameters

n = 4;        % dimensions
m = 3;        % 

c = -0.2;     % center of disc
r = 0.3;      % radius of disc

alpha = 10;   % choose a value to make c and r into integers

% develop new c and r using alpha, they'll be adjusted back later

c = alpha * c;
r = alpha * r;

A = [1 1 0 0 ; 1 0 1 1 ; 0 1 0 1 ; 0 1 1 1]; % nxn
B = [2 0 -2; 1 1 0 ; 0 0 2 ; 1 -1 0]; % nxm
C = [1 0 0 0];
D = 0;

sys = ss(A,B,C,D,0.25);

% Calculate variables needed later

q = floor(n/m)

dim_r = n - q * m
dim_s = m - dim_r

val_dim_r = q + 1
val_dim_s = q

