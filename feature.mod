param m;		# number of observations
param n;		# number of attributes/weights

param A{1..m,1..n};	# measurements for independent variables at each observation
param b{1..m};		# value of dependent variable at each observation

param lambda;		# obj fn weight to sparsify model
param M;			# large value to ensure selection

var x{1..n};		# weights
var y{1..n} binary;	# feature selection

var Axmb{i in 1..m} = sum {j in 1..n} A[i,j]*x[j] - b[i];

minimize f:
	sum {i in 1..m} Axmb[i]^2 + lambda*sum {j in 1..n} y[j];

subject to select1{j in 1..n}:
	-M*y[j] <= x[j];
subject to select2{j in 1..n}:
			x[j] <= M*y[j];
