set TYPE;
set INSTANCE;
set SERVICE;
set INSTANCE_SPEC within {TYPE,SERVICE,INSTANCE};

set INSTANCE_TYPE {i in INSTANCE} within TYPE := setof {(t,s,i) in INSTANCE_SPEC} t;
set TYPE_INSTANCE {t in TYPE} within INSTANCE := setof {(t,s,i) in INSTANCE_SPEC} i;
set SERVICE_INSTANCE {s in SERVICE} within INSTANCE := setof {(t,s,i) in INSTANCE_SPEC} i;


param sla {SERVICE} > 0;
param response_time {INSTANCE} > 0;
param requests_served {INSTANCE} > 0 integer;

param instance_price {TYPE} >= 0;           # price per instance hour
param ccu {TYPE} >= 0;                       # CloudHarmony Compute Units, similar to Amazon ECU, results of benchmarks from http://blog.cloudharmony.com/2010/05/what-is-ecu-cpu-benchmarking-in-cloud.html

param max_private >= 0 integer;

param work {i in INSTANCE} := sum {t in INSTANCE_TYPE[i]} ccu[t]*response_time[i];
param avg_time {s in SERVICE} := (sum {i in SERVICE_INSTANCE[s]} response_time[i]) / (sum {i in SERVICE_INSTANCE[s]} 1);
param current_ccu {s in SERVICE} := (sum {i in SERVICE_INSTANCE[s]} sum {t in INSTANCE_TYPE[i]} ccu[t]);
param new_ccu {s in SERVICE} := current_ccu[s] * avg_time[s]/sla[s];


var KeepInstance {INSTANCE} binary := 1;
var NewVM {s in SERVICE, t in TYPE} integer >= 0 <= ceil(new_ccu[s]/(min {tt in TYPE} ccu[tt])) := 0;
 

minimize TotalCost:
    sum {i in INSTANCE} (sum { t in INSTANCE_TYPE[i] } instance_price[t])*KeepInstance[i] + (sum {s in SERVICE, t in TYPE} NewVM[s,t]*instance_price[t]);

subject to
  MinCCU {s in SERVICE}:
    sum {i in SERVICE_INSTANCE[s]} (sum { t in INSTANCE_TYPE[i] } ccu[t])*KeepInstance[i] + sum {t in TYPE} NewVM[s,t]*ccu[t] >= new_ccu[s];
  MaxPrivate:
    (sum {i in TYPE_INSTANCE['private']} KeepInstance[i]) + (sum {s in SERVICE} NewVM[s, 'private']) <= max_private;