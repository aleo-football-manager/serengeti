program cost_tests_calc_v001.aleo;



function greater_1:
    input r0 as u8.private;
    input r1 as u8.private;
    async greater_1 r0 r1 into r2;
    output r2 as cost_tests_calc_v001.aleo/greater_1.future;

finalize greater_1:
    input r0 as u8.public;
    input r1 as u8.public;
    gt r0 r1 into r2;


function greater_2:
    input r0 as u8.private;
    input r1 as u8.private;
    async greater_2 r0 r1 into r2;
    output r2 as cost_tests_calc_v001.aleo/greater_2.future;

finalize greater_2:
    input r0 as u8.public;
    input r1 as u8.public;
    gt r0 r1 into r2;


function greater_1_field:
    input r0 as field.private;
    input r1 as field.private;
    async greater_1_field r0 r1 into r2;
    output r2 as cost_tests_calc_v001.aleo/greater_1_field.future;

finalize greater_1_field:
    input r0 as field.public;
    input r1 as field.public;
    gt r0 r1 into r2;


function greater_2_field:
    input r0 as field.private;
    input r1 as field.private;
    async greater_2_field r0 r1 into r2;
    output r2 as cost_tests_calc_v001.aleo/greater_2_field.future;

finalize greater_2_field:
    input r0 as field.public;
    input r1 as field.public;
    gt r0 r1 into r2;


function main:
    input r0 as u8.private;
    input r1 as u8.private;
    add r0 r1 into r2;
    output r2 as u8.private;
