import puzzle_pieces_v016.aleo;
import football_pvp_utils_v001.aleo;
program football_game_v014.aleo;


























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

struct GameResult:
    goals_home as u64;
    goals_away as u64;

record Game:
    owner as address.private;
    challenger_commit as field.private;
    opponent_answer as [field; 11u32].private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    game_state as field.private;
    ix as u32.private;

record GameReqNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    ix as u32.private;

record WaitingAcceptanceNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    ix as u32.private;

record StakeRenegedNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    renege_address as address.private;
    ix as u32.private;

record ChallengerWagerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    ix as u32.private;

record OpponentWagerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    ix as u32.private;

record WaitingRevealNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    ix as u32.private;

record RevealAnswerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    opponent_answer as [field; 11u32].private;
    ix as u32.private;

record WaitingCalculationNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    ix as u32.private;

record CalculatedOutcomeNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    opponent_answer as [field; 11u32].private;
    ix as u32.private;

record GameFinishReqNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    challenger_answer as [field; 11u32].private;
    opponent_answer as [field; 11u32].private;
    winner as address.private;
    loser as address.private;
    ix as u32.private;

record GameFinishedNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    winner as address.private;
    loser as address.private;
    ix as u32.private;


mapping game_outcomes:
	key as address.public;
	value as GameOutcome.public;


mapping players:
	key as field.public;
	value as Player.public;

function add_player:
    input r0 as Player.private;
    assert.eq self.caller aleo10rdcc92pecx8en6k44zxufvgyy0f98w6c5n7ql6f2er7mehjfyrs3p76nk;
    async add_player r0 into r1;
    output r1 as football_game_v014.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    set r0 into players[r0.player_id];


function propose_game:
    input r0 as puzzle_pieces_v016.aleo/Piece.record;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as signature.private;
    input r12 as field.private;
    input r13 as [field; 11u32].private;
    input r14 as field.private;
    cast r12 into r15 as scalar;
    commit.bhp256 r13 r15 into r16 as field;
    call puzzle_pieces_v016.aleo/stake_transfer_in r0 r2 r3 r4 r5 r1 r6 r7 r8 r9 r10 r11 into r17 r18 r19 r20 r21;
    call football_pvp_utils_v001.aleo/mint_multisig_key r14 r1 r3 r4 r5 into r22 r23;
    add r1 r1 into r24;
    cast r4 r5 1field true r24 r3 r4 2u32 into r25 as GameReqNotification.record;
    add r1 r1 into r26;
    cast r3 r5 1field false r26 r3 r4 3u32 into r27 as WaitingAcceptanceNotification.record;
    cast  0field 0field 0field 0field 0field 0field 0field 0field 0field 0field 0field into r28 as [field; 11u32];
    add r1 r1 into r29;
    cast r5 r16 r28 r29 r3 r4 r5 1field 1u32 into r30 as Game.record;
    call football_pvp_utils_v001.aleo/mint_answer r3 r4 r5 r1 r12 r13 r6 r7 r8 r9 r10 r11 into r31 r32;
    output r17 as puzzle_pieces_v016.aleo/PieceClaim.record;
    output r18 as puzzle_pieces_v016.aleo/PieceStake.record;
    output r19 as puzzle_pieces_v016.aleo/ClaimSignature.record;
    output r20 as puzzle_pieces_v016.aleo/Piece.record;
    output r21 as puzzle_pieces_v016.aleo/AuditStakeIn.record;
    output r31 as football_pvp_utils_v001.aleo/Answer.record;
    output r32 as football_pvp_utils_v001.aleo/AuditMintAnswer.record;
    output r22 as football_pvp_utils_v001.aleo/Key.record;
    output r23 as football_pvp_utils_v001.aleo/AuditKey.record;
    output r30 as Game.record;
    output r25 as GameReqNotification.record;
    output r27 as WaitingAcceptanceNotification.record;


function challenger_renege_stake:
    input r0 as WaitingAcceptanceNotification.record;
    input r1 as puzzle_pieces_v016.aleo/PieceStake.record;
    input r2 as puzzle_pieces_v016.aleo/PieceClaim.record;
    input r3 as signature.private;
    assert.eq self.caller self.signer;
    call puzzle_pieces_v016.aleo/stake_transfer_out r1 r2 r3 into r4 r5;
    cast r0.challenger_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.challenger_address 4u32 into r6 as StakeRenegedNotification.record;
    cast r0.opponent_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.challenger_address 4u32 into r7 as StakeRenegedNotification.record;
    output r4 as puzzle_pieces_v016.aleo/Piece.record;
    output r5 as puzzle_pieces_v016.aleo/AuditStakeOut.record;
    output r6 as StakeRenegedNotification.record;
    output r7 as StakeRenegedNotification.record;


