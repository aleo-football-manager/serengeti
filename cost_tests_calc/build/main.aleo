program cost_tests_calc_v014.aleo;

struct GameOutcome:
    address_home as address;
    address_away as address;
    team_id_home as field;
    team_id_away as field;
    goals_home as u64;
    goals_away as u64;

struct Player:
    player_id as field;
    team_id as field;
    position as field;
    attack as u128;
    defense as u128;
    speed as u128;
    power as u128;
    stamina as u128;
    technique as u128;
    goalkeeping as u128;


mapping game_outcomes:
	key as address.public;
	value as GameOutcome.public;


mapping players:
	key as field.public;
	value as Player.public;


mapping goalie:
	key as address.public;
	value as Player.public;


mapping fieldie:
	key as address.public;
	value as Player.public;

function add_player:
    input r0 as Player.private;
    async add_player r0 into r1;
    output r1 as cost_tests_calc_v014.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    set r0 into players[r0.player_id];


function calculate_outcome_sat_1:
    input r0 as [field; 11u32].private;
    input r1 as [field; 11u32].private;
    async calculate_outcome_sat_1 r0 r1 into r2;
    output r2 as cost_tests_calc_v014.aleo/calculate_outcome_sat_1.future;

finalize calculate_outcome_sat_1:
    input r0 as [field; 11u32].public;
    input r1 as [field; 11u32].public;
    get players[r0[0u32]] into r2;
    get players[r1[0u32]] into r3;
    get players[r0[1u32]] into r4;
    get players[r1[1u32]] into r5;
    rand.chacha into r6 as u128;
    mod r6 234272u128 into r7;
    mod r7 200u128 into r8;
    mod r6 2341272u128 into r9;
    mod r9 200u128 into r10;
    mod r6 234234272u128 into r11;
    mod r11 100u128 into r12;
    add r4.speed r5.speed into r13;
    mod r6 r13 into r14;
    lt r14 r4.speed into r15;
    ternary r15 r4.player_id r5.player_id into r16;
    ternary r15 r4.team_id r5.team_id into r17;
    ternary r15 r4.position r5.position into r18;
    ternary r15 r4.attack r5.attack into r19;
    ternary r15 r4.defense r5.defense into r20;
    ternary r15 r4.speed r5.speed into r21;
    ternary r15 r4.power r5.power into r22;
    ternary r15 r4.stamina r5.stamina into r23;
    ternary r15 r4.technique r5.technique into r24;
    ternary r15 r4.goalkeeping r5.goalkeeping into r25;
    cast r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 into r26 as Player;
    ternary r15 r5.player_id r4.player_id into r27;
    ternary r15 r5.team_id r4.team_id into r28;
    ternary r15 r5.position r4.position into r29;
    ternary r15 r5.attack r4.attack into r30;
    ternary r15 r5.defense r4.defense into r31;
    ternary r15 r5.speed r4.speed into r32;
    ternary r15 r5.power r4.power into r33;
    ternary r15 r5.stamina r4.stamina into r34;
    ternary r15 r5.technique r4.technique into r35;
    ternary r15 r5.goalkeeping r4.goalkeeping into r36;
    cast r27 r28 r29 r30 r31 r32 r33 r34 r35 r36 into r37 as Player;
    ternary r15 r3.player_id r2.player_id into r38;
    ternary r15 r3.team_id r2.team_id into r39;
    ternary r15 r3.position r2.position into r40;
    ternary r15 r3.attack r2.attack into r41;
    ternary r15 r3.defense r2.defense into r42;
    ternary r15 r3.speed r2.speed into r43;
    ternary r15 r3.power r2.power into r44;
    ternary r15 r3.stamina r2.stamina into r45;
    ternary r15 r3.technique r2.technique into r46;
    ternary r15 r3.goalkeeping r2.goalkeeping into r47;
    cast r38 r39 r40 r41 r42 r43 r44 r45 r46 r47 into r48 as Player;
    add r26.attack r26.power into r49;
    add r37.defense r37.technique into r50;
    gt r49 r8 into r51;
    lt r50 r10 into r52;
    lt r48.goalkeeping r12 into r53;
    add 0u64 1u64 into r54;
    add 0u64 1u64 into r55;
    ternary r15 r54 0u64 into r56;
    ternary r15 0u64 r55 into r57;
    ternary r53 r56 0u64 into r58;
    ternary r53 r57 0u64 into r59;
    ternary r52 r58 0u64 into r60;
    ternary r52 r59 0u64 into r61;
    ternary r51 r60 0u64 into r62;
    ternary r51 r61 0u64 into r63;
    cast aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm r4.team_id r4.team_id r62 r63 into r64 as GameOutcome;
    set r64 into game_outcomes[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
    set r2 into goalie[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
    set r4 into fieldie[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];


function calculate_outcome_sat_1s:
    input r0 as [field; 11u32].private;
    input r1 as [field; 11u32].private;
    async calculate_outcome_sat_1s r0 r1 into r2;
    output r2 as cost_tests_calc_v014.aleo/calculate_outcome_sat_1s.future;

finalize calculate_outcome_sat_1s:
    input r0 as [field; 11u32].public;
    input r1 as [field; 11u32].public;
    get players[r0[0u32]] into r2;
    get players[r1[0u32]] into r3;
    get players[r0[1u32]] into r4;
    get players[r1[1u32]] into r5;
    rand.chacha into r6 as u128;
    mod r6 234272u128 into r7;
    mod r7 200u128 into r8;
    mod r6 2341272u128 into r9;
    mod r9 200u128 into r10;
    mod r6 234234272u128 into r11;
    mod r11 100u128 into r12;
    add r4.speed r5.speed into r13;
    mod r6 r13 into r14;
    lt r14 r4.speed into r15;
    ternary r15 r4.player_id r5.player_id into r16;
    ternary r15 r4.team_id r5.team_id into r17;
    ternary r15 r4.position r5.position into r18;
    ternary r15 r4.attack r5.attack into r19;
    ternary r15 r4.defense r5.defense into r20;
    ternary r15 r4.speed r5.speed into r21;
    ternary r15 r4.power r5.power into r22;
    ternary r15 r4.stamina r5.stamina into r23;
    ternary r15 r4.technique r5.technique into r24;
    ternary r15 r4.goalkeeping r5.goalkeeping into r25;
    cast r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 into r26 as Player;
    ternary r15 r5.player_id r4.player_id into r27;
    ternary r15 r5.team_id r4.team_id into r28;
    ternary r15 r5.position r4.position into r29;
    ternary r15 r5.attack r4.attack into r30;
    ternary r15 r5.defense r4.defense into r31;
    ternary r15 r5.speed r4.speed into r32;
    ternary r15 r5.power r4.power into r33;
    ternary r15 r5.stamina r4.stamina into r34;
    ternary r15 r5.technique r4.technique into r35;
    ternary r15 r5.goalkeeping r4.goalkeeping into r36;
    cast r27 r28 r29 r30 r31 r32 r33 r34 r35 r36 into r37 as Player;
    ternary r15 r3.player_id r2.player_id into r38;
    ternary r15 r3.team_id r2.team_id into r39;
    ternary r15 r3.position r2.position into r40;
    ternary r15 r3.attack r2.attack into r41;
    ternary r15 r3.defense r2.defense into r42;
    ternary r15 r3.speed r2.speed into r43;
    ternary r15 r3.power r2.power into r44;
    ternary r15 r3.stamina r2.stamina into r45;
    ternary r15 r3.technique r2.technique into r46;
    ternary r15 r3.goalkeeping r2.goalkeeping into r47;
    cast r38 r39 r40 r41 r42 r43 r44 r45 r46 r47 into r48 as Player;
    gt r26.attack r8 into r49;
    lt r37.defense r10 into r50;
    lt r48.goalkeeping r12 into r51;
    add 0u64 1u64 into r52;
    add 0u64 1u64 into r53;
    ternary r15 r52 0u64 into r54;
    ternary r15 0u64 r53 into r55;
    ternary r51 r54 0u64 into r56;
    ternary r51 r55 0u64 into r57;
    ternary r50 r56 0u64 into r58;
    ternary r50 r57 0u64 into r59;
    ternary r49 r58 0u64 into r60;
    ternary r49 r59 0u64 into r61;
    cast aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm r4.team_id r4.team_id r60 r61 into r62 as GameOutcome;
    set r62 into game_outcomes[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
    set r2 into goalie[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
    set r4 into fieldie[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];


function calculate_outcome_sat_2s:
    input r0 as [field; 11u32].private;
    input r1 as [field; 11u32].private;
    async calculate_outcome_sat_2s r0 r1 into r2;
    output r2 as cost_tests_calc_v014.aleo/calculate_outcome_sat_2s.future;

finalize calculate_outcome_sat_2s:
    input r0 as [field; 11u32].public;
    input r1 as [field; 11u32].public;
    get players[r0[0u32]] into r2;
    get players[r1[0u32]] into r3;
    get players[r0[1u32]] into r4;
    get players[r1[1u32]] into r5;
    rand.chacha into r6 as u128;
    mod r6 234272u128 into r7;
    mod r7 200u128 into r8;
    mod r6 2341272u128 into r9;
    mod r9 200u128 into r10;
    mod r6 234234272u128 into r11;
    mod r11 100u128 into r12;
    mod r6 91234272u128 into r13;
    mod r13 100u128 into r14;
    mod r6 2272u128 into r15;
    mod r15 100u128 into r16;
    add r4.speed r5.speed into r17;
    mod r6 r17 into r18;
    lt r18 r4.speed into r19;
    ternary r19 r4.player_id r5.player_id into r20;
    ternary r19 r4.team_id r5.team_id into r21;
    ternary r19 r4.position r5.position into r22;
    ternary r19 r4.attack r5.attack into r23;
    ternary r19 r4.defense r5.defense into r24;
    ternary r19 r4.speed r5.speed into r25;
    ternary r19 r4.power r5.power into r26;
    ternary r19 r4.stamina r5.stamina into r27;
    ternary r19 r4.technique r5.technique into r28;
    ternary r19 r4.goalkeeping r5.goalkeeping into r29;
    cast r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 into r30 as Player;
    ternary r19 r5.player_id r4.player_id into r31;
    ternary r19 r5.team_id r4.team_id into r32;
    ternary r19 r5.position r4.position into r33;
    ternary r19 r5.attack r4.attack into r34;
    ternary r19 r5.defense r4.defense into r35;
    ternary r19 r5.speed r4.speed into r36;
    ternary r19 r5.power r4.power into r37;
    ternary r19 r5.stamina r4.stamina into r38;
    ternary r19 r5.technique r4.technique into r39;
    ternary r19 r5.goalkeeping r4.goalkeeping into r40;
    cast r31 r32 r33 r34 r35 r36 r37 r38 r39 r40 into r41 as Player;
    ternary r19 r3.player_id r2.player_id into r42;
    ternary r19 r3.team_id r2.team_id into r43;
    ternary r19 r3.position r2.position into r44;
    ternary r19 r3.attack r2.attack into r45;
    ternary r19 r3.defense r2.defense into r46;
    ternary r19 r3.speed r2.speed into r47;
    ternary r19 r3.power r2.power into r48;
    ternary r19 r3.stamina r2.stamina into r49;
    ternary r19 r3.technique r2.technique into r50;
    ternary r19 r3.goalkeeping r2.goalkeeping into r51;
    cast r42 r43 r44 r45 r46 r47 r48 r49 r50 r51 into r52 as Player;
    gt r30.attack r8 into r53;
    lt r41.defense r10 into r54;
    gt r30.power r14 into r55;
    lt r41.technique r16 into r56;
    lt r52.goalkeeping r12 into r57;
    add 0u64 1u64 into r58;
    add 0u64 1u64 into r59;
    ternary r19 r58 0u64 into r60;
    ternary r19 0u64 r59 into r61;
    ternary r57 r60 0u64 into r62;
    ternary r57 r61 0u64 into r63;
    ternary r56 r62 0u64 into r64;
    ternary r56 r63 0u64 into r65;
    ternary r55 r64 0u64 into r66;
    ternary r55 r65 0u64 into r67;
    ternary r54 r66 0u64 into r68;
    ternary r54 r67 0u64 into r69;
    ternary r53 r68 0u64 into r70;
    ternary r53 r69 0u64 into r71;
    cast aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm r4.team_id r4.team_id r70 r71 into r72 as GameOutcome;
    set r72 into game_outcomes[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
    set r2 into goalie[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
    set r4 into fieldie[aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm];
