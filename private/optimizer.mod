set NODE;
set SERVICE;
set INSTANCE;

set TIME_SLA_SERVICE within SERVICE;
set LOAD_SLA_SERVICE within SERVICE;

set INSTANCE_SPEC within {NODE,SERVICE,INSTANCE};

set SERVICE_INSTANCE {s in SERVICE} within INSTANCE := setof {(n,s,i) in INSTANCE_SPEC} i;
set NODE_INSTANCE {n in NODE} within INSTANCE:= setof {(n,s,i) in INSTANCE_SPEC} i;

set TIME_SLA_INSTANCE within INSTANCE := setof {(n,s,i) in INSTANCE_SPEC: s in TIME_SLA_SERVICE} i;
set LOAD_SLA_INSTANCE within INSTANCE := setof {(n,s,i) in INSTANCE_SPEC: s in LOAD_SLA_SERVICE} i;

param cpu_count {NODE} > 0 integer;
param total_memory {NODE} > 0 integer;
param time_sla {TIME_SLA_SERVICE} > 0;
param vcpu_count {INSTANCE} > 0 integer;
param memory {INSTANCE} > 0 integer;
param memory_usage {INSTANCE} >= 0 <= 1;
param response_time {TIME_SLA_INSTANCE} > 0;
param cpu_load {INSTANCE} >= 0 <= 1;
param memory_const {SERVICE} > 0 integer;
param memory_per_cpu {SERVICE} > 0 integer;

param service_vcpu_count {s in SERVICE} := sum {i in SERVICE_INSTANCE[s]} vcpu_count[i];
param avg_response_time {s in TIME_SLA_SERVICE} := (sum {i in SERVICE_INSTANCE[s]} response_time[i])/card(SERVICE_INSTANCE[s]);
param new_vcpu_count {s in SERVICE} := if s in TIME_SLA_SERVICE then 
          max(ceil(avg_response_time[s]/time_sla[s]*service_vcpu_count[s]),1)
        else
          max(ceil((sum {i in LOAD_SLA_INSTANCE} cpu_load[i])/card(LOAD_SLA_INSTANCE)/0.8*service_vcpu_count[s]),1);
param free_vcpus := sum {n in NODE} cpu_count[n] - sum {i in INSTANCE} vcpu_count[i];


check {n in NODE}: sum {i in NODE_INSTANCE[n]} vcpu_count[i] <= cpu_count[n]; # ensure that input is correct
check: sum {s in SERVICE} new_vcpu_count[s] <= sum {n in NODE} cpu_count[n]; # ensure that input is correct

var KeepInstance {i in INSTANCE} binary;
var NewVM {s in SERVICE, n in NODE} integer >= 0 <= cpu_count[n];
var AddVCPUs {s in SERVICE, n in NODE} binary;

# var FreeVCPUs {n in NODE} integer >= 0 <= cpu_count[n];


minimize Cost: sum {i in INSTANCE} (1-KeepInstance[i]) + sum {s in SERVICE, n in NODE} AddVCPUs[s,n];

subject to
  RequiredVCPUCount {s in SERVICE}: 
    sum {i in SERVICE_INSTANCE[s]} KeepInstance[i]*vcpu_count[i] + sum{n in NODE} NewVM[s,n] >= new_vcpu_count[s];

  MaxVCPUPerNode {n in NODE}: 
    sum {i in NODE_INSTANCE[n]} KeepInstance[i]*vcpu_count[i] + sum {s in SERVICE} NewVM[s,n] <= cpu_count[n] ;

  MaxMemoryPerNode {n in NODE}: 
    sum {i in NODE_INSTANCE[n]} KeepInstance[i]*memory[i] + sum {s in SERVICE} (NewVM[s,n]*memory_per_cpu[s] + AddVCPUs[s,n]*memory_const[s]) <= total_memory[n];
  
  Add1 {n in NODE, s in SERVICE}: 
    NewVM[s,n] >= AddVCPUs[s,n];
    
  Add2 {n in NODE, s in SERVICE}:     
    NewVM[s,n] <= cpu_count[n]*AddVCPUs[s,n];
    
  # FreeCPU {n in NODE}:
  #     FreeVCPUs[n] = cpu_count[n] - (sum {i in NODE_INSTANCE[n]} KeepInstance[i]*vcpu_count[i] + sum {s in SERVICE} NewVM[s,n]);
  #   
  
