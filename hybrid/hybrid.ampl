option solver  bonmin;
model hybrid.mod;
data data.dat;

# suffix sosno IN integer;
# let {s in STORAGE} DataAssignment[s].sosno := 1;
#     options bonmin_options "bonmin.algorithm B-Ecp bonmin.num_resolve_at_root 0";
#     options bonmin_options "bonmin.algorithm B-Ecp bonmin.num_resolve_at_root 1";
#     options bonmin_options "bonmin.algorithm B-BB bonmin.time_limit 120";

  # solve;
# display INSTANCE_SPEC;
# display NumberInstances;
# display HasTail;
# display TailTasksHours;

quit;

