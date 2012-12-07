% Author: Jenner Hanni
% Tested in Matlab 2011b on Linux machines. 
% This is a script to reproduce the results of Tehrani's paper on placing 
% the eigenvalues of a control system by way of Gershgorin's Theorem.

% It produces matrices of the correct dimension and form but
% with the wrong values. The comments contain alternate previous attempts.

% Tehrani, H. A. "Assignment of Eigenvalues in a Disc D (c, r) of 
% Complex Plane with Application of the Gerschgorin Theorem." 
% World Applied Sciences Journal 5.5 (2008): 576-581.

% Released under the MIT License. 
% Copyright (c) 2012 Jenner Hanni <jeh.wicker@gmail.com>

clear all

% Create Tehrani system, discrete-time system
% Choose parameters

n = 4;        % dimensions
m = 2;        % 

c = -0.2;     % center of disc
r = 0.3;      % radius of disc

alpha = 10;   % choose a value to make c and r into integers

% develop new c and r using alpha, they'll be adjusted back later
% load the matrices into a state-space system

c = alpha * c;
r = alpha * r;

A = [9 8 8 9; 2 7 4 7; 6 4 6 1; 4 0 7 4]; % nxn
B = [9 0; 9 3; 4 8; 8 0]; % mxn
C = [1 0 0 0];
D = 0;

sys = ss(A,B,C,D,1);

% Calculate variables needed later

q = floor(n/m);
display(q);

dim_r = n - q * m;
dim_s = m - dim_r;

val_dim_r = q + 1;
val_dim_s = q;

% Find the open-loop eigenvalues of the system

sys_eig = eig(sys);

% Build T from T = (B,AB) from paper

T_pap = [0 0 0 0 ; 0 0 0 0 ; 0 0 0 0 ; 0 0 0 0];
T_pap(1:4,1:2) = B;
T_pap(1:4,3:4) = A*B

T_pap_inv = inv(T_pap)

% Create explicit state-space model and calculate T

[csys,T] = canon(sys,'companion')

% Check that T is the controllability matrix calculated separately
% ctrb(sys) yields the same as ctrb(A,B): a 4x8 matrix
% which is not the same as the T resulting from canon();

B;
T_pap_inv;
B_hat_pap = T_pap_inv * B

% The A_hat_pap calculations below ought to work but don't
% so we're going to build it by hand

% A_hat_pap = T_pap_inv * A
% A_hat_pap = A_hat_pap * T

B(:,1);
v_1 = T_pap_inv * A^2 * B(:,1)
v_2 = T_pap_inv * A^2 * B(:,2)

A_hat_pap(3:4,1:2) = [1 0 ; 0 1];
A_hat_pap(:,3) = v_1;
A_hat_pap(:,4) = v_2

% B_hat_pap and A_hat_pap are now in standard echelon form that
% agrees with the Karbassi paper
%
% Calculate the primary vector companion forms of the system
% Depends on Karbassi, Bell (1993)
% This form is more suited to working with control systems

V_1 = A_hat_pap(1:2,3:4)
V_2 = A_hat_pap(3:4,3:4)

B_tilde_pap = [ 1 0 ; 0 1 ; 0 0 ; 0 0 ];
A_tilde_pap(1:2,3:4) = V_1;
A_tilde_pap(1:2,1:2) = V_2;
A_tilde_pap(3:4,3:4) = 0

% Build transformation matrix S as per Karbassi paper 

S_pap(1:2,1:2) = [1 0;0 1];
S_pap(1:2,3:4) = V_2;
S_pap(3:4,3:4) = [1 0; 0 1]

% Isolate G_0 and B_0 from the resulting A_tilde,B_tilde in companion form
% These are the equations which did not work
% G_0 = csys.A(1:m,1:n);
% B_0 = csys.B(1:m,1:m);

B_0_tilde = B_tilde_pap(1:m,1:m)
G_tilde = A_tilde_pap(1:m,1:n)

% Find F using G_0, B_0, and T_0
% These are previous equations which did not work
% B_0_inv = inv(B_0);
% T_inv = inv(T);
% F_p = -((B_0_inv) * G_0 * T_inv);
% F_tilde below is absolutely correct for Tehrani and Karbassi
% the problem is in F_p
% Karbassi calls for:
% F_p = F_tilde * inv(S_pap) * T_pap_inv
% but Tehrani actually disregards inv(S) entirely here
%F_p = F_tilde * T_pap_inv
% This doesn't work either
% Longer form in Tehrani depends on finding K_tilde by
% K_tilde = F_tilde + inv(B_0) * H_0

F_tilde = - inv(B_0_tilde) * G_tilde

% Find H for this particular system given above
% h_1 = h(i,i)
% h_2 = h(m+i,i)
% h_3 = h(1,j)

% needs an error if it returns 0
h_1 = r + c;

% needs an error if temp_1 or temp_2 return 0
% needs the error if temp_1 or temp_2 return 0
% there are n-1 places for h_3 and the sum can't be more than min(temp)

temp_1 = abs(abs(c-r) - abs(h_1));
temp_2 = abs(abs(c+r) - abs(h_1));

if temp_1 == 0
    h_2 = (1/alpha) * temp_2;
    h_3 = temp_2 / (n - 1);
elseif temp_2 == 0
    h_2 = (1/alpha) * temp_1;
    h_3 = temp_1 / (n - 1);
else
    temp = [temp_1 temp_2];
    h_2 = (1/alpha) * min(temp);
    h_3 = min(temp) / (n - 1);
end

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
     0   0   h_2 h_1;]

% And create H_tilde and then pull H_0 by hand.
% Not sure how to build H_tilde for a non-state space system representation
% This is a single matrix -- BUT also it's square so maybe just jordan().

[H_tilde_transform, H_tilde] = jordan(H);

H_0 = H_tilde(1:m,1:n)

% Eigenvalues of matrix H_tilde are same as eigenvalues of H.
% Feedback matrix of csys.A and csys.B is K_tilde:

K = F_tilde + inv(B_0_tilde) * H_0

% Test closed-loop eigenvalues

new_poles = eig(A - B*K)

