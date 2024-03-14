program cost_tests_calc_v005.aleo;



mapping randomness_u8:
	key as u8.public;
	value as [u8; 5u32].public;


mapping randomness_u32:
	key as u32.public;
	value as [u32; 5u32].public;

function random:
    input r0 as u8.private;
    async random r0 into r1;
    output r1 as cost_tests_calc_v005.aleo/random.future;

finalize random:
    input r0 as u8.public;
    rand.chacha into r1 as u8;
    rand.chacha into r2 as u8;
    rand.chacha into r3 as u8;
    rand.chacha into r4 as u8;
    rand.chacha into r5 as u8;
    cast  r1 r2 r3 r4 r5 into r6 as [u8; 5u32];
    set r6 into randomness_u8[r0];


closure modmod:
    input r0 as u32;
    input r1 as u32;
    input r2 as u32;
    mod r0 r1 into r3;
    mod r3 r2 into r4;
    output r4 as u32;


function prandom:
    input r0 as u32.private;
    async prandom r0 into r1;
    output r1 as cost_tests_calc_v005.aleo/prandom.future;

finalize prandom:
    input r0 as u32.public;
    rand.chacha into r1 as u32;
    mod r1 100u32 into r2;
    call modmod r1 5433452u32 100u32 into r3;
    call modmod r1 27552u32 100u32 into r4;
    call modmod r1 15433452u32 100u32 into r5;
    call modmod r1 92452u32 100u32 into r6;
    cast  r2 r3 r4 r5 r6 into r7 as [u32; 5u32];
    set r7 into randomness_u32[r0];
