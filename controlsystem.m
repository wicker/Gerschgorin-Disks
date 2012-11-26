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
% h_1 = h(i,i)
% h_2 = h(m+i,i)
% h_3 = h(1,j)

% needs an error if it returns 0
h_1 = r + c;   
 
% needs an error if temp_1 or temp_2 return 0
temp_1 = abs(abs(c-r) - abs(h_1));
temp_2 = abs(abs(c+r) - abs(h_1));
temp = [temp_1 temp_2];
h_2 = (1/alpha) * min(temp);

% needs the error if temp_1 or temp_2 return 0
% there are n-1 places for h_3 and the sum can't be more than min(temp)
h_3 = min(temp) / (n - 1);

% Compose H of h elements

%  H = [H11 H12 H13 ... H1r   H1r+1  ;
%       H21 H22 0   ... 0     0      ;
%       0   H32 H33 ... 0     0      ;
%       0   0   H43 ... rr    0      ;
%       0   0   0   ... Hr+1r Hr+1r+1;]

% But for now we build H by hand for the given example

H = [h_1 h_3 h_3 h_3;
     h_2 h_1 0   0  ;
     0   h_2 h_1 0  ;
     0   0   h_2 h_1;];

% And create H_tilde and then pull H_0 by hand.
% Not sure how to build H_tilde for a non-state space system representation
% This is a single matrix -- BUT also it's square so maybe just jordan().

[H_tilde_transform, H_tilde] = jordan(H);

H_0 = H_tilde(1:m,1:n);

% Eigenvalues of matrix H_tilde are same as eigenvalues of H.
% Feedback matrix of csys.A and csys.B is K_tilde:

K = F_p + B_0_inv * H_0 * T_inv;
