param IMAGES; 
param PIXELS; # 784

param D{1..IMAGES, 1..PIXELS}; 

param A; # number of images of type A

var x{1..PIXELS}; # weights for each type of data (pixels)
var y{1..IMAGES} >= 0; # classification error for each images
var b; # threshold

minimize avgError : (sum {i in 1..A} y[i]) / A + (sum {j in A+1..IMAGES} y[j]) / (IMAGES - A);

subject to c1{i in 1..A}: sum {j in 1..PIXELS} (D[i,j] * x[j]) + y[i] >= b + 1;
subject to c2{i in A+1..IMAGES}: sum {j in 1..PIXELS} (D[i,j] * x[j]) - y[i] <= b - 1;