function submit_wager:
    input r0 as puzzle_pieces_v016.aleo/Piece.record;
    input r1 as football_pvp_utils_v001.aleo/Key.record;
    input r2 as GameReqNotification.record;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as signature.private;
    assert.eq self.caller self.signer;
    gt r0.amount 0u64 into r9;
    assert.eq r9 true;
    div r2.total_pot 2u64 into r10;
    gte r0.amount r10 into r11;
    assert.eq r11 true;
    div r2.total_pot 2u64 into r12;
    call puzzle_pieces_v016.aleo/stake_transfer_in r0 r2.opponent_address r2.challenger_address r2.opponent_address r2.game_multisig r12 r3 r4 r5 r6 r7 r8 into r13 r14 r15 r16 r17;
    cast r2.challenger_address r2.game_multisig 2field false r2.total_pot r2.challenger_address r2.opponent_address 5u32 into r18 as ChallengerWagerNotification.record;
    cast r2.opponent_address r2.game_multisig 2field true r2.total_pot r2.challenger_address r2.opponent_address 6u32 into r19 as OpponentWagerNotification.record;
    output r13 as puzzle_pieces_v016.aleo/PieceClaim.record;
    output r14 as puzzle_pieces_v016.aleo/PieceStake.record;
    output r15 as puzzle_pieces_v016.aleo/ClaimSignature.record;
    output r16 as puzzle_pieces_v016.aleo/Piece.record;
    output r17 as puzzle_pieces_v016.aleo/AuditStakeIn.record;
    output r18 as ChallengerWagerNotification.record;
    output r19 as OpponentWagerNotification.record;


function opponent_renege_stake:
    input r0 as WaitingAcceptanceNotification.record;
    input r1 as puzzle_pieces_v016.aleo/PieceStake.record;
    input r2 as puzzle_pieces_v016.aleo/PieceClaim.record;
    input r3 as signature.private;
    assert.eq self.caller self.signer;
    call puzzle_pieces_v016.aleo/stake_transfer_out r1 r2 r3 into r4 r5;
    cast r0.challenger_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address 4u32 into r6 as StakeRenegedNotification.record;
    cast r0.opponent_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address 4u32 into r7 as StakeRenegedNotification.record;
    output r4 as puzzle_pieces_v016.aleo/Piece.record;
    output r5 as puzzle_pieces_v016.aleo/AuditStakeOut.record;
    output r6 as StakeRenegedNotification.record;
    output r7 as StakeRenegedNotification.record;


function accept_game:
    input r0 as Game.record;
    input r1 as [field; 11u32].private;
    input r2 as puzzle_pieces_v016.aleo/PieceStake.record;
    input r3 as puzzle_pieces_v016.aleo/PieceClaim.record;
    input r4 as puzzle_pieces_v016.aleo/PieceStake.record;
    input r5 as puzzle_pieces_v016.aleo/PieceClaim.record;
    input r6 as u32.private;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    call puzzle_pieces_v016.aleo/transfer_stakes_to_joint r2 r3 r4 r5 r6 into r7 r8 r9 r10;
    cast r0.opponent_address r0.owner 3field false r0.total_pot r0.challenger_address r0.opponent_address 7u32 into r11 as WaitingRevealNotification.record;
    cast r0.challenger_address r0.owner 3field true r0.total_pot r0.challenger_address r0.opponent_address r1 8u32 into r12 as RevealAnswerNotification.record;
    cast r0.owner r0.challenger_commit r1 r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 3field 1u32 into r13 as Game.record;
    async accept_game r6 r1 into r14;
    output r7 as puzzle_pieces_v016.aleo/PieceJointStake.record;
    output r8 as puzzle_pieces_v016.aleo/JointPieceTimeClaim.record;
    output r9 as puzzle_pieces_v016.aleo/JointPieceState.record;
    output r10 as puzzle_pieces_v016.aleo/AuditJointStake.record;
    output r11 as WaitingRevealNotification.record;
    output r12 as RevealAnswerNotification.record;
    output r13 as Game.record;
    output r14 as football_game_v014.aleo/accept_game.future;

finalize accept_game:
    input r0 as u32.public;
    input r1 as [field; 11u32].public;
    sub block.height 1000u32 into r2;
    gte r0 r2 into r3;
    assert.eq r3 true;
    add block.height 1000u32 into r4;
    lte r0 r4 into r5;
    assert.eq r5 true;


function calculate_outcome:
    input r0 as RevealAnswerNotification.record;
    input r1 as football_pvp_utils_v001.aleo/Answer.record;
    assert.eq r0.challenger_address self.signer;
    assert.eq self.caller self.signer;
    cast r0.opponent_address r0.game_multisig 4field true r0.total_pot r0.challenger_address r0.opponent_address 9u32 into r2 as WaitingCalculationNotification.record;
    cast r0.challenger_address r0.game_multisig 4field true r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_answer 10u32 into r3 as CalculatedOutcomeNotification.record;
    async calculate_outcome r0.game_multisig r0.challenger_address r0.opponent_address r1.answer r0.opponent_answer into r4;
    output r1 as football_pvp_utils_v001.aleo/Answer.record;
    output r2 as WaitingCalculationNotification.record;
    output r3 as CalculatedOutcomeNotification.record;
    output r4 as football_game_v014.aleo/calculate_outcome.future;

