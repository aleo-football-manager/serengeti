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
    get players[r3[10u32]] into r5;
    get players[r4[10u32]] into r6;
    get players[r3[1u32]] into r7;
    get players[r4[1u32]] into r8;
    rand.chacha into r9 as u128;
    add r7.speed r8.speed into r10;
    mod r9 r10 into r11;
    lt r11 r7.speed into r12;
    ternary r12 r7.player_id r8.player_id into r13;
    ternary r12 r7.team_id r8.team_id into r14;
    ternary r12 r7.position r8.position into r15;
    ternary r12 r7.attack r8.attack into r16;
    ternary r12 r7.defense r8.defense into r17;
    ternary r12 r7.speed r8.speed into r18;
    ternary r12 r7.power r8.power into r19;
    ternary r12 r7.stamina r8.stamina into r20;
    ternary r12 r7.technique r8.technique into r21;
    ternary r12 r7.goalkeeping r8.goalkeeping into r22;
    cast r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 into r23 as Player;
    ternary r12 r8.player_id r7.player_id into r24;
    ternary r12 r8.team_id r7.team_id into r25;
    ternary r12 r8.position r7.position into r26;
    ternary r12 r8.attack r7.attack into r27;
    ternary r12 r8.defense r7.defense into r28;
    ternary r12 r8.speed r7.speed into r29;
    ternary r12 r8.power r7.power into r30;
    ternary r12 r8.stamina r7.stamina into r31;
    ternary r12 r8.technique r7.technique into r32;
    ternary r12 r8.goalkeeping r7.goalkeeping into r33;
    cast r24 r25 r26 r27 r28 r29 r30 r31 r32 r33 into r34 as Player;
    get players[r4[0u32]] into r35;
    get players[r3[0u32]] into r36;
    ternary r12 r35.player_id r36.player_id into r37;
    ternary r12 r35.team_id r36.team_id into r38;
    ternary r12 r35.position r36.position into r39;
    ternary r12 r35.attack r36.attack into r40;
    ternary r12 r35.defense r36.defense into r41;
    ternary r12 r35.speed r36.speed into r42;
    ternary r12 r35.power r36.power into r43;
    ternary r12 r35.stamina r36.stamina into r44;
    ternary r12 r35.technique r36.technique into r45;
    ternary r12 r35.goalkeeping r36.goalkeeping into r46;
    cast r37 r38 r39 r40 r41 r42 r43 r44 r45 r46 into r47 as Player;
    get players[r3[2u32]] into r48;
    get players[r4[2u32]] into r49;
    rand.chacha into r50 as u128;
    add r48.speed r49.speed into r51;
    mod r50 r51 into r52;
    lt r52 r48.speed into r53;
    ternary r53 r48.player_id r49.player_id into r54;
    ternary r53 r48.team_id r49.team_id into r55;
    ternary r53 r48.position r49.position into r56;
    ternary r53 r48.attack r49.attack into r57;
    ternary r53 r48.defense r49.defense into r58;
    ternary r53 r48.speed r49.speed into r59;
    ternary r53 r48.power r49.power into r60;
    ternary r53 r48.stamina r49.stamina into r61;
    ternary r53 r48.technique r49.technique into r62;
    ternary r53 r48.goalkeeping r49.goalkeeping into r63;
    cast r54 r55 r56 r57 r58 r59 r60 r61 r62 r63 into r64 as Player;
    ternary r53 r49.player_id r48.player_id into r65;
    ternary r53 r49.team_id r48.team_id into r66;
    ternary r53 r49.position r48.position into r67;
    ternary r53 r49.attack r48.attack into r68;
    ternary r53 r49.defense r48.defense into r69;
    ternary r53 r49.speed r48.speed into r70;
    ternary r53 r49.power r48.power into r71;
    ternary r53 r49.stamina r48.stamina into r72;
    ternary r53 r49.technique r48.technique into r73;
    ternary r53 r49.goalkeeping r48.goalkeeping into r74;
    cast r65 r66 r67 r68 r69 r70 r71 r72 r73 r74 into r75 as Player;
    get players[r4[0u32]] into r76;
    get players[r3[0u32]] into r77;
    ternary r53 r76.player_id r77.player_id into r78;
    ternary r53 r76.team_id r77.team_id into r79;
    ternary r53 r76.position r77.position into r80;
    ternary r53 r76.attack r77.attack into r81;
    ternary r53 r76.defense r77.defense into r82;
    ternary r53 r76.speed r77.speed into r83;
    ternary r53 r76.power r77.power into r84;
    ternary r53 r76.stamina r77.stamina into r85;
    ternary r53 r76.technique r77.technique into r86;
    ternary r53 r76.goalkeeping r77.goalkeeping into r87;
    cast r78 r79 r80 r81 r82 r83 r84 r85 r86 r87 into r88 as Player;
    get players[r3[3u32]] into r89;
    get players[r4[3u32]] into r90;
    rand.chacha into r91 as u128;
    add r89.speed r90.speed into r92;
    mod r91 r92 into r93;
    lt r93 r89.speed into r94;
    ternary r94 r89.player_id r90.player_id into r95;
    ternary r94 r89.team_id r90.team_id into r96;
    ternary r94 r89.position r90.position into r97;
    ternary r94 r89.attack r90.attack into r98;
    ternary r94 r89.defense r90.defense into r99;
    ternary r94 r89.speed r90.speed into r100;
    ternary r94 r89.power r90.power into r101;
    ternary r94 r89.stamina r90.stamina into r102;
    ternary r94 r89.technique r90.technique into r103;
    ternary r94 r89.goalkeeping r90.goalkeeping into r104;
    cast r95 r96 r97 r98 r99 r100 r101 r102 r103 r104 into r105 as Player;
    ternary r94 r90.player_id r89.player_id into r106;
    ternary r94 r90.team_id r89.team_id into r107;
    ternary r94 r90.position r89.position into r108;
    ternary r94 r90.attack r89.attack into r109;
    ternary r94 r90.defense r89.defense into r110;
    ternary r94 r90.speed r89.speed into r111;
    ternary r94 r90.power r89.power into r112;
    ternary r94 r90.stamina r89.stamina into r113;
    ternary r94 r90.technique r89.technique into r114;
    ternary r94 r90.goalkeeping r89.goalkeeping into r115;
    cast r106 r107 r108 r109 r110 r111 r112 r113 r114 r115 into r116 as Player;
    get players[r4[0u32]] into r117;
    get players[r3[0u32]] into r118;
    ternary r94 r117.player_id r118.player_id into r119;
    ternary r94 r117.team_id r118.team_id into r120;
    ternary r94 r117.position r118.position into r121;
    ternary r94 r117.attack r118.attack into r122;
    ternary r94 r117.defense r118.defense into r123;
    ternary r94 r117.speed r118.speed into r124;
    ternary r94 r117.power r118.power into r125;
    ternary r94 r117.stamina r118.stamina into r126;
    ternary r94 r117.technique r118.technique into r127;
    ternary r94 r117.goalkeeping r118.goalkeeping into r128;
    cast r119 r120 r121 r122 r123 r124 r125 r126 r127 r128 into r129 as Player;
    get players[r3[4u32]] into r130;
    get players[r4[4u32]] into r131;
    rand.chacha into r132 as u128;
    add r130.speed r131.speed into r133;
    mod r132 r133 into r134;
    lt r134 r130.speed into r135;
    ternary r135 r130.player_id r131.player_id into r136;
    ternary r135 r130.team_id r131.team_id into r137;
    ternary r135 r130.position r131.position into r138;
    ternary r135 r130.attack r131.attack into r139;
    ternary r135 r130.defense r131.defense into r140;
    ternary r135 r130.speed r131.speed into r141;
    ternary r135 r130.power r131.power into r142;
    ternary r135 r130.stamina r131.stamina into r143;
    ternary r135 r130.technique r131.technique into r144;
    ternary r135 r130.goalkeeping r131.goalkeeping into r145;
    cast r136 r137 r138 r139 r140 r141 r142 r143 r144 r145 into r146 as Player;
    ternary r135 r131.player_id r130.player_id into r147;
    ternary r135 r131.team_id r130.team_id into r148;
    ternary r135 r131.position r130.position into r149;
    ternary r135 r131.attack r130.attack into r150;
    ternary r135 r131.defense r130.defense into r151;
    ternary r135 r131.speed r130.speed into r152;
    ternary r135 r131.power r130.power into r153;
    ternary r135 r131.stamina r130.stamina into r154;
    ternary r135 r131.technique r130.technique into r155;
    ternary r135 r131.goalkeeping r130.goalkeeping into r156;
    cast r147 r148 r149 r150 r151 r152 r153 r154 r155 r156 into r157 as Player;
    get players[r4[0u32]] into r158;
    get players[r3[0u32]] into r159;
    ternary r135 r158.player_id r159.player_id into r160;
    ternary r135 r158.team_id r159.team_id into r161;
    ternary r135 r158.position r159.position into r162;
    ternary r135 r158.attack r159.attack into r163;
    ternary r135 r158.defense r159.defense into r164;
    ternary r135 r158.speed r159.speed into r165;
    ternary r135 r158.power r159.power into r166;
    ternary r135 r158.stamina r159.stamina into r167;
    ternary r135 r158.technique r159.technique into r168;
    ternary r135 r158.goalkeeping r159.goalkeeping into r169;
    cast r160 r161 r162 r163 r164 r165 r166 r167 r168 r169 into r170 as Player;
    get players[r3[5u32]] into r171;
    get players[r4[5u32]] into r172;
    rand.chacha into r173 as u128;
    add r171.speed r172.speed into r174;
    mod r173 r174 into r175;
    lt r175 r171.speed into r176;
    ternary r176 r171.player_id r172.player_id into r177;
    ternary r176 r171.team_id r172.team_id into r178;
    ternary r176 r171.position r172.position into r179;
    ternary r176 r171.attack r172.attack into r180;
    ternary r176 r171.defense r172.defense into r181;
    ternary r176 r171.speed r172.speed into r182;
    ternary r176 r171.power r172.power into r183;
    ternary r176 r171.stamina r172.stamina into r184;
    ternary r176 r171.technique r172.technique into r185;
    ternary r176 r171.goalkeeping r172.goalkeeping into r186;
    cast r177 r178 r179 r180 r181 r182 r183 r184 r185 r186 into r187 as Player;
    ternary r176 r172.player_id r171.player_id into r188;
    ternary r176 r172.team_id r171.team_id into r189;
    ternary r176 r172.position r171.position into r190;
    ternary r176 r172.attack r171.attack into r191;
    ternary r176 r172.defense r171.defense into r192;
    ternary r176 r172.speed r171.speed into r193;
    ternary r176 r172.power r171.power into r194;
    ternary r176 r172.stamina r171.stamina into r195;
    ternary r176 r172.technique r171.technique into r196;
    ternary r176 r172.goalkeeping r171.goalkeeping into r197;
    cast r188 r189 r190 r191 r192 r193 r194 r195 r196 r197 into r198 as Player;
    get players[r4[0u32]] into r199;
    get players[r3[0u32]] into r200;
    ternary r176 r199.player_id r200.player_id into r201;
    ternary r176 r199.team_id r200.team_id into r202;
    ternary r176 r199.position r200.position into r203;
    ternary r176 r199.attack r200.attack into r204;
    ternary r176 r199.defense r200.defense into r205;
    ternary r176 r199.speed r200.speed into r206;
    ternary r176 r199.power r200.power into r207;
    ternary r176 r199.stamina r200.stamina into r208;
    ternary r176 r199.technique r200.technique into r209;
    ternary r176 r199.goalkeeping r200.goalkeeping into r210;
    cast r201 r202 r203 r204 r205 r206 r207 r208 r209 r210 into r211 as Player;
    get players[r3[6u32]] into r212;
    get players[r4[6u32]] into r213;
    rand.chacha into r214 as u128;
    add r212.speed r213.speed into r215;
    mod r214 r215 into r216;
    lt r216 r212.speed into r217;
    ternary r217 r212.player_id r213.player_id into r218;
    ternary r217 r212.team_id r213.team_id into r219;
    ternary r217 r212.position r213.position into r220;
    ternary r217 r212.attack r213.attack into r221;
    ternary r217 r212.defense r213.defense into r222;
    ternary r217 r212.speed r213.speed into r223;
    ternary r217 r212.power r213.power into r224;
    ternary r217 r212.stamina r213.stamina into r225;
    ternary r217 r212.technique r213.technique into r226;
    ternary r217 r212.goalkeeping r213.goalkeeping into r227;
    cast r218 r219 r220 r221 r222 r223 r224 r225 r226 r227 into r228 as Player;
    ternary r217 r213.player_id r212.player_id into r229;
    ternary r217 r213.team_id r212.team_id into r230;
    ternary r217 r213.position r212.position into r231;
    ternary r217 r213.attack r212.attack into r232;
    ternary r217 r213.defense r212.defense into r233;
    ternary r217 r213.speed r212.speed into r234;
    ternary r217 r213.power r212.power into r235;
    ternary r217 r213.stamina r212.stamina into r236;
    ternary r217 r213.technique r212.technique into r237;
    ternary r217 r213.goalkeeping r212.goalkeeping into r238;
    cast r229 r230 r231 r232 r233 r234 r235 r236 r237 r238 into r239 as Player;
    get players[r4[0u32]] into r240;
    get players[r3[0u32]] into r241;
    ternary r217 r240.player_id r241.player_id into r242;
    ternary r217 r240.team_id r241.team_id into r243;
    ternary r217 r240.position r241.position into r244;
    ternary r217 r240.attack r241.attack into r245;
    ternary r217 r240.defense r241.defense into r246;
    ternary r217 r240.speed r241.speed into r247;
    ternary r217 r240.power r241.power into r248;
    ternary r217 r240.stamina r241.stamina into r249;
    ternary r217 r240.technique r241.technique into r250;
    ternary r217 r240.goalkeeping r241.goalkeeping into r251;
    cast r242 r243 r244 r245 r246 r247 r248 r249 r250 r251 into r252 as Player;
    get players[r3[7u32]] into r253;
    get players[r4[7u32]] into r254;
    rand.chacha into r255 as u128;
    add r253.speed r254.speed into r256;
    mod r255 r256 into r257;
    lt r257 r253.speed into r258;
    ternary r258 r253.player_id r254.player_id into r259;
    ternary r258 r253.team_id r254.team_id into r260;
    ternary r258 r253.position r254.position into r261;
    ternary r258 r253.attack r254.attack into r262;
    ternary r258 r253.defense r254.defense into r263;
    ternary r258 r253.speed r254.speed into r264;
    ternary r258 r253.power r254.power into r265;
    ternary r258 r253.stamina r254.stamina into r266;
    ternary r258 r253.technique r254.technique into r267;
    ternary r258 r253.goalkeeping r254.goalkeeping into r268;
    cast r259 r260 r261 r262 r263 r264 r265 r266 r267 r268 into r269 as Player;
    ternary r258 r254.player_id r253.player_id into r270;
    ternary r258 r254.team_id r253.team_id into r271;
    ternary r258 r254.position r253.position into r272;
    ternary r258 r254.attack r253.attack into r273;
    ternary r258 r254.defense r253.defense into r274;
    ternary r258 r254.speed r253.speed into r275;
    ternary r258 r254.power r253.power into r276;
    ternary r258 r254.stamina r253.stamina into r277;
    ternary r258 r254.technique r253.technique into r278;
    ternary r258 r254.goalkeeping r253.goalkeeping into r279;
    cast r270 r271 r272 r273 r274 r275 r276 r277 r278 r279 into r280 as Player;
    get players[r4[0u32]] into r281;
    get players[r3[0u32]] into r282;
    ternary r258 r281.player_id r282.player_id into r283;
    ternary r258 r281.team_id r282.team_id into r284;
    ternary r258 r281.position r282.position into r285;
    ternary r258 r281.attack r282.attack into r286;
    ternary r258 r281.defense r282.defense into r287;
    ternary r258 r281.speed r282.speed into r288;
    ternary r258 r281.power r282.power into r289;
    ternary r258 r281.stamina r282.stamina into r290;
    ternary r258 r281.technique r282.technique into r291;
    ternary r258 r281.goalkeeping r282.goalkeeping into r292;
    cast r283 r284 r285 r286 r287 r288 r289 r290 r291 r292 into r293 as Player;
    get players[r3[8u32]] into r294;
    get players[r4[8u32]] into r295;
    rand.chacha into r296 as u128;
    add r294.speed r295.speed into r297;
    mod r296 r297 into r298;
    lt r298 r294.speed into r299;
    ternary r299 r294.player_id r295.player_id into r300;
    ternary r299 r294.team_id r295.team_id into r301;
    ternary r299 r294.position r295.position into r302;
    ternary r299 r294.attack r295.attack into r303;
    ternary r299 r294.defense r295.defense into r304;
    ternary r299 r294.speed r295.speed into r305;
    ternary r299 r294.power r295.power into r306;
    ternary r299 r294.stamina r295.stamina into r307;
    ternary r299 r294.technique r295.technique into r308;
    ternary r299 r294.goalkeeping r295.goalkeeping into r309;
    cast r300 r301 r302 r303 r304 r305 r306 r307 r308 r309 into r310 as Player;
    ternary r299 r295.player_id r294.player_id into r311;
    ternary r299 r295.team_id r294.team_id into r312;
    ternary r299 r295.position r294.position into r313;
    ternary r299 r295.attack r294.attack into r314;
    ternary r299 r295.defense r294.defense into r315;
    ternary r299 r295.speed r294.speed into r316;
    ternary r299 r295.power r294.power into r317;
    ternary r299 r295.stamina r294.stamina into r318;
    ternary r299 r295.technique r294.technique into r319;
    ternary r299 r295.goalkeeping r294.goalkeeping into r320;
    cast r311 r312 r313 r314 r315 r316 r317 r318 r319 r320 into r321 as Player;
    get players[r4[0u32]] into r322;
    get players[r3[0u32]] into r323;
    ternary r299 r322.player_id r323.player_id into r324;
    ternary r299 r322.team_id r323.team_id into r325;
    ternary r299 r322.position r323.position into r326;
    ternary r299 r322.attack r323.attack into r327;
    ternary r299 r322.defense r323.defense into r328;
    ternary r299 r322.speed r323.speed into r329;
    ternary r299 r322.power r323.power into r330;
    ternary r299 r322.stamina r323.stamina into r331;
    ternary r299 r322.technique r323.technique into r332;
    ternary r299 r322.goalkeeping r323.goalkeeping into r333;
    cast r324 r325 r326 r327 r328 r329 r330 r331 r332 r333 into r334 as Player;
    get players[r3[9u32]] into r335;
    get players[r4[9u32]] into r336;
    rand.chacha into r337 as u128;
    add r335.speed r336.speed into r338;
    mod r337 r338 into r339;
    lt r339 r335.speed into r340;
    ternary r340 r335.player_id r336.player_id into r341;
    ternary r340 r335.team_id r336.team_id into r342;
    ternary r340 r335.position r336.position into r343;
    ternary r340 r335.attack r336.attack into r344;
    ternary r340 r335.defense r336.defense into r345;
    ternary r340 r335.speed r336.speed into r346;
    ternary r340 r335.power r336.power into r347;
    ternary r340 r335.stamina r336.stamina into r348;
    ternary r340 r335.technique r336.technique into r349;
    ternary r340 r335.goalkeeping r336.goalkeeping into r350;
    cast r341 r342 r343 r344 r345 r346 r347 r348 r349 r350 into r351 as Player;
    ternary r340 r336.player_id r335.player_id into r352;
    ternary r340 r336.team_id r335.team_id into r353;
    ternary r340 r336.position r335.position into r354;
    ternary r340 r336.attack r335.attack into r355;
    ternary r340 r336.defense r335.defense into r356;
    ternary r340 r336.speed r335.speed into r357;
    ternary r340 r336.power r335.power into r358;
    ternary r340 r336.stamina r335.stamina into r359;
    ternary r340 r336.technique r335.technique into r360;
    ternary r340 r336.goalkeeping r335.goalkeeping into r361;
    cast r352 r353 r354 r355 r356 r357 r358 r359 r360 r361 into r362 as Player;
    get players[r4[0u32]] into r363;
    get players[r3[0u32]] into r364;
    ternary r340 r363.player_id r364.player_id into r365;
    ternary r340 r363.team_id r364.team_id into r366;
    ternary r340 r363.position r364.position into r367;
    ternary r340 r363.attack r364.attack into r368;
    ternary r340 r363.defense r364.defense into r369;
    ternary r340 r363.speed r364.speed into r370;
    ternary r340 r363.power r364.power into r371;
    ternary r340 r363.stamina r364.stamina into r372;
    ternary r340 r363.technique r364.technique into r373;
    ternary r340 r363.goalkeeping r364.goalkeeping into r374;
    cast r365 r366 r367 r368 r369 r370 r371 r372 r373 r374 into r375 as Player;
    get players[r3[10u32]] into r376;
    get players[r4[10u32]] into r377;
    rand.chacha into r378 as u128;
    add r376.speed r377.speed into r379;
    mod r378 r379 into r380;
    lt r380 r376.speed into r381;
    ternary r381 r376.player_id r377.player_id into r382;
    ternary r381 r376.team_id r377.team_id into r383;
    ternary r381 r376.position r377.position into r384;
    ternary r381 r376.attack r377.attack into r385;
    ternary r381 r376.defense r377.defense into r386;
    ternary r381 r376.speed r377.speed into r387;
    ternary r381 r376.power r377.power into r388;
    ternary r381 r376.stamina r377.stamina into r389;
    ternary r381 r376.technique r377.technique into r390;
    ternary r381 r376.goalkeeping r377.goalkeeping into r391;
    cast r382 r383 r384 r385 r386 r387 r388 r389 r390 r391 into r392 as Player;
    ternary r381 r377.player_id r376.player_id into r393;
    ternary r381 r377.team_id r376.team_id into r394;
    ternary r381 r377.position r376.position into r395;
    ternary r381 r377.attack r376.attack into r396;
    ternary r381 r377.defense r376.defense into r397;
    ternary r381 r377.speed r376.speed into r398;
    ternary r381 r377.power r376.power into r399;
    ternary r381 r377.stamina r376.stamina into r400;
    ternary r381 r377.technique r376.technique into r401;
    ternary r381 r377.goalkeeping r376.goalkeeping into r402;
    cast r393 r394 r395 r396 r397 r398 r399 r400 r401 r402 into r403 as Player;
    get players[r4[0u32]] into r404;
    get players[r3[0u32]] into r405;
    ternary r381 r404.player_id r405.player_id into r406;
    ternary r381 r404.team_id r405.team_id into r407;
    ternary r381 r404.position r405.position into r408;
    ternary r381 r404.attack r405.attack into r409;
    ternary r381 r404.defense r405.defense into r410;
    ternary r381 r404.speed r405.speed into r411;
    ternary r381 r404.power r405.power into r412;
    ternary r381 r404.stamina r405.stamina into r413;
    ternary r381 r404.technique r405.technique into r414;
    ternary r381 r404.goalkeeping r405.goalkeeping into r415;
    cast r406 r407 r408 r409 r410 r411 r412 r413 r414 r415 into r416 as Player;
    lt r376.speed r377.speed into r417;
    add 0u64 1u64 into r418;
    add 0u64 1u64 into r419;
    ternary r417 r418 0u64 into r420;
    ternary r417 0u64 r419 into r421;
    ternary true r376.player_id r5.player_id into r422;
    ternary true r376.team_id r5.team_id into r423;
    ternary true r376.position r5.position into r424;
    ternary true r376.attack r5.attack into r425;
    ternary true r376.defense r5.defense into r426;
    ternary true r376.speed r5.speed into r427;
    ternary true r376.power r5.power into r428;
    ternary true r376.stamina r5.stamina into r429;
    ternary true r376.technique r5.technique into r430;
    ternary true r376.goalkeeping r5.goalkeeping into r431;
    cast r422 r423 r424 r425 r426 r427 r428 r429 r430 r431 into r432 as Player;
    ternary true r377.player_id r6.player_id into r433;
    ternary true r377.team_id r6.team_id into r434;
    ternary true r377.position r6.position into r435;
    ternary true r377.attack r6.attack into r436;
    ternary true r377.defense r6.defense into r437;
    ternary true r377.speed r6.speed into r438;
    ternary true r377.power r6.power into r439;
    ternary true r377.stamina r6.stamina into r440;
    ternary true r377.technique r6.technique into r441;
    ternary true r377.goalkeeping r6.goalkeeping into r442;
    cast r433 r434 r435 r436 r437 r438 r439 r440 r441 r442 into r443 as Player;
    ternary true r420 0u64 into r444;
    ternary true r421 0u64 into r445;
    cast r1 r2 r432.team_id r432.team_id r445 r444 into r446 as GameOutcome;
    set r446 into game_outcomes[r0];


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
