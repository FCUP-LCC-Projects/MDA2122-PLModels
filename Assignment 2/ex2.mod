set SKILLS;
set TASKS;

param profit{TASKS};
param c{TASKS};
param py{TASKS};
param web{TASKS};

param hours{SKILLS};
param h_cost{SKILLS};
param known_c{SKILLS};
param rate_c{SKILLS};
param known_py{SKILLS};
param rate_py{SKILLS};
param rate_web{SKILLS};
param known_web{SKILLS};

var x{SKILLS, TASKS} integer, <=1, >=0;
var revenue >=0;
var prog_cost >=0;

maximize z: sum {i in SKILLS} (rate_c[i] + rate_py[i] + rate_web[i]) * sum {j in TASKS} x[i,j];

REV: revenue = sum {i in SKILLS, j in TASKS} profit[j] * x[i,j];
COST : prog_cost = sum{i in SKILLS, j in TASKS} x[i,j] * (c[j] + py[j] + web[j]) * h_cost[i];


R1: revenue - prog_cost >= 505; #neste caso deu este resultado, é este o valor que "se muda"
R2 {i in SKILLS}: sum {j in TASKS} (c[j] + py[j] + web[j]) * x[i,j] <= hours[i] ;
R3 {j in TASKS}: sum {i in SKILLS} (c[j] * known_c[i] + py[j] * known_py[i] + web[j] * known_web[i]) * x[i,j] = sum {i in SKILLS} (c[j] + py[j] + web[j]) * x[i,j];
R4 {j in TASKS}: sum {i in SKILLS} x[i,j] <= 1;