finalize calculate_outcome:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as [field; 11u32].public;
    input r4 as [field; 11u32].public;
    get players[r3[0u32]] into r5;
    get players[r4[0u32]] into r6;
    get players[r3[1u32]] into r7;
    get players[r4[1u32]] into r8;
    rand.chacha into r9 as u128;
    add r7.speed r8.speed into r10;
    mod r9 r10 into r11;
    mod r9 1000000000000u128 into r12;
    lt r11 r7.speed into r13;
    ternary r13 r7.player_id r8.player_id into r14;
    ternary r13 r7.team_id r8.team_id into r15;
    ternary r13 r7.position r8.position into r16;
    ternary r13 r7.attack r8.attack into r17;
    ternary r13 r7.defense r8.defense into r18;
    ternary r13 r7.speed r8.speed into r19;
    ternary r13 r7.power r8.power into r20;
    ternary r13 r7.stamina r8.stamina into r21;
    ternary r13 r7.technique r8.technique into r22;
    ternary r13 r7.goalkeeping r8.goalkeeping into r23;
    cast r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 into r24 as Player;
    ternary r13 r8.player_id r7.player_id into r25;
    ternary r13 r8.team_id r7.team_id into r26;
    ternary r13 r8.position r7.position into r27;
    ternary r13 r8.attack r7.attack into r28;
    ternary r13 r8.defense r7.defense into r29;
    ternary r13 r8.speed r7.speed into r30;
    ternary r13 r8.power r7.power into r31;
    ternary r13 r8.stamina r7.stamina into r32;
    ternary r13 r8.technique r7.technique into r33;
    ternary r13 r8.goalkeeping r7.goalkeeping into r34;
    cast r25 r26 r27 r28 r29 r30 r31 r32 r33 r34 into r35 as Player;
    ternary r13 r6.player_id r5.player_id into r36;
    ternary r13 r6.team_id r5.team_id into r37;
    ternary r13 r6.position r5.position into r38;
    ternary r13 r6.attack r5.attack into r39;
    ternary r13 r6.defense r5.defense into r40;
    ternary r13 r6.speed r5.speed into r41;
    ternary r13 r6.power r5.power into r42;
    ternary r13 r6.stamina r5.stamina into r43;
    ternary r13 r6.technique r5.technique into r44;
    ternary r13 r6.goalkeeping r5.goalkeeping into r45;
    cast r36 r37 r38 r39 r40 r41 r42 r43 r44 r45 into r46 as Player;
    mul r24.attack r24.power into r47;
    mul r35.defense r35.technique into r48;
    sub 10000u128 r48 into r49;
    mul r47 r49 into r50;
    mul r50 r46.goalkeeping into r51;
    gt r51 r12 into r52;
    add 0u64 1u64 into r53;
    add 0u64 1u64 into r54;
    ternary r13 r53 0u64 into r55;
    ternary r13 0u64 r54 into r56;
    ternary r52 r55 0u64 into r57;
    ternary r52 r56 0u64 into r58;
    get players[r3[2u32]] into r59;
    get players[r4[2u32]] into r60;
    rand.chacha into r61 as u128;
    add r59.speed r60.speed into r62;
    mod r61 r62 into r63;
    mod r61 1000000000000u128 into r64;
    lt r63 r59.speed into r65;
    ternary r65 r59.player_id r60.player_id into r66;
    ternary r65 r59.team_id r60.team_id into r67;
    ternary r65 r59.position r60.position into r68;
    ternary r65 r59.attack r60.attack into r69;
    ternary r65 r59.defense r60.defense into r70;
    ternary r65 r59.speed r60.speed into r71;
    ternary r65 r59.power r60.power into r72;
    ternary r65 r59.stamina r60.stamina into r73;
    ternary r65 r59.technique r60.technique into r74;
    ternary r65 r59.goalkeeping r60.goalkeeping into r75;
    cast r66 r67 r68 r69 r70 r71 r72 r73 r74 r75 into r76 as Player;
    ternary r65 r60.player_id r59.player_id into r77;
    ternary r65 r60.team_id r59.team_id into r78;
    ternary r65 r60.position r59.position into r79;
    ternary r65 r60.attack r59.attack into r80;
    ternary r65 r60.defense r59.defense into r81;
    ternary r65 r60.speed r59.speed into r82;
    ternary r65 r60.power r59.power into r83;
    ternary r65 r60.stamina r59.stamina into r84;
    ternary r65 r60.technique r59.technique into r85;
    ternary r65 r60.goalkeeping r59.goalkeeping into r86;
    cast r77 r78 r79 r80 r81 r82 r83 r84 r85 r86 into r87 as Player;
    ternary r65 r6.player_id r5.player_id into r88;
    ternary r65 r6.team_id r5.team_id into r89;
    ternary r65 r6.position r5.position into r90;
    ternary r65 r6.attack r5.attack into r91;
    ternary r65 r6.defense r5.defense into r92;
    ternary r65 r6.speed r5.speed into r93;
    ternary r65 r6.power r5.power into r94;
    ternary r65 r6.stamina r5.stamina into r95;
    ternary r65 r6.technique r5.technique into r96;
    ternary r65 r6.goalkeeping r5.goalkeeping into r97;
    cast r88 r89 r90 r91 r92 r93 r94 r95 r96 r97 into r98 as Player;
    mul r76.attack r76.power into r99;
    mul r87.defense r87.technique into r100;
    sub 10000u128 r100 into r101;
    mul r99 r101 into r102;
    mul r102 r98.goalkeeping into r103;
    gt r103 r64 into r104;
    add r57 1u64 into r105;
    add r58 1u64 into r106;
    ternary r65 r105 r57 into r107;
    ternary r65 r58 r106 into r108;
    ternary r104 r107 r57 into r109;
    ternary r104 r108 r58 into r110;
    get players[r3[3u32]] into r111;
    get players[r4[3u32]] into r112;
    rand.chacha into r113 as u128;
    add r111.speed r112.speed into r114;
    mod r113 r114 into r115;
    mod r113 1000000000000u128 into r116;
    lt r115 r111.speed into r117;
    ternary r117 r111.player_id r112.player_id into r118;
    ternary r117 r111.team_id r112.team_id into r119;
    ternary r117 r111.position r112.position into r120;
    ternary r117 r111.attack r112.attack into r121;
    ternary r117 r111.defense r112.defense into r122;
    ternary r117 r111.speed r112.speed into r123;
    ternary r117 r111.power r112.power into r124;
    ternary r117 r111.stamina r112.stamina into r125;
    ternary r117 r111.technique r112.technique into r126;
    ternary r117 r111.goalkeeping r112.goalkeeping into r127;
    cast r118 r119 r120 r121 r122 r123 r124 r125 r126 r127 into r128 as Player;
    ternary r117 r112.player_id r111.player_id into r129;
    ternary r117 r112.team_id r111.team_id into r130;
    ternary r117 r112.position r111.position into r131;
    ternary r117 r112.attack r111.attack into r132;
    ternary r117 r112.defense r111.defense into r133;
    ternary r117 r112.speed r111.speed into r134;
    ternary r117 r112.power r111.power into r135;
    ternary r117 r112.stamina r111.stamina into r136;
    ternary r117 r112.technique r111.technique into r137;
    ternary r117 r112.goalkeeping r111.goalkeeping into r138;
    cast r129 r130 r131 r132 r133 r134 r135 r136 r137 r138 into r139 as Player;
    ternary r117 r6.player_id r5.player_id into r140;
    ternary r117 r6.team_id r5.team_id into r141;
    ternary r117 r6.position r5.position into r142;
    ternary r117 r6.attack r5.attack into r143;
    ternary r117 r6.defense r5.defense into r144;
    ternary r117 r6.speed r5.speed into r145;
    ternary r117 r6.power r5.power into r146;
    ternary r117 r6.stamina r5.stamina into r147;
    ternary r117 r6.technique r5.technique into r148;
    ternary r117 r6.goalkeeping r5.goalkeeping into r149;
    cast r140 r141 r142 r143 r144 r145 r146 r147 r148 r149 into r150 as Player;
    mul r128.attack r128.power into r151;
    mul r139.defense r139.technique into r152;
    sub 10000u128 r152 into r153;
    mul r151 r153 into r154;
    mul r154 r150.goalkeeping into r155;
    gt r155 r116 into r156;
    add r109 1u64 into r157;
    add r110 1u64 into r158;
    ternary r117 r157 r109 into r159;
    ternary r117 r110 r158 into r160;
    ternary r156 r159 r109 into r161;
    ternary r156 r160 r110 into r162;
    get players[r3[4u32]] into r163;
    get players[r4[4u32]] into r164;
    rand.chacha into r165 as u128;
    add r163.speed r164.speed into r166;
    mod r165 r166 into r167;
    mod r165 1000000000000u128 into r168;
    lt r167 r163.speed into r169;
    ternary r169 r163.player_id r164.player_id into r170;
    ternary r169 r163.team_id r164.team_id into r171;
    ternary r169 r163.position r164.position into r172;
    ternary r169 r163.attack r164.attack into r173;
    ternary r169 r163.defense r164.defense into r174;
    ternary r169 r163.speed r164.speed into r175;
    ternary r169 r163.power r164.power into r176;
    ternary r169 r163.stamina r164.stamina into r177;
    ternary r169 r163.technique r164.technique into r178;
    ternary r169 r163.goalkeeping r164.goalkeeping into r179;
    cast r170 r171 r172 r173 r174 r175 r176 r177 r178 r179 into r180 as Player;
    ternary r169 r164.player_id r163.player_id into r181;
    ternary r169 r164.team_id r163.team_id into r182;
    ternary r169 r164.position r163.position into r183;
    ternary r169 r164.attack r163.attack into r184;
    ternary r169 r164.defense r163.defense into r185;
    ternary r169 r164.speed r163.speed into r186;
    ternary r169 r164.power r163.power into r187;
    ternary r169 r164.stamina r163.stamina into r188;
    ternary r169 r164.technique r163.technique into r189;
    ternary r169 r164.goalkeeping r163.goalkeeping into r190;
    cast r181 r182 r183 r184 r185 r186 r187 r188 r189 r190 into r191 as Player;
    ternary r169 r6.player_id r5.player_id into r192;
    ternary r169 r6.team_id r5.team_id into r193;
    ternary r169 r6.position r5.position into r194;
    ternary r169 r6.attack r5.attack into r195;
    ternary r169 r6.defense r5.defense into r196;
    ternary r169 r6.speed r5.speed into r197;
    ternary r169 r6.power r5.power into r198;
    ternary r169 r6.stamina r5.stamina into r199;
    ternary r169 r6.technique r5.technique into r200;
    ternary r169 r6.goalkeeping r5.goalkeeping into r201;
    cast r192 r193 r194 r195 r196 r197 r198 r199 r200 r201 into r202 as Player;
    mul r180.attack r180.power into r203;
    mul r191.defense r191.technique into r204;
    sub 10000u128 r204 into r205;
    mul r203 r205 into r206;
    mul r206 r202.goalkeeping into r207;
    gt r207 r168 into r208;
    add r161 1u64 into r209;
    add r162 1u64 into r210;
    ternary r169 r209 r161 into r211;
    ternary r169 r162 r210 into r212;
    ternary r208 r211 r161 into r213;
    ternary r208 r212 r162 into r214;
    get players[r3[5u32]] into r215;
    get players[r4[5u32]] into r216;
    rand.chacha into r217 as u128;
    add r215.speed r216.speed into r218;
    mod r217 r218 into r219;
    mod r217 1000000000000u128 into r220;
    lt r219 r215.speed into r221;
    ternary r221 r215.player_id r216.player_id into r222;
    ternary r221 r215.team_id r216.team_id into r223;
    ternary r221 r215.position r216.position into r224;
    ternary r221 r215.attack r216.attack into r225;
    ternary r221 r215.defense r216.defense into r226;
    ternary r221 r215.speed r216.speed into r227;
    ternary r221 r215.power r216.power into r228;
    ternary r221 r215.stamina r216.stamina into r229;
    ternary r221 r215.technique r216.technique into r230;
    ternary r221 r215.goalkeeping r216.goalkeeping into r231;
    cast r222 r223 r224 r225 r226 r227 r228 r229 r230 r231 into r232 as Player;
    ternary r221 r216.player_id r215.player_id into r233;
    ternary r221 r216.team_id r215.team_id into r234;
    ternary r221 r216.position r215.position into r235;
    ternary r221 r216.attack r215.attack into r236;
    ternary r221 r216.defense r215.defense into r237;
    ternary r221 r216.speed r215.speed into r238;
    ternary r221 r216.power r215.power into r239;
    ternary r221 r216.stamina r215.stamina into r240;
    ternary r221 r216.technique r215.technique into r241;
    ternary r221 r216.goalkeeping r215.goalkeeping into r242;
    cast r233 r234 r235 r236 r237 r238 r239 r240 r241 r242 into r243 as Player;
    ternary r221 r6.player_id r5.player_id into r244;
    ternary r221 r6.team_id r5.team_id into r245;
    ternary r221 r6.position r5.position into r246;
    ternary r221 r6.attack r5.attack into r247;
    ternary r221 r6.defense r5.defense into r248;
    ternary r221 r6.speed r5.speed into r249;
    ternary r221 r6.power r5.power into r250;
    ternary r221 r6.stamina r5.stamina into r251;
    ternary r221 r6.technique r5.technique into r252;
    ternary r221 r6.goalkeeping r5.goalkeeping into r253;
    cast r244 r245 r246 r247 r248 r249 r250 r251 r252 r253 into r254 as Player;
    mul r232.attack r232.power into r255;
    mul r243.defense r243.technique into r256;
    sub 10000u128 r256 into r257;
    mul r255 r257 into r258;
    mul r258 r254.goalkeeping into r259;
    gt r259 r220 into r260;
    add r213 1u64 into r261;
    add r214 1u64 into r262;
    ternary r221 r261 r213 into r263;
    ternary r221 r214 r262 into r264;
    ternary r260 r263 r213 into r265;
    ternary r260 r264 r214 into r266;
    get players[r3[6u32]] into r267;
    get players[r4[6u32]] into r268;
    rand.chacha into r269 as u128;
    add r267.speed r268.speed into r270;
    mod r269 r270 into r271;
    mod r269 1000000000000u128 into r272;
    lt r271 r267.speed into r273;
    ternary r273 r267.player_id r268.player_id into r274;
    ternary r273 r267.team_id r268.team_id into r275;
    ternary r273 r267.position r268.position into r276;
    ternary r273 r267.attack r268.attack into r277;
    ternary r273 r267.defense r268.defense into r278;
    ternary r273 r267.speed r268.speed into r279;
    ternary r273 r267.power r268.power into r280;
    ternary r273 r267.stamina r268.stamina into r281;
    ternary r273 r267.technique r268.technique into r282;
    ternary r273 r267.goalkeeping r268.goalkeeping into r283;
    cast r274 r275 r276 r277 r278 r279 r280 r281 r282 r283 into r284 as Player;
    ternary r273 r268.player_id r267.player_id into r285;
    ternary r273 r268.team_id r267.team_id into r286;
    ternary r273 r268.position r267.position into r287;
    ternary r273 r268.attack r267.attack into r288;
    ternary r273 r268.defense r267.defense into r289;
    ternary r273 r268.speed r267.speed into r290;
    ternary r273 r268.power r267.power into r291;
    ternary r273 r268.stamina r267.stamina into r292;
    ternary r273 r268.technique r267.technique into r293;
    ternary r273 r268.goalkeeping r267.goalkeeping into r294;
    cast r285 r286 r287 r288 r289 r290 r291 r292 r293 r294 into r295 as Player;
    ternary r273 r6.player_id r5.player_id into r296;
    ternary r273 r6.team_id r5.team_id into r297;
    ternary r273 r6.position r5.position into r298;
    ternary r273 r6.attack r5.attack into r299;
    ternary r273 r6.defense r5.defense into r300;
    ternary r273 r6.speed r5.speed into r301;
    ternary r273 r6.power r5.power into r302;
    ternary r273 r6.stamina r5.stamina into r303;
    ternary r273 r6.technique r5.technique into r304;
    ternary r273 r6.goalkeeping r5.goalkeeping into r305;
    cast r296 r297 r298 r299 r300 r301 r302 r303 r304 r305 into r306 as Player;
    mul r284.attack r284.power into r307;
    mul r295.defense r295.technique into r308;
    sub 10000u128 r308 into r309;
    mul r307 r309 into r310;
    mul r310 r306.goalkeeping into r311;
    gt r311 r272 into r312;
    add r265 1u64 into r313;
    add r266 1u64 into r314;
    ternary r273 r313 r265 into r315;
    ternary r273 r266 r314 into r316;
    ternary r312 r315 r265 into r317;
    ternary r312 r316 r266 into r318;
    get players[r3[7u32]] into r319;
    get players[r4[7u32]] into r320;
    rand.chacha into r321 as u128;
    add r319.speed r320.speed into r322;
    mod r321 r322 into r323;
    mod r321 1000000000000u128 into r324;
    lt r323 r319.speed into r325;
    ternary r325 r319.player_id r320.player_id into r326;
    ternary r325 r319.team_id r320.team_id into r327;
    ternary r325 r319.position r320.position into r328;
    ternary r325 r319.attack r320.attack into r329;
    ternary r325 r319.defense r320.defense into r330;
    ternary r325 r319.speed r320.speed into r331;
    ternary r325 r319.power r320.power into r332;
    ternary r325 r319.stamina r320.stamina into r333;
    ternary r325 r319.technique r320.technique into r334;
    ternary r325 r319.goalkeeping r320.goalkeeping into r335;
    cast r326 r327 r328 r329 r330 r331 r332 r333 r334 r335 into r336 as Player;
    ternary r325 r320.player_id r319.player_id into r337;
    ternary r325 r320.team_id r319.team_id into r338;
    ternary r325 r320.position r319.position into r339;
    ternary r325 r320.attack r319.attack into r340;
    ternary r325 r320.defense r319.defense into r341;
    ternary r325 r320.speed r319.speed into r342;
    ternary r325 r320.power r319.power into r343;
    ternary r325 r320.stamina r319.stamina into r344;
    ternary r325 r320.technique r319.technique into r345;
    ternary r325 r320.goalkeeping r319.goalkeeping into r346;
    cast r337 r338 r339 r340 r341 r342 r343 r344 r345 r346 into r347 as Player;
    ternary r325 r6.player_id r5.player_id into r348;
    ternary r325 r6.team_id r5.team_id into r349;
    ternary r325 r6.position r5.position into r350;
    ternary r325 r6.attack r5.attack into r351;
    ternary r325 r6.defense r5.defense into r352;
    ternary r325 r6.speed r5.speed into r353;
    ternary r325 r6.power r5.power into r354;
    ternary r325 r6.stamina r5.stamina into r355;
    ternary r325 r6.technique r5.technique into r356;
    ternary r325 r6.goalkeeping r5.goalkeeping into r357;
    cast r348 r349 r350 r351 r352 r353 r354 r355 r356 r357 into r358 as Player;
    mul r336.attack r336.power into r359;
    mul r347.defense r347.technique into r360;
    sub 10000u128 r360 into r361;
    mul r359 r361 into r362;
    mul r362 r358.goalkeeping into r363;
    gt r363 r324 into r364;
    add r317 1u64 into r365;
    add r318 1u64 into r366;
    ternary r325 r365 r317 into r367;
    ternary r325 r318 r366 into r368;
    ternary r364 r367 r317 into r369;
    ternary r364 r368 r318 into r370;
    get players[r3[8u32]] into r371;
    get players[r4[8u32]] into r372;
    rand.chacha into r373 as u128;
    add r371.speed r372.speed into r374;
    mod r373 r374 into r375;
    mod r373 1000000000000u128 into r376;
    lt r375 r371.speed into r377;
    ternary r377 r371.player_id r372.player_id into r378;
    ternary r377 r371.team_id r372.team_id into r379;
    ternary r377 r371.position r372.position into r380;
    ternary r377 r371.attack r372.attack into r381;
    ternary r377 r371.defense r372.defense into r382;
    ternary r377 r371.speed r372.speed into r383;
    ternary r377 r371.power r372.power into r384;
    ternary r377 r371.stamina r372.stamina into r385;
    ternary r377 r371.technique r372.technique into r386;
    ternary r377 r371.goalkeeping r372.goalkeeping into r387;
    cast r378 r379 r380 r381 r382 r383 r384 r385 r386 r387 into r388 as Player;
    ternary r377 r372.player_id r371.player_id into r389;
    ternary r377 r372.team_id r371.team_id into r390;
    ternary r377 r372.position r371.position into r391;
    ternary r377 r372.attack r371.attack into r392;
    ternary r377 r372.defense r371.defense into r393;
    ternary r377 r372.speed r371.speed into r394;
    ternary r377 r372.power r371.power into r395;
    ternary r377 r372.stamina r371.stamina into r396;
    ternary r377 r372.technique r371.technique into r397;
    ternary r377 r372.goalkeeping r371.goalkeeping into r398;
    cast r389 r390 r391 r392 r393 r394 r395 r396 r397 r398 into r399 as Player;
    ternary r377 r6.player_id r5.player_id into r400;
    ternary r377 r6.team_id r5.team_id into r401;
    ternary r377 r6.position r5.position into r402;
    ternary r377 r6.attack r5.attack into r403;
    ternary r377 r6.defense r5.defense into r404;
    ternary r377 r6.speed r5.speed into r405;
    ternary r377 r6.power r5.power into r406;
    ternary r377 r6.stamina r5.stamina into r407;
    ternary r377 r6.technique r5.technique into r408;
    ternary r377 r6.goalkeeping r5.goalkeeping into r409;
    cast r400 r401 r402 r403 r404 r405 r406 r407 r408 r409 into r410 as Player;
    mul r388.attack r388.power into r411;
    mul r399.defense r399.technique into r412;
    sub 10000u128 r412 into r413;
    mul r411 r413 into r414;
    mul r414 r410.goalkeeping into r415;
    gt r415 r376 into r416;
    add r369 1u64 into r417;
    add r370 1u64 into r418;
    ternary r377 r417 r369 into r419;
    ternary r377 r370 r418 into r420;
    ternary r416 r419 r369 into r421;
    ternary r416 r420 r370 into r422;
    get players[r3[9u32]] into r423;
    get players[r4[9u32]] into r424;
    rand.chacha into r425 as u128;
    add r423.speed r424.speed into r426;
    mod r425 r426 into r427;
    mod r425 1000000000000u128 into r428;
    lt r427 r423.speed into r429;
    ternary r429 r423.player_id r424.player_id into r430;
    ternary r429 r423.team_id r424.team_id into r431;
    ternary r429 r423.position r424.position into r432;
    ternary r429 r423.attack r424.attack into r433;
    ternary r429 r423.defense r424.defense into r434;
    ternary r429 r423.speed r424.speed into r435;
    ternary r429 r423.power r424.power into r436;
    ternary r429 r423.stamina r424.stamina into r437;
    ternary r429 r423.technique r424.technique into r438;
    ternary r429 r423.goalkeeping r424.goalkeeping into r439;
    cast r430 r431 r432 r433 r434 r435 r436 r437 r438 r439 into r440 as Player;
    ternary r429 r424.player_id r423.player_id into r441;
    ternary r429 r424.team_id r423.team_id into r442;
    ternary r429 r424.position r423.position into r443;
    ternary r429 r424.attack r423.attack into r444;
    ternary r429 r424.defense r423.defense into r445;
    ternary r429 r424.speed r423.speed into r446;
    ternary r429 r424.power r423.power into r447;
    ternary r429 r424.stamina r423.stamina into r448;
    ternary r429 r424.technique r423.technique into r449;
    ternary r429 r424.goalkeeping r423.goalkeeping into r450;
    cast r441 r442 r443 r444 r445 r446 r447 r448 r449 r450 into r451 as Player;
    ternary r429 r6.player_id r5.player_id into r452;
    ternary r429 r6.team_id r5.team_id into r453;
    ternary r429 r6.position r5.position into r454;
    ternary r429 r6.attack r5.attack into r455;
    ternary r429 r6.defense r5.defense into r456;
    ternary r429 r6.speed r5.speed into r457;
    ternary r429 r6.power r5.power into r458;
    ternary r429 r6.stamina r5.stamina into r459;
    ternary r429 r6.technique r5.technique into r460;
    ternary r429 r6.goalkeeping r5.goalkeeping into r461;
    cast r452 r453 r454 r455 r456 r457 r458 r459 r460 r461 into r462 as Player;
    mul r440.attack r440.power into r463;
    mul r451.defense r451.technique into r464;
    sub 10000u128 r464 into r465;
    mul r463 r465 into r466;
    mul r466 r462.goalkeeping into r467;
    gt r467 r428 into r468;
    add r421 1u64 into r469;
    add r422 1u64 into r470;
    ternary r429 r469 r421 into r471;
    ternary r429 r422 r470 into r472;
    ternary r468 r471 r421 into r473;
    ternary r468 r472 r422 into r474;
    get players[r3[10u32]] into r475;
    get players[r4[10u32]] into r476;
    rand.chacha into r477 as u128;
    add r475.speed r476.speed into r478;
    mod r477 r478 into r479;
    mod r477 1000000000000u128 into r480;
    lt r479 r475.speed into r481;
    ternary r481 r475.player_id r476.player_id into r482;
    ternary r481 r475.team_id r476.team_id into r483;
    ternary r481 r475.position r476.position into r484;
    ternary r481 r475.attack r476.attack into r485;
    ternary r481 r475.defense r476.defense into r486;
    ternary r481 r475.speed r476.speed into r487;
    ternary r481 r475.power r476.power into r488;
    ternary r481 r475.stamina r476.stamina into r489;
    ternary r481 r475.technique r476.technique into r490;
    ternary r481 r475.goalkeeping r476.goalkeeping into r491;
    cast r482 r483 r484 r485 r486 r487 r488 r489 r490 r491 into r492 as Player;
    ternary r481 r476.player_id r475.player_id into r493;
    ternary r481 r476.team_id r475.team_id into r494;
    ternary r481 r476.position r475.position into r495;
    ternary r481 r476.attack r475.attack into r496;
    ternary r481 r476.defense r475.defense into r497;
    ternary r481 r476.speed r475.speed into r498;
    ternary r481 r476.power r475.power into r499;
    ternary r481 r476.stamina r475.stamina into r500;
    ternary r481 r476.technique r475.technique into r501;
    ternary r481 r476.goalkeeping r475.goalkeeping into r502;
    cast r493 r494 r495 r496 r497 r498 r499 r500 r501 r502 into r503 as Player;
    ternary r481 r6.player_id r5.player_id into r504;
    ternary r481 r6.team_id r5.team_id into r505;
    ternary r481 r6.position r5.position into r506;
    ternary r481 r6.attack r5.attack into r507;
    ternary r481 r6.defense r5.defense into r508;
    ternary r481 r6.speed r5.speed into r509;
    ternary r481 r6.power r5.power into r510;
    ternary r481 r6.stamina r5.stamina into r511;
    ternary r481 r6.technique r5.technique into r512;
    ternary r481 r6.goalkeeping r5.goalkeeping into r513;
    cast r504 r505 r506 r507 r508 r509 r510 r511 r512 r513 into r514 as Player;
    mul r492.attack r492.power into r515;
    mul r503.defense r503.technique into r516;
    sub 10000u128 r516 into r517;
    mul r515 r517 into r518;
    mul r518 r514.goalkeeping into r519;
    gt r519 r480 into r520;
    add r473 1u64 into r521;
    add r474 1u64 into r522;
    ternary r481 r521 r473 into r523;
    ternary r481 r474 r522 into r524;
    ternary r520 r523 r473 into r525;
    ternary r520 r524 r474 into r526;
    lt r475.speed r476.speed into r527;
    add r526 1u64 into r528;
    add r525 1u64 into r529;
    ternary r527 r528 r526 into r530;
    ternary r527 r525 r529 into r531;
    cast r1 r2 r475.team_id r476.team_id r531 r530 into r532 as GameOutcome;
    set r532 into game_outcomes[r0];


