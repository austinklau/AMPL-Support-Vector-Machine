param m;		# number of observations
param n;		# number of attributes/weights

param A{1..m,1..n};	# measurements for independent variables at each observation
param b{1..m};		# value of dependent variable at each observation

param lambda;		# obj fn weight to sparsify model

var x{1..n};		# weights
var t{1..n} >= 0;	# absolute values

var Axmb{i in 1..m} = sum {j in 1..n} A[i,j]*x[j] - b[i];

minimize f:
	sum {i in 1..m} Axmb[i]^2 + lambda*sum {j in 1..n} t[j];

subject to abs1{j in 1..n}:
	-t[j] <= x[j];
subject to abs2{j in 1..n}:
			x[j] <= t[j];
