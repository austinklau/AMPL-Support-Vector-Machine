param IMAGES; 
param PIXELS; # 784

param D{1..IMAGES, 1..PIXELS}; 

param A; # number of images of type A
param lambda; # relative importance factor

var x{1..PIXELS}; # weights for each type of data (pixels)
var y{1..IMAGES} >= 0; # classification error for each images
var b; # threshold

var class_error = (sum {j in 1..A} y[j]) / A + (sum {j in A+1..IMAGES} y[j]) / (IMAGES-A);
var sum_squares = (sum {j in 1..PIXELS} x[j]^2);

minimize avgError : class_error + sum_squares * lambda;


subject to c1{i in 1..A}: sum {j in 1..PIXELS} (D[i,j] * x[j]) + y[i] >= b + 1;
subject to c2{i in A+1..IMAGES}: sum {j in 1..PIXELS} (D[i,j] * x[j]) - y[i] <= b - 1;
