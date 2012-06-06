option solver cbc;
model private/optimizer.mod;
data;


set NODE := 
    node0 node1 node2 node3 node4 node5 node6 node7 node8 node9 node10 node11 node12 node13 node14 node15 node16 node17 node18 node19 node20 node21 node22 node23 node24 node25 node26 node27 node28 node29 node30 node31 node32 node33 node34 node35 node36
;


param:    cpu_count total_memory :=  
    node0 16 8192 
node1 16 8192 
node2 16 8192 
node3 16 8192 
node4 16 8192 
node5 16 8192 
node6 16 8192 
node7 16 8192 
node8 16 8192 
node9 16 8192 
node10 16 8192 
node11 16 8192 
node12 16 8192 
node13 16 8192 
node14 16 8192 
node15 16 8192 
node16 16 8192 
node17 16 8192 
node18 16 8192 
node19 16 8192 
node20 16 8192 
node21 16 8192 
node22 16 8192 
node23 16 8192 
node24 16 8192 
node25 16 8192 
node26 16 8192 
node27 16 8192 
node28 16 8192 
node29 16 8192 
node30 16 8192 
node31 16 8192 
node32 16 8192 
node33 16 8192 
node34 16 8192 
node35 16 8192 
node36 16 8192
;

set SERVICE := 
    s1 s2 s3 s4
;


set TIME_SLA_SERVICE := 
    s1 s2 s3
;

set LOAD_SLA_SERVICE := 
    s4
;

param:       time_sla := 
    s1 5 
s2 9 
s3 5
;

param:       memory_const memory_per_cpu := 
    s1 1024 256 
s2 512 256 
s3 256 256 
s4 256 256
;


set INSTANCE :=  s1i0 s2i0 s3i0 s4i0 s1i1 s2i1 s3i1 s4i1 s1i2 s2i2 s3i2 s4i2 s1i3 s2i3 s3i3 s4i3 s1i4 s2i4 s3i4 s4i4 s1i5 s2i5 s3i5 s4i5 s1i6 s2i6 s3i6 s4i6 s1i7 s2i7 s3i7 s4i7 s1i8 s2i8 s3i8 s4i8 s1i9 s2i9 s3i9 s4i9 s1i10 s2i10 s3i10 s4i10 s1i11 s2i11 s3i11 s4i11 s1i12 s2i12 s3i12 s4i12 s1i13 s2i13 s3i13 s4i13 s1i14 s2i14 s3i14 s4i14 s1i15 s2i15 s3i15 s4i15 s1i16 s2i16 s3i16 s4i16 s1i17 s2i17 s3i17 s4i17 s1i18 s2i18 s3i18 s4i18 s1i19 s2i19 s3i19 s4i19 s1i20 s2i20 s3i20 s4i20 s1i21 s2i21 s3i21 s4i21 s1i22 s2i22 s3i22 s4i22 s1i23 s2i23 s3i23 s4i23 s1i24 s2i24 s3i24 s4i24 s1i25 s2i25 s3i25 s4i25 s1i26 s2i26 s3i26 s4i26 s1i27 s2i27 s3i27 s4i27 s1i28 s2i28 s3i28 s4i28 s1i29 s2i29 s3i29 s4i29 s1i30 s2i30 s3i30 s4i30 s1i31 s2i31 s3i31 s4i31 s1i32 s2i32 s3i32 s4i32 s1i33 s2i33 s3i33 s4i33 s1i34 s2i34 s3i34 s4i34 s1i35 s2i35 s3i35 s4i35 s1i36 s2i36 s3i36 s4i36;

param:  vcpu_count cpu_load memory memory_usage     := 
    s1i0 2 0.8 1024  0.5 
