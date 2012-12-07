% Author: Jenner Hanni
% Tested in Matlab 2011b on Linux machines. 
% This is a script to reproduce the results of Karbassi and Bell's paper on 
% calculating the feedback matrix for parametric control of a 
% linear discrete-time system.

% It fails at calculating the transformation matrix T. 

% Karbassi, S.M. “Parametric time-optimal control of linear discrete-time 
% systems by state feedback Part 1. Regular Kronecker invariants." 
% International journal of control (0020-7179), 57 (4),p. 817.
% DOI: 10.1080/00207179308934415

% Released under the MIT License. 
% Copyright (c) 2012 Jenner Hanni <jeh.wicker@gmail.com>

clear all

% Create Tehrani system, discrete-time system
% Choose parameters

n = 4;        % dimensions
m = 3;        % 

A = [1 1 0 0 ; 1 0 1 1 ; 0 1 0 1 ; 0 1 1 1]; % nxn
B = [2 0 -2; 1 1 0 ; 0 0 2 ; 1 -1 0]; % nxm
C = [1 0 0 0];
D = 0;

sys = ss(A,B,C,D,0.25)

% Find the open-loop eigenvalues of the system

sys_eig = eig(sys)

% Build T from T = (B,AB) from paper

T(1:4,1:3) = B;
T(1:4,4:6) = A*B
T_inv = pinv(T)

% Build A_hat and B_hat from T

A_hat = pinv(T) * A * T
B_hat = pinv(T) * B