function reveal_answer_game:
    input r0 as puzzle_pieces_v016.aleo/ClaimSignature.record;
    input r1 as CalculatedOutcomeNotification.record;
    input r2 as puzzle_pieces_v016.aleo/JointPieceState.record;
    input r3 as football_pvp_utils_v001.aleo/Answer.record;
    input r4 as GameOutcome.private;
    assert.eq r2.state_updater_address self.signer;
    assert.eq self.caller self.signer;
    is.eq r1.opponent_answer r3.answer into r5;
    ternary r5 r3.opponent_address r3.challenger_address into r6;
    is.eq r6 r3.challenger_address into r7;
    ternary r7 r3.opponent_address r3.challenger_address into r8;
    call football_pvp_utils_v001.aleo/reveal_answer r3 r0.sig into r9 r10;
    call puzzle_pieces_v016.aleo/joint_stake_state_update r2 r0 r6 into r11 r12;
    cast r3.opponent_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r6 r8 11u32 into r13 as GameFinishReqNotification.record;
    cast r3.challenger_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r6 r8 11u32 into r14 as GameFinishReqNotification.record;
    async reveal_answer_game r1.game_multisig r4 into r15;
    output r9 as football_pvp_utils_v001.aleo/RevealAnswer.record;
    output r10 as football_pvp_utils_v001.aleo/AuditRevealAnswer.record;
    output r11 as puzzle_pieces_v016.aleo/JointPieceWinner.record;
    output r12 as puzzle_pieces_v016.aleo/AuditJointPieceWinner.record;
    output r13 as GameFinishReqNotification.record;
    output r14 as GameFinishReqNotification.record;
    output r15 as football_game_v014.aleo/reveal_answer_game.future;