s2i0 2 0.8 1024  0.5 
s3i0 2 0.8 1024  0.5 
s4i0 2 0.8 1024  0.5 
s1i1 2 0.8 1024  0.5 
s2i1 2 0.8 1024  0.5 
s3i1 2 0.8 1024  0.5 
s4i1 2 0.8 1024  0.5 
s1i2 2 0.8 1024  0.5 
s2i2 2 0.8 1024  0.5 
s3i2 2 0.8 1024  0.5 
s4i2 2 0.8 1024  0.5 
s1i3 2 0.8 1024  0.5 
s2i3 2 0.8 1024  0.5 
s3i3 2 0.8 1024  0.5 
s4i3 2 0.8 1024  0.5 
s1i4 2 0.8 1024  0.5 
s2i4 2 0.8 1024  0.5 
s3i4 2 0.8 1024  0.5 
s4i4 2 0.8 1024  0.5 
s1i5 2 0.8 1024  0.5 
s2i5 2 0.8 1024  0.5 
s3i5 2 0.8 1024  0.5 
s4i5 2 0.8 1024  0.5 
s1i6 2 0.8 1024  0.5 
s2i6 2 0.8 1024  0.5 
s3i6 2 0.8 1024  0.5 
s4i6 2 0.8 1024  0.5 
s1i7 2 0.8 1024  0.5 
s2i7 2 0.8 1024  0.5 
s3i7 2 0.8 1024  0.5 
s4i7 2 0.8 1024  0.5 
s1i8 2 0.8 1024  0.5 
s2i8 2 0.8 1024  0.5 
s3i8 2 0.8 1024  0.5 
s4i8 2 0.8 1024  0.5 
s1i9 2 0.8 1024  0.5 
s2i9 2 0.8 1024  0.5 
s3i9 2 0.8 1024  0.5 
s4i9 2 0.8 1024  0.5 
s1i10 2 0.8 1024  0.5 
s2i10 2 0.8 1024  0.5 
s3i10 2 0.8 1024  0.5 
s4i10 2 0.8 1024  0.5 
s1i11 2 0.8 1024  0.5 
s2i11 2 0.8 1024  0.5 
s3i11 2 0.8 1024  0.5 
s4i11 2 0.8 1024  0.5 
s1i12 2 0.8 1024  0.5 
s2i12 2 0.8 1024  0.5 
s3i12 2 0.8 1024  0.5 
s4i12 2 0.8 1024  0.5 
s1i13 2 0.8 1024  0.5 
s2i13 2 0.8 1024  0.5 
s3i13 2 0.8 1024  0.5 
s4i13 2 0.8 1024  0.5 
s1i14 2 0.8 1024  0.5 
s2i14 2 0.8 1024  0.5 
s3i14 2 0.8 1024  0.5 
s4i14 2 0.8 1024  0.5 
s1i15 2 0.8 1024  0.5 
s2i15 2 0.8 1024  0.5 
s3i15 2 0.8 1024  0.5 
s4i15 2 0.8 1024  0.5 
s1i16 2 0.8 1024  0.5 
s2i16 2 0.8 1024  0.5 
s3i16 2 0.8 1024  0.5 
s4i16 2 0.8 1024  0.5 
s1i17 2 0.8 1024  0.5 
s2i17 2 0.8 1024  0.5 
s3i17 2 0.8 1024  0.5 
s4i17 2 0.8 1024  0.5 
s1i18 2 0.8 1024  0.5 
s2i18 2 0.8 1024  0.5 
s3i18 2 0.8 1024  0.5 
s4i18 2 0.8 1024  0.5 
s1i19 2 0.8 1024  0.5 
s2i19 2 0.8 1024  0.5 
s3i19 2 0.8 1024  0.5 
s4i19 2 0.8 1024  0.5 
s1i20 2 0.8 1024  0.5 
s2i20 2 0.8 1024  0.5 
s3i20 2 0.8 1024  0.5 
s4i20 2 0.8 1024  0.5 
s1i21 2 0.8 1024  0.5 
s2i21 2 0.8 1024  0.5 
s3i21 2 0.8 1024  0.5 
s4i21 2 0.8 1024  0.5 
s1i22 2 0.8 1024  0.5 
s2i22 2 0.8 1024  0.5 
s3i22 2 0.8 1024  0.5 
s4i22 2 0.8 1024  0.5 
s1i23 2 0.8 1024  0.5 
s2i23 2 0.8 1024  0.5 
s3i23 2 0.8 1024  0.5 
s4i23 2 0.8 1024  0.5 
s1i24 2 0.8 1024  0.5 
s2i24 2 0.8 1024  0.5 
s3i24 2 0.8 1024  0.5 
s4i24 2 0.8 1024  0.5 
s1i25 2 0.8 1024  0.5 
s2i25 2 0.8 1024  0.5 
s3i25 2 0.8 1024  0.5 
s4i25 2 0.8 1024  0.5 
s1i26 2 0.8 1024  0.5 
s2i26 2 0.8 1024  0.5 
s3i26 2 0.8 1024  0.5 
s4i26 2 0.8 1024  0.5 
s1i27 2 0.8 1024  0.5 
s2i27 2 0.8 1024  0.5 
s3i27 2 0.8 1024  0.5 
s4i27 2 0.8 1024  0.5 
s1i28 2 0.8 1024  0.5 
s2i28 2 0.8 1024  0.5 
s3i28 2 0.8 1024  0.5 
s4i28 2 0.8 1024  0.5 
s1i29 2 0.8 1024  0.5 
s2i29 2 0.8 1024  0.5 
s3i29 2 0.8 1024  0.5 
s4i29 2 0.8 1024  0.5 
s1i30 2 0.8 1024  0.5 
s2i30 2 0.8 1024  0.5 
s3i30 2 0.8 1024  0.5 
s4i30 2 0.8 1024  0.5 
s1i31 2 0.8 1024  0.5 
s2i31 2 0.8 1024  0.5 
s3i31 2 0.8 1024  0.5 
s4i31 2 0.8 1024  0.5 
s1i32 2 0.8 1024  0.5 
s2i32 2 0.8 1024  0.5 
s3i32 2 0.8 1024  0.5 
s4i32 2 0.8 1024  0.5 
s1i33 2 0.8 1024  0.5 
s2i33 2 0.8 1024  0.5 
s3i33 2 0.8 1024  0.5 
s4i33 2 0.8 1024  0.5 
s1i34 2 0.8 1024  0.5 
s2i34 2 0.8 1024  0.5 
s3i34 2 0.8 1024  0.5 
s4i34 2 0.8 1024  0.5 
s1i35 2 0.8 1024  0.5 
s2i35 2 0.8 1024  0.5 
s3i35 2 0.8 1024  0.5 
s4i35 2 0.8 1024  0.5 
s1i36 2 0.8 1024  0.5 
s2i36 2 0.8 1024  0.5 
s3i36 2 0.8 1024  0.5 
s4i36 2 0.8 1024  0.5
;

