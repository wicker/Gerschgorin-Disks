clear all

A = [ 9 8 8 9 ; 2 7 4 7 ; 6 4 6 1 ; 4 0 7 2 ]

B = [9 0 ; 9 3 ; 4 8 ; 8 0]

C = [1 0 0 0 ]

sys_open = ss(A,B,C,0);

eig(A)
eig(sys_open)

% Taking eig(A) and eig(sys_open) are the same thing
% 
% Matlab says the open loop poles are
%   21.1599          
%   0.2282 + 4.3316i
%   0.2282 - 4.3316i
%   2.3837
%
% Tehrani says they should be
%   21.4707
%   1.1178±4.5139i
%   2.2938
%
% Do Tehrani's eigenvalues (pole locations) satisfy this open loop system?
% Don't know how to do it.
% So I tested the closed-loop eigenvalues on this system to see if we get K
%

p1 = -0.0021
p2 = -0.2561 + 0.0092i
p3 = -0.2561 - 0.0092i
p4 = -0.1512

K = place(A,B,[p1 p2 p3 p4])

sys_closed = ss(A-B*K,B,C,0);

eig(sys_closed);

% Taking eig(A-B*K) and eig(sys_closed) are the same thing
% 
% These eigenvalues give an entirely positive K
%
% K =  0.2177    0.4115    0.5265    0.6045
%      1.9568    1.0697    1.1064    0.4652

