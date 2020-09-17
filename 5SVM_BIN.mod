param IMAGES; 
param PIXELS; # 784

param D{1..IMAGES, 1..PIXELS}; 

param A; # number of images of type A
param lambda;
param M; # large value to ensure selection

var x{1..PIXELS}; # weights for each type of data (pixels)
var bin{1..PIXELS} binary; # binary vars
var y{1..IMAGES} >= 0; # classification error for each images
var b; # threshold

var class_error = (sum {j in 1..A} y[j]) / A + (sum {j in A+1..IMAGES} y[j]) / (IMAGES-A);
var bin_sum = (sum {j in 1..PIXELS} bin[j]);

minimize avgError : class_error + bin_sum * lambda;

subject to c1{i in 1..A}: sum {j in 1..PIXELS} (D[i,j] * x[j]) + y[i] >= b + 1;
subject to c2{i in A+1..IMAGES}: sum {j in 1..PIXELS} (D[i,j] * x[j]) - y[i] <= b - 1;

subject to select1{j in 1..PIXELS}: # selection constraints
	-M*bin[j] <= x[j];
subject to select2{j in 1..PIXELS}:
	 x[j] <= M*bin[j];
