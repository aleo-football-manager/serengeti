program formation_tests_v002.aleo;

struct GameOutcome:
    address_home as address;
    address_away as address;
    team_id_home as u8;
    team_id_away as u8;
    goals_home as u64;
    goals_away as u64;

struct Player:
    player_id as u8;
    team_id as u8;
    position as field;
    attack as u8;
    defense as u8;
    speed as u8;
    power as u8;
    stamina as u8;
    technique as u8;
    goalkeeping as u8;

struct ValidationDetails:
    amount_goalkeepers as u8;
    same_team as boolean;
    wrong_team_index as u8;


mapping players:
	key as u8.public;
	value as Player.public;


mapping valid_formations:
	key as u8.public;
	value as boolean.public;


mapping game_outcomes:
	key as address.public;
	value as GameOutcome.public;


mapping validation_details:
	key as u8.public;
	value as ValidationDetails.public;

function add_player:
    input r0 as Player.private;
    async add_player r0 into r1;
    output r1 as formation_tests_v002.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    set r0 into players[r0.player_id];


function validate_formation:
    input r0 as u8.private;
    input r1 as [u8; 11u32].private;
    async validate_formation r0 r1 into r2;
    output r2 as formation_tests_v002.aleo/validate_formation.future;

finalize validate_formation:
    input r0 as u8.public;
    input r1 as [u8; 11u32].public;
    get players[r1[0u32]] into r2;
    get players[r1[1u32]] into r3;
    is.eq r3.position 1field into r4;
    add 0u8 1u8 into r5;
    ternary r4 r5 0u8 into r6;
    is.neq r3.team_id r2.team_id into r7;
    ternary r7 false true into r8;
    ternary r7 1u8 0u8 into r9;
    get players[r1[2u32]] into r10;
    is.eq r10.position 1field into r11;
    add r6 1u8 into r12;
    ternary r11 r12 r6 into r13;
    is.neq r10.team_id r2.team_id into r14;
    ternary r14 false r8 into r15;
    ternary r14 2u8 r9 into r16;
    get players[r1[3u32]] into r17;
    is.eq r17.position 1field into r18;
    add r13 1u8 into r19;
    ternary r18 r19 r13 into r20;
    is.neq r17.team_id r2.team_id into r21;
    ternary r21 false r15 into r22;
    ternary r21 3u8 r16 into r23;
    get players[r1[4u32]] into r24;
    is.eq r24.position 1field into r25;
    add r20 1u8 into r26;
    ternary r25 r26 r20 into r27;
    is.neq r24.team_id r2.team_id into r28;
    ternary r28 false r22 into r29;
    ternary r28 4u8 r23 into r30;
    get players[r1[5u32]] into r31;
    is.eq r31.position 1field into r32;
    add r27 1u8 into r33;
    ternary r32 r33 r27 into r34;
    is.neq r31.team_id r2.team_id into r35;
    ternary r35 false r29 into r36;
    ternary r35 5u8 r30 into r37;
    get players[r1[6u32]] into r38;
    is.eq r38.position 1field into r39;
    add r34 1u8 into r40;
    ternary r39 r40 r34 into r41;
    is.neq r38.team_id r2.team_id into r42;
    ternary r42 false r36 into r43;
    ternary r42 6u8 r37 into r44;
    get players[r1[7u32]] into r45;
    is.eq r45.position 1field into r46;
    add r41 1u8 into r47;
    ternary r46 r47 r41 into r48;
    is.neq r45.team_id r2.team_id into r49;
    ternary r49 false r43 into r50;
    ternary r49 7u8 r44 into r51;
    get players[r1[8u32]] into r52;
    is.eq r52.position 1field into r53;
    add r48 1u8 into r54;
    ternary r53 r54 r48 into r55;
    is.neq r52.team_id r2.team_id into r56;
    ternary r56 false r50 into r57;
    ternary r56 8u8 r51 into r58;
    get players[r1[9u32]] into r59;
    is.eq r59.position 1field into r60;
    add r55 1u8 into r61;
    ternary r60 r61 r55 into r62;
    is.neq r59.team_id r2.team_id into r63;
    ternary r63 false r57 into r64;
    ternary r63 9u8 r58 into r65;
    get players[r1[10u32]] into r66;
    is.eq r66.position 1field into r67;
    add r62 1u8 into r68;
    ternary r67 r68 r62 into r69;
    is.neq r66.team_id r2.team_id into r70;
    ternary r70 false r64 into r71;
    ternary r70 10u8 r65 into r72;
    is.eq r69 1u8 into r73;
    and r71 r73 into r74;
    set r74 into valid_formations[r0];
    cast r69 r71 r72 into r75 as ValidationDetails;
    set r75 into validation_details[r0];
