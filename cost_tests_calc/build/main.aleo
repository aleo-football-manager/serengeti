program cost_tests_calc_v011.aleo;



function test_random_p_iter:
    async test_random_p_iter into r0;
    output r0 as cost_tests_calc_v011.aleo/test_random_p_iter.future;

finalize test_random_p_iter:
    rand.chacha into r0 as u128;
    mod r0 160u128 into r1;
    mod r0 234272u128 into r2;
    mod r2 100u128 into r3;
    mod r0 2341272u128 into r4;
    mod r4 100u128 into r5;
    mod r0 234234272u128 into r6;
    mod r6 100u128 into r7;
    mod r0 91234272u128 into r8;
    mod r8 100u128 into r9;
    mod r0 2272u128 into r10;
    mod r10 100u128 into r11;
    lt 2429u128 r3 into r12;
    lt 2329802u128 r5 into r13;
    lt 21231234u128 r7 into r14;
    lt 19912912u128 r9 into r15;
    lt 2272u128 r11 into r16;
    ternary r16 true false into r17;
    ternary r15 r17 false into r18;
    ternary r14 r18 false into r19;
    ternary r13 r19 false into r20;
    ternary r12 r20 false into r21;
