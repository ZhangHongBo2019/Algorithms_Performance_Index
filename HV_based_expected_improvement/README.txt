Implementation of Expected Improvement of Hypervolume. 

This matlab program computes the ExI by means of closed form expressions for 
two objective functions. It is based on the Paper:

M. Emmerich, A.H. Deutz, J.W. Klinkenberg: The computation of the expected improvement in dominated hypervolume of Pareto front approximations , LIACS TR-4-2008, Leiden University, The Netherlands 
http://www.liacs.nl/~emmerich/TR-ExI.pdf

The package implements the function:
function res=exi2d(P,r,mu,s)


	P: approximation set: 	provide f1,f2 coordinates of current Pareto front
            	     		approximation 
	r: reference point: 	used for computing the hypervolune
	mu: mean vector:     	mean value of predictive distribution (e.g. from
      	           		Gaussian process), f1, f2
	s: stdev:           	Standard deviations of predictive distribution


Examples: 
	exi2d([0,2;1,1;2,0],[3,3],[0,0],[0.1,0.1]) should approximately result in 3
	exi2d([1,2;2,1],[11,11],[10,10],[4,4]) should yield 0.0726
% ----------------------------------------------------------------------
% (c) Michael Emmerich and Andre Deutz, LIACS, Leiden University, 2010
%     emmerich@liacs.nl, deutz@liacs.nl
% ---------------------------------------------------------------------