finalize reveal_answer_game:
    input r0 as address.public;
    input r1 as GameOutcome.public;
    get game_outcomes[r0] into r2;
    assert.eq r1.goals_home r2.goals_home;
    assert.eq r1.goals_away r2.goals_away;


function finish_game:
    input r0 as Game.record;
    input r1 as puzzle_pieces_v016.aleo/JointPieceWinner.record;
    input r2 as puzzle_pieces_v016.aleo/PieceJointStake.record;
    input r3 as puzzle_pieces_v016.aleo/JointPieceTimeClaim.record;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    is.eq r0.challenger_address r1.winner into r4;
    ternary r4 r0.opponent_address r0.challenger_address into r5;
    call puzzle_pieces_v016.aleo/joint_stake_transfer_to_winner r1 r2 r3 into r6 r7 r8;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 6field 0u32 into r9 as Game.record;
    cast r0.challenger_address r0.game_multisig 6field false r0.total_pot r0.challenger_address r0.opponent_address r1.winner r5 12u32 into r10 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 6field false r0.total_pot r0.challenger_address r0.opponent_address r1.winner r5 12u32 into r11 as GameFinishedNotification.record;
    output r6 as puzzle_pieces_v016.aleo/Piece.record;
    output r7 as puzzle_pieces_v016.aleo/AuditTransferToWinner.record;
    output r8 as puzzle_pieces_v016.aleo/AuditPieceOwner.record;
    output r9 as Game.record;
    output r10 as GameFinishedNotification.record;
    output r11 as GameFinishedNotification.record;


