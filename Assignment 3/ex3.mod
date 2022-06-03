param n;

set V := {1..n};

param xx{V};
param y{V};
param minT{V};
param maxT{V};

var x {i in V, j in V: i!= j} binary;
var c {i in V, j in V: i!= j};
var m {i in V, j in V: i!= j} >=0.01;
var int_lead {V} >= 0, integer;
var int_lag {V} >= 0, integer;
var t {V} >= 0, integer;
var leadlag >= 0, integer;

var costs integer, >=0;

minimize Cost: costs;


TotalCost: costs = sum {i in V, j in V: i!=j} c[i,j] * x[i,j];
LL: leadlag = sum {j in V} (int_lead[j] + int_lag[j]);
Time {i in V, j in V: i!=j}: c[i,j] = abs(xx[i] - xx[j]) + abs(y[i] - y[j]);

R1 {i in V}: sum {j in V: j!= i} x[i,j] = 1;
R2 {i in V}: sum {j in V: j!= i} x[j,i] = 1;
R3 {i in V, j in V: j!=1 and i!=j}: t[i] + c[i,j] - m[i,j]*(1-x[i,j]) <= t[j];
R4 {i in V, j in V: j!=1 and i!=j}: m[i,j] >= maxT[i] + c[i,j] - minT[j];
R5 {j in V}: int_lead[j] >= minT[j] - t[j];
R6 {j in V}: int_lag[j] >= t[j]- maxT[j];
R7: leadlag <= 195;