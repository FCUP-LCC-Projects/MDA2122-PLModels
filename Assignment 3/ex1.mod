param n;

set V := {1..n};

param xx{V};
param y{V};
param minT{V};
param maxT{V};

var x {i in V, j in V: i!=j} binary;
var c {i in V, j in V} >=0;
var u {V} >=0, <=n-1;
var cost >=0;

minimize Cost: cost;
TotalCost: cost = sum {i in V, j in V: i!=j} c[i,j] * x[i,j];
Distance {i in V, j in V}: c[i,j] = abs(xx[i] - xx[j]) + abs(y[i] - y[j]);

subject to

R1 {i in V}: sum {j in V: j!= i} x[i,j] = 1;
R2 {i in V}: sum {j in V: j!= i} x[j,i] = 1;
R3 {i in V, j in 2..n : i!=j}: u[i] + 1 - (n-1) * (1-x[i,j]) <= u[j];



