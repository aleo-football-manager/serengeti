import football_coins_v001.aleo;
import football_pvp_utils_v001.aleo;
program football_game_v015.aleo;


























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
    output r1 as football_game_v015.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    set r0 into players[r0.player_id];


function propose_game:
    input r0 as football_coins_v001.aleo/Piece.record;
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
    call football_coins_v001.aleo/stake_transfer_in r0 r2 r3 r4 r5 r1 r6 r7 r8 r9 r10 r11 into r17 r18 r19 r20 r21;
    call football_pvp_utils_v001.aleo/mint_multisig_key r14 r1 r3 r4 r5 into r22 r23;
    add r1 r1 into r24;
    cast r4 r5 1field true r24 r3 r4 2u32 into r25 as GameReqNotification.record;
    add r1 r1 into r26;
    cast r3 r5 1field false r26 r3 r4 3u32 into r27 as WaitingAcceptanceNotification.record;
    cast  0field 0field 0field 0field 0field 0field 0field 0field 0field 0field 0field into r28 as [field; 11u32];
    add r1 r1 into r29;
    cast r5 r16 r28 r29 r3 r4 r5 1field 1u32 into r30 as Game.record;
    call football_pvp_utils_v001.aleo/mint_answer r3 r4 r5 r1 r12 r13 r6 r7 r8 r9 r10 r11 into r31 r32;
    output r17 as football_coins_v001.aleo/PieceClaim.record;
    output r18 as football_coins_v001.aleo/PieceStake.record;
    output r19 as football_coins_v001.aleo/ClaimSignature.record;
    output r20 as football_coins_v001.aleo/Piece.record;
    output r21 as football_coins_v001.aleo/AuditStakeIn.record;
    output r31 as football_pvp_utils_v001.aleo/Answer.record;
    output r32 as football_pvp_utils_v001.aleo/AuditMintAnswer.record;
    output r22 as football_pvp_utils_v001.aleo/Key.record;
    output r23 as football_pvp_utils_v001.aleo/AuditKey.record;
    output r30 as Game.record;
    output r25 as GameReqNotification.record;
    output r27 as WaitingAcceptanceNotification.record;


function challenger_renege_stake:
    input r0 as WaitingAcceptanceNotification.record;
    input r1 as football_coins_v001.aleo/PieceStake.record;
    input r2 as football_coins_v001.aleo/PieceClaim.record;
    input r3 as signature.private;
    assert.eq self.caller self.signer;
    call football_coins_v001.aleo/stake_transfer_out r1 r2 r3 into r4 r5;
    cast r0.challenger_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.challenger_address 4u32 into r6 as StakeRenegedNotification.record;
    cast r0.opponent_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.challenger_address 4u32 into r7 as StakeRenegedNotification.record;
    output r4 as football_coins_v001.aleo/Piece.record;
    output r5 as football_coins_v001.aleo/AuditStakeOut.record;
    output r6 as StakeRenegedNotification.record;
    output r7 as StakeRenegedNotification.record;


function submit_wager:
    input r0 as football_coins_v001.aleo/Piece.record;
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
    call football_coins_v001.aleo/stake_transfer_in r0 r2.opponent_address r2.challenger_address r2.opponent_address r2.game_multisig r12 r3 r4 r5 r6 r7 r8 into r13 r14 r15 r16 r17;
    cast r2.challenger_address r2.game_multisig 2field false r2.total_pot r2.challenger_address r2.opponent_address 5u32 into r18 as ChallengerWagerNotification.record;
    cast r2.opponent_address r2.game_multisig 2field true r2.total_pot r2.challenger_address r2.opponent_address 6u32 into r19 as OpponentWagerNotification.record;
    output r13 as football_coins_v001.aleo/PieceClaim.record;
    output r14 as football_coins_v001.aleo/PieceStake.record;
    output r15 as football_coins_v001.aleo/ClaimSignature.record;
    output r16 as football_coins_v001.aleo/Piece.record;
    output r17 as football_coins_v001.aleo/AuditStakeIn.record;
    output r18 as ChallengerWagerNotification.record;
    output r19 as OpponentWagerNotification.record;


function opponent_renege_stake:
    input r0 as WaitingAcceptanceNotification.record;
    input r1 as football_coins_v001.aleo/PieceStake.record;
    input r2 as football_coins_v001.aleo/PieceClaim.record;
    input r3 as signature.private;
    assert.eq self.caller self.signer;
    call football_coins_v001.aleo/stake_transfer_out r1 r2 r3 into r4 r5;
    cast r0.challenger_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address 4u32 into r6 as StakeRenegedNotification.record;
    cast r0.opponent_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address 4u32 into r7 as StakeRenegedNotification.record;
    output r4 as football_coins_v001.aleo/Piece.record;
    output r5 as football_coins_v001.aleo/AuditStakeOut.record;
    output r6 as StakeRenegedNotification.record;
    output r7 as StakeRenegedNotification.record;