param:  response_time     := 
    s1i0 10 
s2i0 10 
s3i0 10 
s1i1 10 
s2i1 10 
s3i1 10 
s1i2 10 
s2i2 10 
s3i2 10 
s1i3 10 
s2i3 10 
s3i3 10 
s1i4 10 
s2i4 10 
s3i4 10 
s1i5 10 
s2i5 10 
s3i5 10 
s1i6 10 
s2i6 10 
s3i6 10 
s1i7 10 
s2i7 10 
s3i7 10 
s1i8 10 
s2i8 10 
s3i8 10 
s1i9 10 
s2i9 10 
s3i9 10 
s1i10 10 
s2i10 10 
s3i10 10 
s1i11 10 
s2i11 10 
s3i11 10 
s1i12 10 
s2i12 10 
s3i12 10 
s1i13 10 
s2i13 10 
s3i13 10 
s1i14 10 
s2i14 10 
s3i14 10 
s1i15 10 
s2i15 10 
s3i15 10 
s1i16 10 
s2i16 10 
s3i16 10 
s1i17 10 
s2i17 10 
s3i17 10 
s1i18 10 
s2i18 10 
s3i18 10 
s1i19 10 
s2i19 10 
s3i19 10 
s1i20 10 
s2i20 10 
s3i20 10 
s1i21 10 
s2i21 10 
s3i21 10 
s1i22 10 
s2i22 10 
s3i22 10 
s1i23 10 
s2i23 10 
s3i23 10 
s1i24 10 
s2i24 10 
s3i24 10 
s1i25 10 
s2i25 10 
s3i25 10 
s1i26 10 
s2i26 10 
s3i26 10 
s1i27 10 
s2i27 10 
s3i27 10 
s1i28 10 
s2i28 10 
s3i28 10 
s1i29 10 
s2i29 10 
s3i29 10 
s1i30 10 
s2i30 10 
s3i30 10 
s1i31 10 
s2i31 10 
s3i31 10 
s1i32 10 
s2i32 10 
s3i32 10 
s1i33 10 
s2i33 10 
s3i33 10 
s1i34 10 
s2i34 10 
s3i34 10 
s1i35 10 
s2i35 10 
s3i35 10 
s1i36 10 
s2i36 10 
s3i36 10
;

set INSTANCE_SPEC :=
    (node0, s1, s1i0)  
