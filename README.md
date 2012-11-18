Gerschgorin-Disks
=================

Assigning complex eigenvalues in a disk D(c,r) using Gerschgorin's Theorem.

This is a project for ECE576 Computational Methods to choose a paper and reproduce its results. 

This paper presents a method using state feedback control for a large-scale, discrete-time system to localize eigenvalues in a small known-stable region in the form of a Gerschgorin disk D(c,r) on the complex plane. All the eigenvalues are first assigned to zero to get a state feedback matrix Fp, which is then used to get a state feedback matrix Kp which assigns those eigenvalues to small disk regions using elementary similarity operations and Gerschgorin's theorem. The paper works out two example problems so the generated code can be tested over those examples as well as any in the textbook.

Implementation

This code will take an A and B matrix with same number of rows, a real-valued center c and radius r of the target circle. It will output the location of the closed-loop eigenvalues.

Languages are C and MATLAB.

Main Paper

Tehrani, H. A. "Assignment of Eigenvalues in a Disc D (c, r) of Complex Plane with Application of the Gerschgorin Theorem." World Applied Sciences Journal 5.5 (2008): 576-581.

Further References

Advanced Engineering Mathematics, Kreyszig, Section 20.7, Inclusion of Matrix Eigenvalues, which includes Gerschgorin's Theorem.

S.M. Karbassi, H.A. Tehrani, Parameterizations of the state feedback controllers for linear multivariable systems, Computers &amp; Mathematics with Applications, Volume 44, Issues 8–9, October–November 2002, Pages 1057-1065, ISSN 0898-1221

Karbassi, S.M. (04/1993). "Parametric time-optimal control of linear discrete-time systems by state feedback Part 1. Regular Kronecker invariants". International journal of control (0020-7179), 57 (4),p. 817. DOI: 10.1080/00207179308934415

Down with Determinants, Sheldon Axler, 21 Dec 1994.

My current basic understanding:

We tend to use approximations and error bounds for eigenvalues using iteration. We can't determine eigenvalues exactly because they are roots of an nth degree polynomial where n is the number of rows and columns in a square matrix. Also, nonsymmetric matrices may have complex eigenvalues. 

Use Gerschgorin's Theorem on a matrix when we want to find closed disk regions in which all of that matrix's complex eigenvalues lie.

Come at this from the opposite direction for this paper: a stable closed-loop control system needs poles to be placed in a particular region. If we specify that region as a closed disk D(c,r) centered at (c,0) with radius r and place our poles there.

