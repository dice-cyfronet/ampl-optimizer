option solver cbc;
model optimizer.mod;
data optimizer.dat;

check;

solve;

display service_vcpu_count;
display new_vcpu_count;

printf "--- solution ---\n";

printf("stop_vm:\n");

for {i in INSTANCE} {
  if KeepInstance[i] == 0 then
    printf "    - %s\n", i;
}

printf("start_vm:\n");


for {s in SERVICE, n in NODE} {
  if AddVCPUs[s,n] != 0 then {
    printf "    - service: %s\n", s;
    printf "      cpu: %d\n", AddVCPUs[s,n];
  }
}


printf "debug:\n";
printf "    cost: %d\n", Cost;
printf "    solve_message: '%s'\n", solve_message;

printf "--- end ---\n";