(node0, s2, s2i0)  
(node0, s3, s3i0)  
(node0, s4, s4i0)  
(node1, s1, s1i1)  
(node1, s2, s2i1)  
(node1, s3, s3i1)  
(node1, s4, s4i1)  
(node2, s1, s1i2)  
(node2, s2, s2i2)  
(node2, s3, s3i2)  
(node2, s4, s4i2)  
(node3, s1, s1i3)  
(node3, s2, s2i3)  
(node3, s3, s3i3)  
(node3, s4, s4i3)  
(node4, s1, s1i4)  
(node4, s2, s2i4)  
(node4, s3, s3i4)  
(node4, s4, s4i4)  
(node5, s1, s1i5)  
(node5, s2, s2i5)  
(node5, s3, s3i5)  
(node5, s4, s4i5)  
(node6, s1, s1i6)  
(node6, s2, s2i6)  
(node6, s3, s3i6)  
(node6, s4, s4i6)  
(node7, s1, s1i7)  
(node7, s2, s2i7)  
(node7, s3, s3i7)  
(node7, s4, s4i7)  
(node8, s1, s1i8)  
(node8, s2, s2i8)  
(node8, s3, s3i8)  
(node8, s4, s4i8)  
(node9, s1, s1i9)  
(node9, s2, s2i9)  
(node9, s3, s3i9)  
(node9, s4, s4i9)  
(node10, s1, s1i10)  
(node10, s2, s2i10)  
(node10, s3, s3i10)  
(node10, s4, s4i10)  
(node11, s1, s1i11)  
(node11, s2, s2i11)  
(node11, s3, s3i11)  
(node11, s4, s4i11)  
(node12, s1, s1i12)  
(node12, s2, s2i12)  
(node12, s3, s3i12)  
(node12, s4, s4i12)  
(node13, s1, s1i13)  
(node13, s2, s2i13)  
(node13, s3, s3i13)  
(node13, s4, s4i13)  
(node14, s1, s1i14)  
(node14, s2, s2i14)  
(node14, s3, s3i14)  
(node14, s4, s4i14)  
(node15, s1, s1i15)  
(node15, s2, s2i15)  
(node15, s3, s3i15)  
(node15, s4, s4i15)  
(node16, s1, s1i16)  
(node16, s2, s2i16)  
(node16, s3, s3i16)  
(node16, s4, s4i16)  
(node17, s1, s1i17)  
(node17, s2, s2i17)  
(node17, s3, s3i17)  
(node17, s4, s4i17)  
(node18, s1, s1i18)  
(node18, s2, s2i18)  
(node18, s3, s3i18)  
(node18, s4, s4i18)  
(node19, s1, s1i19)  
(node19, s2, s2i19)  
(node19, s3, s3i19)  
(node19, s4, s4i19)  
(node20, s1, s1i20)  
(node20, s2, s2i20)  
(node20, s3, s3i20)  
(node20, s4, s4i20)  
(node21, s1, s1i21)  
(node21, s2, s2i21)  
(node21, s3, s3i21)  
(node21, s4, s4i21)  
(node22, s1, s1i22)  
(node22, s2, s2i22)  
(node22, s3, s3i22)  
(node22, s4, s4i22)  
(node23, s1, s1i23)  
(node23, s2, s2i23)  
(node23, s3, s3i23)  
(node23, s4, s4i23)  
(node24, s1, s1i24)  
(node24, s2, s2i24)  
(node24, s3, s3i24)  
(node24, s4, s4i24)  
(node25, s1, s1i25)  
(node25, s2, s2i25)  
(node25, s3, s3i25)  
(node25, s4, s4i25)  
(node26, s1, s1i26)  
(node26, s2, s2i26)  
(node26, s3, s3i26)  
(node26, s4, s4i26)  
(node27, s1, s1i27)  
(node27, s2, s2i27)  
(node27, s3, s3i27)  
(node27, s4, s4i27)  
(node28, s1, s1i28)  
(node28, s2, s2i28)  
(node28, s3, s3i28)  
(node28, s4, s4i28)  
(node29, s1, s1i29)  
(node29, s2, s2i29)  
(node29, s3, s3i29)  
(node29, s4, s4i29)  
(node30, s1, s1i30)  
(node30, s2, s2i30)  
(node30, s3, s3i30)  
(node30, s4, s4i30)  
(node31, s1, s1i31)  
(node31, s2, s2i31)  
(node31, s3, s3i31)  
(node31, s4, s4i31)  
(node32, s1, s1i32)  
(node32, s2, s2i32)  
(node32, s3, s3i32)  
(node32, s4, s4i32)  
(node33, s1, s1i33)  
(node33, s2, s2i33)  
(node33, s3, s3i33)  
(node33, s4, s4i33)  
(node34, s1, s1i34)  
(node34, s2, s2i34)  
(node34, s3, s3i34)  
(node34, s4, s4i34)  
(node35, s1, s1i35)  
(node35, s2, s2i35)  
(node35, s3, s3i35)  
(node35, s4, s4i35)  
(node36, s1, s1i36)  
(node36, s2, s2i36)  
(node36, s3, s3i36)  
(node36, s4, s4i36) 
;

display SERVICE;
display NODE;
display INSTANCE;

display cpu_count;
display vcpu_count;
display service_vcpu_count;
display new_vcpu_count;

display NODE_INSTANCE;


# check;

solve;


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


printf "ampl:\n";
printf "    cost: %d\n", Cost;
printf "    solve_message: '%s'\n", solve_message;
printf "    solve_exit_code: '%s'\n", solve_exitcode;
printf "    solve_result_num: '%s'\n", solve_result_num;
printf "    solve_result: '%s'\n", solve_result;

printf "--- end ---\n";
quit;