function accept_game:
    input r0 as Game.record;
    input r1 as [field; 11u32].private;
    input r2 as football_coins_v001.aleo/PieceStake.record;
    input r3 as football_coins_v001.aleo/PieceClaim.record;
    input r4 as football_coins_v001.aleo/PieceStake.record;
    input r5 as football_coins_v001.aleo/PieceClaim.record;
    input r6 as u32.private;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    call football_coins_v001.aleo/transfer_stakes_to_joint r2 r3 r4 r5 r6 into r7 r8 r9 r10;
    cast r0.opponent_address r0.owner 3field false r0.total_pot r0.challenger_address r0.opponent_address 7u32 into r11 as WaitingRevealNotification.record;
    cast r0.challenger_address r0.owner 3field true r0.total_pot r0.challenger_address r0.opponent_address r1 8u32 into r12 as RevealAnswerNotification.record;
    cast r0.owner r0.challenger_commit r1 r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 3field 1u32 into r13 as Game.record;
    async accept_game r6 r1 into r14;
    output r7 as football_coins_v001.aleo/PieceJointStake.record;
    output r8 as football_coins_v001.aleo/JointPieceTimeClaim.record;
    output r9 as football_coins_v001.aleo/JointPieceState.record;
    output r10 as football_coins_v001.aleo/AuditJointStake.record;
    output r11 as WaitingRevealNotification.record;
    output r12 as RevealAnswerNotification.record;
    output r13 as Game.record;
    output r14 as football_game_v015.aleo/accept_game.future;

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
    output r4 as football_game_v015.aleo/calculate_outcome.future;

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
    rand.chacha into r10 as u128;
    rand.chacha into r11 as u128;
    rand.chacha into r12 as u128;
    rand.chacha into r13 as u128;
    lt r10 r7.speed into r14;
    ternary r14 r7.player_id r8.player_id into r15;
    ternary r14 r7.team_id r8.team_id into r16;
    ternary r14 r7.position r8.position into r17;
    ternary r14 r7.attack r8.attack into r18;
    ternary r14 r7.defense r8.defense into r19;
    ternary r14 r7.speed r8.speed into r20;
    ternary r14 r7.power r8.power into r21;
    ternary r14 r7.stamina r8.stamina into r22;
    ternary r14 r7.technique r8.technique into r23;
    ternary r14 r7.goalkeeping r8.goalkeeping into r24;
    cast r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 into r25 as Player;
    ternary r14 r8.player_id r7.player_id into r26;
    ternary r14 r8.team_id r7.team_id into r27;
    ternary r14 r8.position r7.position into r28;
    ternary r14 r8.attack r7.attack into r29;
    ternary r14 r8.defense r7.defense into r30;
    ternary r14 r8.speed r7.speed into r31;
    ternary r14 r8.power r7.power into r32;
    ternary r14 r8.stamina r7.stamina into r33;
    ternary r14 r8.technique r7.technique into r34;
    ternary r14 r8.goalkeeping r7.goalkeeping into r35;
    cast r26 r27 r28 r29 r30 r31 r32 r33 r34 r35 into r36 as Player;
    ternary r14 r6.player_id r5.player_id into r37;
    ternary r14 r6.team_id r5.team_id into r38;
    ternary r14 r6.position r5.position into r39;
    ternary r14 r6.attack r5.attack into r40;
    ternary r14 r6.defense r5.defense into r41;
    ternary r14 r6.speed r5.speed into r42;
    ternary r14 r6.power r5.power into r43;
    ternary r14 r6.stamina r5.stamina into r44;
    ternary r14 r6.technique r5.technique into r45;
    ternary r14 r6.goalkeeping r5.goalkeeping into r46;
    cast r37 r38 r39 r40 r41 r42 r43 r44 r45 r46 into r47 as Player;
    add r25.attack r25.power into r48;
    add r48 r36.technique into r49;
    gt r49 r11 into r50;
    lt r36.defense r12 into r51;
    lt r47.goalkeeping r13 into r52;
    add 0u64 1u64 into r53;
    add 0u64 1u64 into r54;
    ternary r14 r53 0u64 into r55;
    ternary r14 0u64 r54 into r56;
    ternary r52 r55 0u64 into r57;
    ternary r52 r56 0u64 into r58;
    ternary r51 r57 0u64 into r59;
    ternary r51 r58 0u64 into r60;
    ternary r50 r59 0u64 into r61;
    ternary r50 r60 0u64 into r62;
    get players[r3[2u32]] into r63;
    get players[r4[2u32]] into r64;
    rand.chacha into r65 as u128;
    rand.chacha into r66 as u128;
    rand.chacha into r67 as u128;
    rand.chacha into r68 as u128;
    rand.chacha into r69 as u128;
    lt r66 r63.speed into r70;
    ternary r70 r63.player_id r64.player_id into r71;
    ternary r70 r63.team_id r64.team_id into r72;
    ternary r70 r63.position r64.position into r73;
    ternary r70 r63.attack r64.attack into r74;
    ternary r70 r63.defense r64.defense into r75;
    ternary r70 r63.speed r64.speed into r76;
    ternary r70 r63.power r64.power into r77;
    ternary r70 r63.stamina r64.stamina into r78;
    ternary r70 r63.technique r64.technique into r79;
    ternary r70 r63.goalkeeping r64.goalkeeping into r80;
    cast r71 r72 r73 r74 r75 r76 r77 r78 r79 r80 into r81 as Player;
    ternary r70 r64.player_id r63.player_id into r82;
    ternary r70 r64.team_id r63.team_id into r83;
    ternary r70 r64.position r63.position into r84;
    ternary r70 r64.attack r63.attack into r85;
    ternary r70 r64.defense r63.defense into r86;
    ternary r70 r64.speed r63.speed into r87;
    ternary r70 r64.power r63.power into r88;
    ternary r70 r64.stamina r63.stamina into r89;
    ternary r70 r64.technique r63.technique into r90;
    ternary r70 r64.goalkeeping r63.goalkeeping into r91;
    cast r82 r83 r84 r85 r86 r87 r88 r89 r90 r91 into r92 as Player;
    ternary r70 r6.player_id r5.player_id into r93;
    ternary r70 r6.team_id r5.team_id into r94;
    ternary r70 r6.position r5.position into r95;
    ternary r70 r6.attack r5.attack into r96;
    ternary r70 r6.defense r5.defense into r97;
    ternary r70 r6.speed r5.speed into r98;
    ternary r70 r6.power r5.power into r99;
    ternary r70 r6.stamina r5.stamina into r100;
    ternary r70 r6.technique r5.technique into r101;
    ternary r70 r6.goalkeeping r5.goalkeeping into r102;
    cast r93 r94 r95 r96 r97 r98 r99 r100 r101 r102 into r103 as Player;
    add r81.attack r81.power into r104;
    add r104 r92.technique into r105;
    gt r105 r67 into r106;
    lt r92.defense r68 into r107;
    lt r103.goalkeeping r69 into r108;
    add r61 1u64 into r109;
    add r62 1u64 into r110;
    ternary r70 r109 r61 into r111;
    ternary r70 r62 r110 into r112;
    ternary r108 r111 r61 into r113;
    ternary r108 r112 r62 into r114;
    ternary r107 r113 r61 into r115;
    ternary r107 r114 r62 into r116;
    ternary r106 r115 r61 into r117;
    ternary r106 r116 r62 into r118;
    get players[r3[3u32]] into r119;
    get players[r4[3u32]] into r120;
    rand.chacha into r121 as u128;
    rand.chacha into r122 as u128;
    rand.chacha into r123 as u128;
    rand.chacha into r124 as u128;
    rand.chacha into r125 as u128;
    lt r122 r119.speed into r126;
    ternary r126 r119.player_id r120.player_id into r127;
    ternary r126 r119.team_id r120.team_id into r128;
    ternary r126 r119.position r120.position into r129;
    ternary r126 r119.attack r120.attack into r130;
    ternary r126 r119.defense r120.defense into r131;
    ternary r126 r119.speed r120.speed into r132;
    ternary r126 r119.power r120.power into r133;
    ternary r126 r119.stamina r120.stamina into r134;
    ternary r126 r119.technique r120.technique into r135;
    ternary r126 r119.goalkeeping r120.goalkeeping into r136;
    cast r127 r128 r129 r130 r131 r132 r133 r134 r135 r136 into r137 as Player;
    ternary r126 r120.player_id r119.player_id into r138;
    ternary r126 r120.team_id r119.team_id into r139;
    ternary r126 r120.position r119.position into r140;
    ternary r126 r120.attack r119.attack into r141;
    ternary r126 r120.defense r119.defense into r142;
    ternary r126 r120.speed r119.speed into r143;
    ternary r126 r120.power r119.power into r144;
    ternary r126 r120.stamina r119.stamina into r145;
    ternary r126 r120.technique r119.technique into r146;
    ternary r126 r120.goalkeeping r119.goalkeeping into r147;
    cast r138 r139 r140 r141 r142 r143 r144 r145 r146 r147 into r148 as Player;
    ternary r126 r6.player_id r5.player_id into r149;
    ternary r126 r6.team_id r5.team_id into r150;
    ternary r126 r6.position r5.position into r151;
    ternary r126 r6.attack r5.attack into r152;
    ternary r126 r6.defense r5.defense into r153;
    ternary r126 r6.speed r5.speed into r154;
    ternary r126 r6.power r5.power into r155;
    ternary r126 r6.stamina r5.stamina into r156;
    ternary r126 r6.technique r5.technique into r157;
    ternary r126 r6.goalkeeping r5.goalkeeping into r158;
    cast r149 r150 r151 r152 r153 r154 r155 r156 r157 r158 into r159 as Player;
    add r137.attack r137.power into r160;
    add r160 r148.technique into r161;
    gt r161 r123 into r162;
    lt r148.defense r124 into r163;
    lt r159.goalkeeping r125 into r164;
    add r117 1u64 into r165;
    add r118 1u64 into r166;
    ternary r126 r165 r117 into r167;
    ternary r126 r118 r166 into r168;
    ternary r164 r167 r117 into r169;
    ternary r164 r168 r118 into r170;
    ternary r163 r169 r117 into r171;
    ternary r163 r170 r118 into r172;
    ternary r162 r171 r117 into r173;
    ternary r162 r172 r118 into r174;
    get players[r3[4u32]] into r175;
    get players[r4[4u32]] into r176;
    rand.chacha into r177 as u128;
    rand.chacha into r178 as u128;
    rand.chacha into r179 as u128;
    rand.chacha into r180 as u128;
    rand.chacha into r181 as u128;
    lt r178 r175.speed into r182;
    ternary r182 r175.player_id r176.player_id into r183;
    ternary r182 r175.team_id r176.team_id into r184;
    ternary r182 r175.position r176.position into r185;
    ternary r182 r175.attack r176.attack into r186;
    ternary r182 r175.defense r176.defense into r187;
    ternary r182 r175.speed r176.speed into r188;
    ternary r182 r175.power r176.power into r189;
    ternary r182 r175.stamina r176.stamina into r190;
    ternary r182 r175.technique r176.technique into r191;
    ternary r182 r175.goalkeeping r176.goalkeeping into r192;
    cast r183 r184 r185 r186 r187 r188 r189 r190 r191 r192 into r193 as Player;
    ternary r182 r176.player_id r175.player_id into r194;
    ternary r182 r176.team_id r175.team_id into r195;
    ternary r182 r176.position r175.position into r196;
    ternary r182 r176.attack r175.attack into r197;
    ternary r182 r176.defense r175.defense into r198;
    ternary r182 r176.speed r175.speed into r199;
    ternary r182 r176.power r175.power into r200;
    ternary r182 r176.stamina r175.stamina into r201;
    ternary r182 r176.technique r175.technique into r202;
    ternary r182 r176.goalkeeping r175.goalkeeping into r203;
    cast r194 r195 r196 r197 r198 r199 r200 r201 r202 r203 into r204 as Player;
    ternary r182 r6.player_id r5.player_id into r205;
    ternary r182 r6.team_id r5.team_id into r206;
    ternary r182 r6.position r5.position into r207;
    ternary r182 r6.attack r5.attack into r208;
    ternary r182 r6.defense r5.defense into r209;
    ternary r182 r6.speed r5.speed into r210;
    ternary r182 r6.power r5.power into r211;
    ternary r182 r6.stamina r5.stamina into r212;
    ternary r182 r6.technique r5.technique into r213;
    ternary r182 r6.goalkeeping r5.goalkeeping into r214;
    cast r205 r206 r207 r208 r209 r210 r211 r212 r213 r214 into r215 as Player;
    add r193.attack r193.power into r216;
    add r216 r204.technique into r217;
    gt r217 r179 into r218;
    lt r204.defense r180 into r219;
    lt r215.goalkeeping r181 into r220;
    add r173 1u64 into r221;
    add r174 1u64 into r222;
    ternary r182 r221 r173 into r223;
    ternary r182 r174 r222 into r224;
    ternary r220 r223 r173 into r225;
    ternary r220 r224 r174 into r226;
    ternary r219 r225 r173 into r227;
    ternary r219 r226 r174 into r228;
    ternary r218 r227 r173 into r229;
    ternary r218 r228 r174 into r230;
    get players[r3[5u32]] into r231;
    get players[r4[5u32]] into r232;
    rand.chacha into r233 as u128;
    rand.chacha into r234 as u128;
    rand.chacha into r235 as u128;
    rand.chacha into r236 as u128;
    rand.chacha into r237 as u128;
    lt r234 r231.speed into r238;
    ternary r238 r231.player_id r232.player_id into r239;
    ternary r238 r231.team_id r232.team_id into r240;
    ternary r238 r231.position r232.position into r241;
    ternary r238 r231.attack r232.attack into r242;
    ternary r238 r231.defense r232.defense into r243;
    ternary r238 r231.speed r232.speed into r244;
    ternary r238 r231.power r232.power into r245;
    ternary r238 r231.stamina r232.stamina into r246;
    ternary r238 r231.technique r232.technique into r247;
    ternary r238 r231.goalkeeping r232.goalkeeping into r248;
    cast r239 r240 r241 r242 r243 r244 r245 r246 r247 r248 into r249 as Player;
    ternary r238 r232.player_id r231.player_id into r250;
    ternary r238 r232.team_id r231.team_id into r251;
    ternary r238 r232.position r231.position into r252;
    ternary r238 r232.attack r231.attack into r253;
    ternary r238 r232.defense r231.defense into r254;
    ternary r238 r232.speed r231.speed into r255;
    ternary r238 r232.power r231.power into r256;
    ternary r238 r232.stamina r231.stamina into r257;
    ternary r238 r232.technique r231.technique into r258;
    ternary r238 r232.goalkeeping r231.goalkeeping into r259;
    cast r250 r251 r252 r253 r254 r255 r256 r257 r258 r259 into r260 as Player;
    ternary r238 r6.player_id r5.player_id into r261;
    ternary r238 r6.team_id r5.team_id into r262;
    ternary r238 r6.position r5.position into r263;
    ternary r238 r6.attack r5.attack into r264;
    ternary r238 r6.defense r5.defense into r265;
    ternary r238 r6.speed r5.speed into r266;
    ternary r238 r6.power r5.power into r267;
    ternary r238 r6.stamina r5.stamina into r268;
    ternary r238 r6.technique r5.technique into r269;
    ternary r238 r6.goalkeeping r5.goalkeeping into r270;
    cast r261 r262 r263 r264 r265 r266 r267 r268 r269 r270 into r271 as Player;
    add r249.attack r249.power into r272;
    add r272 r260.technique into r273;
    gt r273 r235 into r274;
    lt r260.defense r236 into r275;
    lt r271.goalkeeping r237 into r276;
    add r229 1u64 into r277;
    add r230 1u64 into r278;
    ternary r238 r277 r229 into r279;
    ternary r238 r230 r278 into r280;
    ternary r276 r279 r229 into r281;
    ternary r276 r280 r230 into r282;
    ternary r275 r281 r229 into r283;
    ternary r275 r282 r230 into r284;
    ternary r274 r283 r229 into r285;
    ternary r274 r284 r230 into r286;
    get players[r3[6u32]] into r287;
    get players[r4[6u32]] into r288;
    rand.chacha into r289 as u128;
    rand.chacha into r290 as u128;
    rand.chacha into r291 as u128;
    rand.chacha into r292 as u128;
    rand.chacha into r293 as u128;
    lt r290 r287.speed into r294;
    ternary r294 r287.player_id r288.player_id into r295;
    ternary r294 r287.team_id r288.team_id into r296;
    ternary r294 r287.position r288.position into r297;
    ternary r294 r287.attack r288.attack into r298;
    ternary r294 r287.defense r288.defense into r299;
    ternary r294 r287.speed r288.speed into r300;
    ternary r294 r287.power r288.power into r301;
    ternary r294 r287.stamina r288.stamina into r302;
    ternary r294 r287.technique r288.technique into r303;
    ternary r294 r287.goalkeeping r288.goalkeeping into r304;
    cast r295 r296 r297 r298 r299 r300 r301 r302 r303 r304 into r305 as Player;
    ternary r294 r288.player_id r287.player_id into r306;
    ternary r294 r288.team_id r287.team_id into r307;
    ternary r294 r288.position r287.position into r308;
    ternary r294 r288.attack r287.attack into r309;
    ternary r294 r288.defense r287.defense into r310;
    ternary r294 r288.speed r287.speed into r311;
    ternary r294 r288.power r287.power into r312;
    ternary r294 r288.stamina r287.stamina into r313;
    ternary r294 r288.technique r287.technique into r314;
    ternary r294 r288.goalkeeping r287.goalkeeping into r315;
    cast r306 r307 r308 r309 r310 r311 r312 r313 r314 r315 into r316 as Player;
    ternary r294 r6.player_id r5.player_id into r317;
    ternary r294 r6.team_id r5.team_id into r318;
    ternary r294 r6.position r5.position into r319;
    ternary r294 r6.attack r5.attack into r320;
    ternary r294 r6.defense r5.defense into r321;
    ternary r294 r6.speed r5.speed into r322;
    ternary r294 r6.power r5.power into r323;
    ternary r294 r6.stamina r5.stamina into r324;
    ternary r294 r6.technique r5.technique into r325;
    ternary r294 r6.goalkeeping r5.goalkeeping into r326;
    cast r317 r318 r319 r320 r321 r322 r323 r324 r325 r326 into r327 as Player;
    add r305.attack r305.power into r328;
    add r328 r316.technique into r329;
    gt r329 r291 into r330;
    lt r316.defense r292 into r331;
    lt r327.goalkeeping r293 into r332;
    add r285 1u64 into r333;
    add r286 1u64 into r334;
    ternary r294 r333 r285 into r335;
    ternary r294 r286 r334 into r336;
    ternary r332 r335 r285 into r337;
    ternary r332 r336 r286 into r338;
    ternary r331 r337 r285 into r339;
    ternary r331 r338 r286 into r340;
    ternary r330 r339 r285 into r341;
    ternary r330 r340 r286 into r342;
    get players[r3[7u32]] into r343;
    get players[r4[7u32]] into r344;
    rand.chacha into r345 as u128;
    rand.chacha into r346 as u128;
    rand.chacha into r347 as u128;
    rand.chacha into r348 as u128;
    rand.chacha into r349 as u128;
    lt r346 r343.speed into r350;
    ternary r350 r343.player_id r344.player_id into r351;
    ternary r350 r343.team_id r344.team_id into r352;
    ternary r350 r343.position r344.position into r353;
    ternary r350 r343.attack r344.attack into r354;
    ternary r350 r343.defense r344.defense into r355;
    ternary r350 r343.speed r344.speed into r356;
    ternary r350 r343.power r344.power into r357;
    ternary r350 r343.stamina r344.stamina into r358;
    ternary r350 r343.technique r344.technique into r359;
    ternary r350 r343.goalkeeping r344.goalkeeping into r360;
    cast r351 r352 r353 r354 r355 r356 r357 r358 r359 r360 into r361 as Player;
    ternary r350 r344.player_id r343.player_id into r362;
    ternary r350 r344.team_id r343.team_id into r363;
    ternary r350 r344.position r343.position into r364;
    ternary r350 r344.attack r343.attack into r365;
    ternary r350 r344.defense r343.defense into r366;
    ternary r350 r344.speed r343.speed into r367;
    ternary r350 r344.power r343.power into r368;
    ternary r350 r344.stamina r343.stamina into r369;
    ternary r350 r344.technique r343.technique into r370;
    ternary r350 r344.goalkeeping r343.goalkeeping into r371;
    cast r362 r363 r364 r365 r366 r367 r368 r369 r370 r371 into r372 as Player;
    ternary r350 r6.player_id r5.player_id into r373;
    ternary r350 r6.team_id r5.team_id into r374;
    ternary r350 r6.position r5.position into r375;
    ternary r350 r6.attack r5.attack into r376;
    ternary r350 r6.defense r5.defense into r377;
    ternary r350 r6.speed r5.speed into r378;
    ternary r350 r6.power r5.power into r379;
    ternary r350 r6.stamina r5.stamina into r380;
    ternary r350 r6.technique r5.technique into r381;
    ternary r350 r6.goalkeeping r5.goalkeeping into r382;
    cast r373 r374 r375 r376 r377 r378 r379 r380 r381 r382 into r383 as Player;
    add r361.attack r361.power into r384;
    add r384 r372.technique into r385;
    gt r385 r347 into r386;
    lt r372.defense r348 into r387;
    lt r383.goalkeeping r349 into r388;
    add r341 1u64 into r389;
    add r342 1u64 into r390;
    ternary r350 r389 r341 into r391;
    ternary r350 r342 r390 into r392;
    ternary r388 r391 r341 into r393;
    ternary r388 r392 r342 into r394;
    ternary r387 r393 r341 into r395;
    ternary r387 r394 r342 into r396;
    ternary r386 r395 r341 into r397;
    ternary r386 r396 r342 into r398;
    get players[r3[8u32]] into r399;
    get players[r4[8u32]] into r400;
    rand.chacha into r401 as u128;
    rand.chacha into r402 as u128;
    rand.chacha into r403 as u128;
    rand.chacha into r404 as u128;
    rand.chacha into r405 as u128;
    lt r402 r399.speed into r406;
    ternary r406 r399.player_id r400.player_id into r407;
    ternary r406 r399.team_id r400.team_id into r408;
    ternary r406 r399.position r400.position into r409;
    ternary r406 r399.attack r400.attack into r410;
    ternary r406 r399.defense r400.defense into r411;
    ternary r406 r399.speed r400.speed into r412;
    ternary r406 r399.power r400.power into r413;
    ternary r406 r399.stamina r400.stamina into r414;
    ternary r406 r399.technique r400.technique into r415;
    ternary r406 r399.goalkeeping r400.goalkeeping into r416;
    cast r407 r408 r409 r410 r411 r412 r413 r414 r415 r416 into r417 as Player;
    ternary r406 r400.player_id r399.player_id into r418;
    ternary r406 r400.team_id r399.team_id into r419;
    ternary r406 r400.position r399.position into r420;
    ternary r406 r400.attack r399.attack into r421;
    ternary r406 r400.defense r399.defense into r422;
    ternary r406 r400.speed r399.speed into r423;
    ternary r406 r400.power r399.power into r424;
    ternary r406 r400.stamina r399.stamina into r425;
    ternary r406 r400.technique r399.technique into r426;
    ternary r406 r400.goalkeeping r399.goalkeeping into r427;
    cast r418 r419 r420 r421 r422 r423 r424 r425 r426 r427 into r428 as Player;
    ternary r406 r6.player_id r5.player_id into r429;
    ternary r406 r6.team_id r5.team_id into r430;
    ternary r406 r6.position r5.position into r431;
    ternary r406 r6.attack r5.attack into r432;
    ternary r406 r6.defense r5.defense into r433;
    ternary r406 r6.speed r5.speed into r434;
    ternary r406 r6.power r5.power into r435;
    ternary r406 r6.stamina r5.stamina into r436;
    ternary r406 r6.technique r5.technique into r437;
    ternary r406 r6.goalkeeping r5.goalkeeping into r438;
    cast r429 r430 r431 r432 r433 r434 r435 r436 r437 r438 into r439 as Player;
    add r417.attack r417.power into r440;
    add r440 r428.technique into r441;
    gt r441 r403 into r442;
    lt r428.defense r404 into r443;
    lt r439.goalkeeping r405 into r444;
    add r397 1u64 into r445;
    add r398 1u64 into r446;
    ternary r406 r445 r397 into r447;
    ternary r406 r398 r446 into r448;
    ternary r444 r447 r397 into r449;
    ternary r444 r448 r398 into r450;
    ternary r443 r449 r397 into r451;
    ternary r443 r450 r398 into r452;
    ternary r442 r451 r397 into r453;
    ternary r442 r452 r398 into r454;
    get players[r3[9u32]] into r455;
    get players[r4[9u32]] into r456;
    rand.chacha into r457 as u128;
    rand.chacha into r458 as u128;
    rand.chacha into r459 as u128;
    rand.chacha into r460 as u128;
    rand.chacha into r461 as u128;
    lt r458 r455.speed into r462;
    ternary r462 r455.player_id r456.player_id into r463;
    ternary r462 r455.team_id r456.team_id into r464;
    ternary r462 r455.position r456.position into r465;
    ternary r462 r455.attack r456.attack into r466;
    ternary r462 r455.defense r456.defense into r467;
    ternary r462 r455.speed r456.speed into r468;
    ternary r462 r455.power r456.power into r469;
    ternary r462 r455.stamina r456.stamina into r470;
    ternary r462 r455.technique r456.technique into r471;
    ternary r462 r455.goalkeeping r456.goalkeeping into r472;
    cast r463 r464 r465 r466 r467 r468 r469 r470 r471 r472 into r473 as Player;
    ternary r462 r456.player_id r455.player_id into r474;
    ternary r462 r456.team_id r455.team_id into r475;
    ternary r462 r456.position r455.position into r476;
    ternary r462 r456.attack r455.attack into r477;
    ternary r462 r456.defense r455.defense into r478;
    ternary r462 r456.speed r455.speed into r479;
    ternary r462 r456.power r455.power into r480;
    ternary r462 r456.stamina r455.stamina into r481;
    ternary r462 r456.technique r455.technique into r482;
    ternary r462 r456.goalkeeping r455.goalkeeping into r483;
    cast r474 r475 r476 r477 r478 r479 r480 r481 r482 r483 into r484 as Player;
    ternary r462 r6.player_id r5.player_id into r485;
    ternary r462 r6.team_id r5.team_id into r486;
    ternary r462 r6.position r5.position into r487;
    ternary r462 r6.attack r5.attack into r488;
    ternary r462 r6.defense r5.defense into r489;
    ternary r462 r6.speed r5.speed into r490;
    ternary r462 r6.power r5.power into r491;
    ternary r462 r6.stamina r5.stamina into r492;
    ternary r462 r6.technique r5.technique into r493;
    ternary r462 r6.goalkeeping r5.goalkeeping into r494;
    cast r485 r486 r487 r488 r489 r490 r491 r492 r493 r494 into r495 as Player;
    add r473.attack r473.power into r496;
    add r496 r484.technique into r497;
    gt r497 r459 into r498;
    lt r484.defense r460 into r499;
    lt r495.goalkeeping r461 into r500;
    add r453 1u64 into r501;
    add r454 1u64 into r502;
    ternary r462 r501 r453 into r503;
    ternary r462 r454 r502 into r504;
    ternary r500 r503 r453 into r505;
    ternary r500 r504 r454 into r506;
    ternary r499 r505 r453 into r507;
    ternary r499 r506 r454 into r508;
    ternary r498 r507 r453 into r509;
    ternary r498 r508 r454 into r510;
    get players[r3[10u32]] into r511;
    get players[r4[10u32]] into r512;
    rand.chacha into r513 as u128;
    rand.chacha into r514 as u128;
    rand.chacha into r515 as u128;
    rand.chacha into r516 as u128;
    rand.chacha into r517 as u128;
    lt r514 r511.speed into r518;
    ternary r518 r511.player_id r512.player_id into r519;
    ternary r518 r511.team_id r512.team_id into r520;
    ternary r518 r511.position r512.position into r521;
    ternary r518 r511.attack r512.attack into r522;
    ternary r518 r511.defense r512.defense into r523;
    ternary r518 r511.speed r512.speed into r524;
    ternary r518 r511.power r512.power into r525;
    ternary r518 r511.stamina r512.stamina into r526;
    ternary r518 r511.technique r512.technique into r527;
    ternary r518 r511.goalkeeping r512.goalkeeping into r528;
    cast r519 r520 r521 r522 r523 r524 r525 r526 r527 r528 into r529 as Player;
    ternary r518 r512.player_id r511.player_id into r530;
    ternary r518 r512.team_id r511.team_id into r531;
    ternary r518 r512.position r511.position into r532;
    ternary r518 r512.attack r511.attack into r533;
    ternary r518 r512.defense r511.defense into r534;
    ternary r518 r512.speed r511.speed into r535;
    ternary r518 r512.power r511.power into r536;
    ternary r518 r512.stamina r511.stamina into r537;
    ternary r518 r512.technique r511.technique into r538;
    ternary r518 r512.goalkeeping r511.goalkeeping into r539;
    cast r530 r531 r532 r533 r534 r535 r536 r537 r538 r539 into r540 as Player;
    ternary r518 r6.player_id r5.player_id into r541;
    ternary r518 r6.team_id r5.team_id into r542;
    ternary r518 r6.position r5.position into r543;
    ternary r518 r6.attack r5.attack into r544;
    ternary r518 r6.defense r5.defense into r545;
    ternary r518 r6.speed r5.speed into r546;
    ternary r518 r6.power r5.power into r547;
    ternary r518 r6.stamina r5.stamina into r548;
    ternary r518 r6.technique r5.technique into r549;
    ternary r518 r6.goalkeeping r5.goalkeeping into r550;
    cast r541 r542 r543 r544 r545 r546 r547 r548 r549 r550 into r551 as Player;
    add r529.attack r529.power into r552;
    add r552 r540.technique into r553;
    gt r553 r515 into r554;
    lt r540.defense r516 into r555;
    lt r551.goalkeeping r517 into r556;
    add r509 1u64 into r557;
    add r510 1u64 into r558;
    ternary r518 r557 r509 into r559;
    ternary r518 r510 r558 into r560;
    ternary r556 r559 r509 into r561;
    ternary r556 r560 r510 into r562;
    ternary r555 r561 r509 into r563;
    ternary r555 r562 r510 into r564;
    ternary r554 r563 r509 into r565;
    ternary r554 r564 r510 into r566;
    is.eq r565 r566 into r567;
    rand.chacha into r568 as boolean;
    add r566 1u64 into r569;
    add r565 1u64 into r570;
    ternary r568 r569 r566 into r571;
    ternary r568 r565 r570 into r572;
    ternary r567 r571 r566 into r573;
    ternary r567 r572 r565 into r574;
    cast r1 r2 r511.team_id r512.team_id r574 r573 into r575 as GameOutcome;
    set r575 into game_outcomes[r0];


