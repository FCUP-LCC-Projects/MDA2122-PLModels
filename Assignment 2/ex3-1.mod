set SKILLS;
set TASKS;

param profit{TASKS};
param c{TASKS};
param py{TASKS};
param web{TASKS};

param hours{SKILLS};
param h_cost{SKILLS};
param known_c{SKILLS};
param known_py{SKILLS};
param known_web{SKILLS};

var x{SKILLS, TASKS} <=1, >=0;
var revenue >=0;
var prog_cost >=0;
var h_c{SKILLS, TASKS} >=0, integer;
var h_py{SKILLS, TASKS} >=0, integer;
var h_web{SKILLS, TASKS} >=0 integer;
var task_rate{TASKS} >=0, <= 1, integer;

maximize z: revenue - prog_cost;

REV: revenue = sum {i in SKILLS, j in TASKS} profit[j] * x[i,j];
COST : prog_cost = sum{i in SKILLS, j in TASKS} (h_c[i,j] + h_py[i,j] + h_web[i,j]) * h_cost[i];


R2 {i in SKILLS}: sum {j in TASKS} (h_c[i,j] + h_py[i,j] + h_web[i,j]) <= hours[i] ;
R3 {j in TASKS}: sum {i in SKILLS} (h_c[i,j] * known_c[i] + h_py[i,j] * known_py[i] + h_web[i,j] * known_web[i]) = sum {i in SKILLS} (h_c[i,j] + h_py[i,j] + h_web[i,j]);
R4 {i in SKILLS, j in TASKS}: x[i,j] = (h_c[i,j] + h_py[i,j] + h_web[i,j]) /(c[j] + py[j] + web[j]);
R5 {j in TASKS}: sum {i in SKILLS} h_c[i,j] <= c[j];
R6 {j in TASKS}: sum {i in SKILLS} h_py[i,j] <= py[j];
R7 {j in TASKS}: sum {i in SKILLS} h_web[i,j] <= web[j];
R8 {j in TASKS}: task_rate[j] = sum {i in SKILLS} x[i,j];