function finish_game_by_timeout:
    input r0 as Game.record;
    input r1 as puzzle_pieces_v016.aleo/PieceJointStake.record;
    input r2 as puzzle_pieces_v016.aleo/JointPieceTimeClaim.record;
    input r3 as signature.private;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 9field 0u32 into r4 as Game.record;
    cast r0.challenger_address r0.opponent_address 0field 0field 0u64 3u64 into r5 as GameOutcome;
    cast r0.challenger_address r0.game_multisig 9field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address r0.challenger_address 12u32 into r6 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 9field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address r0.challenger_address 12u32 into r7 as GameFinishedNotification.record;
    call puzzle_pieces_v016.aleo/joint_timeout_to_opponent r1 r2 r3 into r8 r9;
    async finish_game_by_timeout r2.block_ht into r10;
    output r8 as puzzle_pieces_v016.aleo/Piece.record;
    output r9 as puzzle_pieces_v016.aleo/AuditTransferToWinner.record;
    output r4 as Game.record;
    output r6 as GameFinishedNotification.record;
    output r7 as GameFinishedNotification.record;
    output r10 as football_game_v014.aleo/finish_game_by_timeout.future;

finalize finish_game_by_timeout:
    input r0 as u32.public;
    add r0 10000u32 into r1;
    gt block.height r1 into r2;
    assert.eq r2 true;