function reveal_answer_game:
    input r0 as football_coins_v001.aleo/ClaimSignature.record;
    input r1 as CalculatedOutcomeNotification.record;
    input r2 as football_coins_v001.aleo/JointPieceState.record;
    input r3 as football_pvp_utils_v001.aleo/Answer.record;
    input r4 as GameOutcome.private;
    assert.eq r2.state_updater_address self.signer;
    assert.eq self.caller self.signer;
    assert.neq r4.goals_home r4.goals_away;
    gt r4.goals_home r4.goals_away into r5;
    ternary r5 r3.opponent_address r3.challenger_address into r6;
    lt r4.goals_home r4.goals_away into r7;
    ternary r7 r3.opponent_address r3.challenger_address into r8;
    call football_pvp_utils_v001.aleo/reveal_answer r3 r0.sig into r9 r10;
    call football_coins_v001.aleo/joint_stake_state_update r2 r0 r6 into r11 r12;
    cast r3.opponent_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r6 r8 11u32 into r13 as GameFinishReqNotification.record;
    cast r3.challenger_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r6 r8 11u32 into r14 as GameFinishReqNotification.record;
    async reveal_answer_game r1.game_multisig r4 into r15;
    output r9 as football_pvp_utils_v001.aleo/RevealAnswer.record;
    output r10 as football_pvp_utils_v001.aleo/AuditRevealAnswer.record;
    output r11 as football_coins_v001.aleo/JointPieceWinner.record;
    output r12 as football_coins_v001.aleo/AuditJointPieceWinner.record;
    output r13 as GameFinishReqNotification.record;
    output r14 as GameFinishReqNotification.record;
    output r15 as football_game_v015.aleo/reveal_answer_game.future;

