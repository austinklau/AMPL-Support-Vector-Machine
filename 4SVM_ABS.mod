param IMAGES; 
param PIXELS; # 784

param D{1..IMAGES, 1..PIXELS}; 

param A; # number of images of type A
param lambda;

var x{1..PIXELS}; # weights for each type of data (pixels)
var t{1..PIXELS} >= 0;	# absolute values of weights
var y{1..IMAGES} >= 0; # classification error for each images
var b; # threshold

var class_error = (sum {j in 1..A} y[j]) / A + (sum {j in A+1..IMAGES} y[j]) / (IMAGES-A);
var abs = (sum {j in 1..PIXELS} t[j]);

minimize avgError : class_error + abs * lambda;

subject to c1{i in 1..A}: sum {j in 1..PIXELS} (D[i,j] * x[j]) + y[i] >= b + 1;
subject to c2{i in A+1..IMAGES}: sum {j in 1..PIXELS} (D[i,j] * x[j]) - y[i] <= b - 1;

subject to abs1{j in 1..PIXELS}: # absolute value constraints
	-t[j] <= x[j];
subject to abs2{j in 1..PIXELS}:
	 x[j] <= t[j];
