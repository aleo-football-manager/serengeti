program football_leaderboard_v003.aleo;

struct User:
    win as u64;
    draw as u64;
    loss as u64;
    goals_scored as u64;
    goals_conceded as u64;


mapping users:
	key as address.public;
	value as User.public;

function update_leaderboard:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as u64.private;
    input r3 as u64.private;
    assert.eq self.caller self.signer;
    async update_leaderboard r0 r1 r2 r3 into r4;
    output r4 as football_leaderboard_v003.aleo/update_leaderboard.future;

finalize update_leaderboard:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as u64.public;
    cast 0u64 0u64 0u64 0u64 0u64 into r4 as User;
    get.or_use users[r0] r4 into r5;
    cast 0u64 0u64 0u64 0u64 0u64 into r6 as User;
    get.or_use users[r1] r6 into r7;
    gt r2 r3 into r8;
    add r5.win 1u64 into r9;
    ternary r8 r9 r5.win into r10;
    is.eq r2 r3 into r11;
    add r5.draw 1u64 into r12;
    ternary r11 r12 r5.draw into r13;
    lt r2 r3 into r14;
    add r5.loss 1u64 into r15;
    ternary r14 r15 r5.loss into r16;
    add r5.goals_scored r2 into r17;
    add r5.goals_conceded r3 into r18;
    cast r10 r13 r16 r17 r18 into r19 as User;
    set r19 into users[r0];
    lt r2 r3 into r20;
    add r7.win 1u64 into r21;
    ternary r20 r21 r7.win into r22;
    is.eq r2 r3 into r23;
    add r7.draw 1u64 into r24;
    ternary r23 r24 r7.draw into r25;
    gt r2 r3 into r26;
    add r7.loss 1u64 into r27;
    ternary r26 r27 r7.loss into r28;
    add r7.goals_scored r3 into r29;
    add r7.goals_conceded r2 into r30;
    cast r22 r25 r28 r29 r30 into r31 as User;
    set r31 into users[r1];