finalize reveal_answer_game:
    input r0 as address.public;
    input r1 as GameOutcome.public;
    get game_outcomes[r0] into r2;
    assert.eq r1.goals_home r2.goals_home;
    assert.eq r1.goals_away r2.goals_away;


function reveal_answer_game_draw:
    input r0 as football_coins_v001.aleo/ClaimSignature.record;
    input r1 as CalculatedOutcomeNotification.record;
    input r2 as football_coins_v001.aleo/JointPieceState.record;
    input r3 as football_pvp_utils_v001.aleo/Answer.record;
    input r4 as GameOutcome.private;
    assert.eq r2.state_updater_address self.signer;
    assert.eq self.caller self.signer;
    assert.eq r4.goals_home r4.goals_away;
    call football_pvp_utils_v001.aleo/reveal_answer r3 r0.sig into r5 r6;
    call football_coins_v001.aleo/joint_stake_state_update_draw r2 r0 into r7 r8 r9 r10;
    cast r3.opponent_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r3.game_multisig r3.game_multisig 11u32 into r11 as GameFinishReqNotification.record;
    cast r3.challenger_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r3.game_multisig r3.game_multisig 11u32 into r12 as GameFinishReqNotification.record;
    async reveal_answer_game_draw r1.game_multisig r4 into r13;
    output r5 as football_pvp_utils_v001.aleo/RevealAnswer.record;
    output r6 as football_pvp_utils_v001.aleo/AuditRevealAnswer.record;
    output r7 as football_coins_v001.aleo/JointPieceWinner.record;
    output r8 as football_coins_v001.aleo/AuditJointPieceWinner.record;
    output r9 as football_coins_v001.aleo/JointPieceWinner.record;
    output r10 as football_coins_v001.aleo/AuditJointPieceWinner.record;
    output r11 as GameFinishReqNotification.record;
    output r12 as GameFinishReqNotification.record;
    output r13 as football_game_v015.aleo/reveal_answer_game_draw.future;

