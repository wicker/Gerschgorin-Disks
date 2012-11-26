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

% Create a simple discrete-time system.
A_simple = [0 1; -5 -2];
B_simple = [0; 3];
C_simple = [0 1];
D_simple = 0;

sys_simple = ss(A_simple,B_simple,C_simple,D_simple,0.25);

A_eig_simple = eig(A_simple);

% Create Tehrani system, discrete-time system
% Choose parameters

n = 4;        % dimensions
m = 2;        % 

c = -0.2;     % center of disc
r = 0.3;      % radius of disc

alpha = 10;   % choose a value to make c and r into integers

A = [9 8 8 9; 2 7 4 7; 6 4 6 1; 4 0 7 1]; % nxn
B = [9 0; 9 3; 4 8; 8 0]; % mxn
C = [1 0 0 0];
D = 0;

sys = ss(A,B,C,D,0.25);

% Calculate variables needed later

q = n mod m;
dim_r = n - q * m;
dim_s = m - r;

val_dim_r = q + 1;
val_dim_s = q;

% Find the open-loop eigenvalues

A_eig = eig(A);

% Create explicit state-space model and calculate T

[csys,T] = canon(sys,'companion');

% Check that T is the controllability matrix calculated separately
% ctrb(sys) yields the same as ctrb(A,B): a 4x8 matrix
% which is not the same as the T resulting from canon();



% Isolate G_0 and B_0 from resulting A,B in companion form

G_0 = csys.A(1:m,1:n);
B_0 = csys.B(1:m,1:m);

% Find F using G_0, B_0, and T_0

B_0_inv = inv(B_0);
T_inv = inv(T);

F_p = -(B_0_inv) * G_0 * T_inv;

% Find H for this particular system given above



% Find actual values of h
% h(1,j) = h_1j 
% h(1,r+1) = h_1rp1
% h(i,j) = h_ij 
% h(i,i) = h_ii diagonal
% h(r+1,r+1) = 
% h(i,i+1)

h_1j = 
h_1rp1 = 
h_ij = 
h_ii = 

% Build top row of H
% H1j for j = 1,2,...,r

H1j = [h1

% Compose H of h elements

%  H = [H11 H12 H13 ... H1r   H1r+1  ;
%       H21 H22 0   ... 0     0      ;
%       0   H32 H33 ... 0     0      ;
%       0   0   H43 ... rr    0      ;
%       0   0   0   ... Hr+1r Hr+1r+1;]