finalize reveal_answer_game_draw:
    input r0 as address.public;
    input r1 as GameOutcome.public;
    get game_outcomes[r0] into r2;
    assert.eq r1.goals_home r2.goals_home;
    assert.eq r1.goals_away r2.goals_away;


function finish_game:
    input r0 as Game.record;
    input r1 as football_coins_v001.aleo/JointPieceWinner.record;
    input r2 as football_coins_v001.aleo/PieceJointStake.record;
    input r3 as football_coins_v001.aleo/JointPieceTimeClaim.record;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    is.eq r0.challenger_address r1.winner into r4;
    ternary r4 r0.opponent_address r0.challenger_address into r5;
    call football_coins_v001.aleo/joint_stake_transfer_to_winner r1 r2 r3 into r6 r7 r8;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 6field 0u32 into r9 as Game.record;
    cast r0.challenger_address r0.game_multisig 6field false r0.total_pot r0.challenger_address r0.opponent_address r1.winner r5 12u32 into r10 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 6field false r0.total_pot r0.challenger_address r0.opponent_address r1.winner r5 12u32 into r11 as GameFinishedNotification.record;
    output r6 as football_coins_v001.aleo/Piece.record;
    output r7 as football_coins_v001.aleo/AuditTransferToWinner.record;
    output r8 as football_coins_v001.aleo/AuditPieceOwner.record;
    output r9 as Game.record;
    output r10 as GameFinishedNotification.record;
    output r11 as GameFinishedNotification.record;


function finish_game_by_timeout:
    input r0 as Game.record;
    input r1 as football_coins_v001.aleo/PieceJointStake.record;
    input r2 as football_coins_v001.aleo/JointPieceTimeClaim.record;
    input r3 as signature.private;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 9field 0u32 into r4 as Game.record;
    cast r0.challenger_address r0.opponent_address 0field 0field 0u64 3u64 into r5 as GameOutcome;
    cast r0.challenger_address r0.game_multisig 9field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address r0.challenger_address 12u32 into r6 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 9field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address r0.challenger_address 12u32 into r7 as GameFinishedNotification.record;
    call football_coins_v001.aleo/joint_timeout_to_opponent r1 r2 r3 into r8 r9;
    async finish_game_by_timeout r2.block_ht into r10;
    output r8 as football_coins_v001.aleo/Piece.record;
    output r9 as football_coins_v001.aleo/AuditTransferToWinner.record;
    output r4 as Game.record;
    output r6 as GameFinishedNotification.record;
    output r7 as GameFinishedNotification.record;
    output r10 as football_game_v015.aleo/finish_game_by_timeout.future;

finalize finish_game_by_timeout:
    input r0 as u32.public;
    add r0 10000u32 into r1;
    gt block.height r1 into r2;
    assert.eq r2 true;
