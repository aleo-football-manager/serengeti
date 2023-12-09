import puzzle_pieces_v015.aleo;
program football_game_v001.aleo;


















struct Player:
    player_id as u8;
    team_id as u8;
    goalkeeper as boolean;
    attack as u8;
    defense as u8;
    speed as u8;
    power as u8;
    stamina as u8;
    technique as u8;
    goalkeeping as u8;

struct GameResult:
    goals_home as u64;
    goals_away as u64;

record Game:
    owner as address.private;
    challenger_commit as field.private;
    opponent_answer as [Player; 11u32].private;
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
    opponent_answer as [Player; 11u32].private;
    ix as u32.private;

record GameFinishReqNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    challenger_answer as [Player; 11u32].private;
    opponent_answer as [Player; 11u32].private;
    winner as address.private;
    loser as address.private;
    goals_home as u64.private;
    goals_away as u64.private;
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

struct Mssage:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

record Answer:
    owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as [Player; 11u32].private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    ix as u32.private;

record AuditMintAnswer:
    owner as address.private;
    answer_owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as [Player; 11u32].private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    ix as u32.private;

record RevealAnswer:
    owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as [Player; 11u32].private;
    sig as signature.private;
    ix as u32.private;

record AuditRevealAnswer:
    owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as [Player; 11u32].private;
    sig as signature.private;
    ix as u32.private;

record Key:
    owner as address.private;
    seed as field.private;
    amount as u64.private;
    challenger as address.private;
    opponent as address.private;
    game_multisig as address.private;
    ix as u32.private;

record AuditKey:
    owner as address.private;
    seed as field.private;
    amount as u64.private;
    challenger as address.private;
    opponent as address.private;
    game_multisig as address.private;
    ix as u32.private;


function main:
    input r0 as boolean.private;


function propose_game:
    input r0 as puzzle_pieces_v015.aleo/Piece.record;
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
    input r13 as [Player; 11u32].private;
    input r14 as field.private;
    assert.eq self.caller self.signer;
    assert.neq r5 r4;
    cast r12 into r15 as scalar;
    commit.bhp256 r13 r15 into r16 as field;
    gt r1 0u64 into r17;
    assert.eq r17 true;
    gte r0.amount r1 into r18;
    assert.eq r18 true;
    call puzzle_pieces_v015.aleo/stake_transfer_in r0 r2 r3 r4 r5 r1 r6 r7 r8 r9 r10 r11 into r19 r20 r21 r22 r23;
    cast r4 r14 r1 r3 r4 r5 5u32 into r24 as Key.record;
    cast aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls r14 r1 r3 r4 r5 6u32 into r25 as AuditKey.record;
    add r1 r1 into r26;
    cast r4 r5 1field true r26 r3 r4 2u32 into r27 as GameReqNotification.record;
    add r1 r1 into r28;
    cast r3 r5 1field false r28 r3 r4 3u32 into r29 as WaitingAcceptanceNotification.record;
    cast 0u8 0u8 false 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r30 as Player;
    cast r30r30r30r30r30r30r30r30r30r30r30 into r31 as [Player; 11u32];
    add r1 r1 into r32;
    cast r5 r16 r31 r32 r3 r4 r5 1field 1u32 into r33 as Game.record;
    cast r6 r7 r8 r9 r10 into r34 as Mssage;
    sign.verify r11 r3 r34 into r35;
    assert.eq true r35;
    cast r3 r3 r4 r5 r1 r12 r13 r6 r7 r8 r9 r10 1u32 into r36 as Answer.record;
    cast aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls r3 r3 r4 r5 r1 r12 r13 r6 r7 r8 r9 r10 2u32 into r37 as AuditMintAnswer.record;
    output r19 as puzzle_pieces_v015.aleo/PieceClaim.record;
    output r20 as puzzle_pieces_v015.aleo/PieceStake.record;
    output r21 as puzzle_pieces_v015.aleo/ClaimSignature.record;
    output r22 as puzzle_pieces_v015.aleo/Piece.record;
    output r23 as puzzle_pieces_v015.aleo/AuditStakeIn.record;
    output r36 as Answer.record;
    output r37 as AuditMintAnswer.record;
    output r24 as Key.record;
    output r25 as AuditKey.record;
    output r33 as Game.record;
    output r27 as GameReqNotification.record;
    output r29 as WaitingAcceptanceNotification.record;


function challenger_renege_stake:
    input r0 as WaitingAcceptanceNotification.record;
    input r1 as puzzle_pieces_v015.aleo/PieceStake.record;
    input r2 as puzzle_pieces_v015.aleo/PieceClaim.record;
    input r3 as signature.private;
    assert.eq self.caller self.signer;
    call puzzle_pieces_v015.aleo/stake_transfer_out r1 r2 r3 into r4 r5;
    cast r0.challenger_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.challenger_address 4u32 into r6 as StakeRenegedNotification.record;
    cast r0.opponent_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.challenger_address 4u32 into r7 as StakeRenegedNotification.record;
    output r4 as puzzle_pieces_v015.aleo/Piece.record;
    output r5 as puzzle_pieces_v015.aleo/AuditStakeOut.record;
    output r6 as StakeRenegedNotification.record;
    output r7 as StakeRenegedNotification.record;


function submit_wager:
    input r0 as puzzle_pieces_v015.aleo/Piece.record;
    input r1 as Key.record;
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
    call puzzle_pieces_v015.aleo/stake_transfer_in r0 r2.opponent_address r2.challenger_address r2.opponent_address r2.game_multisig r12 r3 r4 r5 r6 r7 r8 into r13 r14 r15 r16 r17;
    cast r2.challenger_address r2.game_multisig 2field false r2.total_pot r2.challenger_address r2.opponent_address 5u32 into r18 as ChallengerWagerNotification.record;
    cast r2.opponent_address r2.game_multisig 2field true r2.total_pot r2.challenger_address r2.opponent_address 6u32 into r19 as OpponentWagerNotification.record;
    output r13 as puzzle_pieces_v015.aleo/PieceClaim.record;
    output r14 as puzzle_pieces_v015.aleo/PieceStake.record;
    output r15 as puzzle_pieces_v015.aleo/ClaimSignature.record;
    output r16 as puzzle_pieces_v015.aleo/Piece.record;
    output r17 as puzzle_pieces_v015.aleo/AuditStakeIn.record;
    output r18 as ChallengerWagerNotification.record;
    output r19 as OpponentWagerNotification.record;


function opponent_renege_stake:
    input r0 as WaitingAcceptanceNotification.record;
    input r1 as puzzle_pieces_v015.aleo/PieceStake.record;
    input r2 as puzzle_pieces_v015.aleo/PieceClaim.record;
    input r3 as signature.private;
    assert.eq self.caller self.signer;
    call puzzle_pieces_v015.aleo/stake_transfer_out r1 r2 r3 into r4 r5;
    cast r0.challenger_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address 4u32 into r6 as StakeRenegedNotification.record;
    cast r0.opponent_address r0.game_multisig 0field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address 4u32 into r7 as StakeRenegedNotification.record;
    output r4 as puzzle_pieces_v015.aleo/Piece.record;
    output r5 as puzzle_pieces_v015.aleo/AuditStakeOut.record;
    output r6 as StakeRenegedNotification.record;
    output r7 as StakeRenegedNotification.record;


function accept_game:
    input r0 as Game.record;
    input r1 as [Player; 11u32].private;
    input r2 as puzzle_pieces_v015.aleo/PieceStake.record;
    input r3 as puzzle_pieces_v015.aleo/PieceClaim.record;
    input r4 as puzzle_pieces_v015.aleo/PieceStake.record;
    input r5 as puzzle_pieces_v015.aleo/PieceClaim.record;
    input r6 as u32.private;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    call puzzle_pieces_v015.aleo/transfer_stakes_to_joint r2 r3 r4 r5 r6 into r7 r8 r9 r10;
    cast r0.opponent_address r0.owner 3field false r0.total_pot r0.challenger_address r0.opponent_address 7u32 into r11 as WaitingRevealNotification.record;
    cast r0.challenger_address r0.owner 3field true r0.total_pot r0.challenger_address r0.opponent_address r1 8u32 into r12 as RevealAnswerNotification.record;
    cast r0.owner r0.challenger_commit r1 r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 3field 1u32 into r13 as Game.record;
    async accept_game r6 into r14;
    output r7 as puzzle_pieces_v015.aleo/PieceJointStake.record;
    output r8 as puzzle_pieces_v015.aleo/JointPieceTimeClaim.record;
    output r9 as puzzle_pieces_v015.aleo/JointPieceState.record;
    output r10 as puzzle_pieces_v015.aleo/AuditJointStake.record;
    output r11 as WaitingRevealNotification.record;
    output r12 as RevealAnswerNotification.record;
    output r13 as Game.record;
    output r14 as football_game_v001.aleo/accept_game.future;

finalize accept_game:
    input r0 as u32.public;
    sub block.height 1000u32 into r1;
    gte r0 r1 into r2;
    assert.eq r2 true;
    add block.height 1000u32 into r3;
    lte r0 r3 into r4;
    assert.eq r4 true;


function reveal_answer_game:
    input r0 as RevealAnswerNotification.record;
    input r1 as Answer.record;
    input r2 as puzzle_pieces_v015.aleo/JointPieceState.record;
    input r3 as puzzle_pieces_v015.aleo/ClaimSignature.record;
    assert.eq r2.state_updater_address self.signer;
    assert.eq self.caller self.signer;
    lt r1.answer[0u32].speed r0.opponent_answer[0u32].speed into r4;
    ternary r4 r0.opponent_answer[0u32].player_id r1.answer[0u32].player_id into r5;
    ternary r4 r0.opponent_answer[0u32].team_id r1.answer[0u32].team_id into r6;
    ternary r4 r0.opponent_answer[0u32].goalkeeper r1.answer[0u32].goalkeeper into r7;
    ternary r4 r0.opponent_answer[0u32].attack r1.answer[0u32].attack into r8;
    ternary r4 r0.opponent_answer[0u32].defense r1.answer[0u32].defense into r9;
    ternary r4 r0.opponent_answer[0u32].speed r1.answer[0u32].speed into r10;
    ternary r4 r0.opponent_answer[0u32].power r1.answer[0u32].power into r11;
    ternary r4 r0.opponent_answer[0u32].stamina r1.answer[0u32].stamina into r12;
    ternary r4 r0.opponent_answer[0u32].technique r1.answer[0u32].technique into r13;
    ternary r4 r0.opponent_answer[0u32].goalkeeping r1.answer[0u32].goalkeeping into r14;
    cast r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 into r15 as Player;
    ternary r4 r1.answer[0u32].player_id r0.opponent_answer[0u32].player_id into r16;
    ternary r4 r1.answer[0u32].team_id r0.opponent_answer[0u32].team_id into r17;
    ternary r4 r1.answer[0u32].goalkeeper r0.opponent_answer[0u32].goalkeeper into r18;
    ternary r4 r1.answer[0u32].attack r0.opponent_answer[0u32].attack into r19;
    ternary r4 r1.answer[0u32].defense r0.opponent_answer[0u32].defense into r20;
    ternary r4 r1.answer[0u32].speed r0.opponent_answer[0u32].speed into r21;
    ternary r4 r1.answer[0u32].power r0.opponent_answer[0u32].power into r22;
    ternary r4 r1.answer[0u32].stamina r0.opponent_answer[0u32].stamina into r23;
    ternary r4 r1.answer[0u32].technique r0.opponent_answer[0u32].technique into r24;
    ternary r4 r1.answer[0u32].goalkeeping r0.opponent_answer[0u32].goalkeeping into r25;
    cast r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 into r26 as Player;
    ternary r4 r1.answer[0u32].player_id r0.opponent_answer[0u32].player_id into r27;
    ternary r4 r1.answer[0u32].team_id r0.opponent_answer[0u32].team_id into r28;
    ternary r4 r1.answer[0u32].goalkeeper r0.opponent_answer[0u32].goalkeeper into r29;
    ternary r4 r1.answer[0u32].attack r0.opponent_answer[0u32].attack into r30;
    ternary r4 r1.answer[0u32].defense r0.opponent_answer[0u32].defense into r31;
    ternary r4 r1.answer[0u32].speed r0.opponent_answer[0u32].speed into r32;
    ternary r4 r1.answer[0u32].power r0.opponent_answer[0u32].power into r33;
    ternary r4 r1.answer[0u32].stamina r0.opponent_answer[0u32].stamina into r34;
    ternary r4 r1.answer[0u32].technique r0.opponent_answer[0u32].technique into r35;
    ternary r4 r1.answer[0u32].goalkeeping r0.opponent_answer[0u32].goalkeeping into r36;
    cast r27 r28 r29 r30 r31 r32 r33 r34 r35 r36 into r37 as Player;
    gt r15.attack 128u8 into r38;
    lt r26.defense 127u8 into r39;
    lt r37.goalkeeping 127u8 into r40;
    lt r1.answer[0u32].speed r0.opponent_answer[0u32].speed into r41;
    add 0u64 1u64 into r42;
    add 0u64 1u64 into r43;
    ternary r41 r42 0u64 into r44;
    ternary r41 0u64 r43 into r45;
    ternary r40 r44 0u64 into r46;
    ternary r40 r45 0u64 into r47;
    ternary r39 r46 0u64 into r48;
    ternary r39 r47 0u64 into r49;
    ternary r38 r48 0u64 into r50;
    ternary r38 r49 0u64 into r51;
    lt r1.answer[1u32].speed r0.opponent_answer[1u32].speed into r52;
    ternary r52 r0.opponent_answer[1u32].player_id r1.answer[1u32].player_id into r53;
    ternary r52 r0.opponent_answer[1u32].team_id r1.answer[1u32].team_id into r54;
    ternary r52 r0.opponent_answer[1u32].goalkeeper r1.answer[1u32].goalkeeper into r55;
    ternary r52 r0.opponent_answer[1u32].attack r1.answer[1u32].attack into r56;
    ternary r52 r0.opponent_answer[1u32].defense r1.answer[1u32].defense into r57;
    ternary r52 r0.opponent_answer[1u32].speed r1.answer[1u32].speed into r58;
    ternary r52 r0.opponent_answer[1u32].power r1.answer[1u32].power into r59;
    ternary r52 r0.opponent_answer[1u32].stamina r1.answer[1u32].stamina into r60;
    ternary r52 r0.opponent_answer[1u32].technique r1.answer[1u32].technique into r61;
    ternary r52 r0.opponent_answer[1u32].goalkeeping r1.answer[1u32].goalkeeping into r62;
    cast r53 r54 r55 r56 r57 r58 r59 r60 r61 r62 into r63 as Player;
    ternary r52 r1.answer[1u32].player_id r0.opponent_answer[1u32].player_id into r64;
    ternary r52 r1.answer[1u32].team_id r0.opponent_answer[1u32].team_id into r65;
    ternary r52 r1.answer[1u32].goalkeeper r0.opponent_answer[1u32].goalkeeper into r66;
    ternary r52 r1.answer[1u32].attack r0.opponent_answer[1u32].attack into r67;
    ternary r52 r1.answer[1u32].defense r0.opponent_answer[1u32].defense into r68;
    ternary r52 r1.answer[1u32].speed r0.opponent_answer[1u32].speed into r69;
    ternary r52 r1.answer[1u32].power r0.opponent_answer[1u32].power into r70;
    ternary r52 r1.answer[1u32].stamina r0.opponent_answer[1u32].stamina into r71;
    ternary r52 r1.answer[1u32].technique r0.opponent_answer[1u32].technique into r72;
    ternary r52 r1.answer[1u32].goalkeeping r0.opponent_answer[1u32].goalkeeping into r73;
    cast r64 r65 r66 r67 r68 r69 r70 r71 r72 r73 into r74 as Player;
    ternary r52 r1.answer[0u32].player_id r0.opponent_answer[0u32].player_id into r75;
    ternary r52 r1.answer[0u32].team_id r0.opponent_answer[0u32].team_id into r76;
    ternary r52 r1.answer[0u32].goalkeeper r0.opponent_answer[0u32].goalkeeper into r77;
    ternary r52 r1.answer[0u32].attack r0.opponent_answer[0u32].attack into r78;
    ternary r52 r1.answer[0u32].defense r0.opponent_answer[0u32].defense into r79;
    ternary r52 r1.answer[0u32].speed r0.opponent_answer[0u32].speed into r80;
    ternary r52 r1.answer[0u32].power r0.opponent_answer[0u32].power into r81;
    ternary r52 r1.answer[0u32].stamina r0.opponent_answer[0u32].stamina into r82;
    ternary r52 r1.answer[0u32].technique r0.opponent_answer[0u32].technique into r83;
    ternary r52 r1.answer[0u32].goalkeeping r0.opponent_answer[0u32].goalkeeping into r84;
    cast r75 r76 r77 r78 r79 r80 r81 r82 r83 r84 into r85 as Player;
    gt r63.attack 128u8 into r86;
    lt r74.defense 127u8 into r87;
    lt r85.goalkeeping 127u8 into r88;
    lt r1.answer[1u32].speed r0.opponent_answer[1u32].speed into r89;
    add r50 1u64 into r90;
    add r51 1u64 into r91;
    ternary r89 r90 r50 into r92;
    ternary r89 r51 r91 into r93;
    ternary r88 r92 r50 into r94;
    ternary r88 r93 r51 into r95;
    ternary r87 r94 r50 into r96;
    ternary r87 r95 r51 into r97;
    ternary r86 r96 r50 into r98;
    ternary r86 r97 r51 into r99;
    assert.eq r1.owner r1.challenger_address;
    cast r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 into r100 as Mssage;
    sign.verify r3.sig r1.challenger_address r100 into r101;
    assert.eq true r101;
    cast r1.game_multisig r1.challenger_address r1.opponent_address r1.game_multisig r1.amount r1.nonce r1.answer r3.sig 3u32 into r102 as RevealAnswer.record;
    cast aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls r1.challenger_address r1.opponent_address r1.game_multisig r1.amount r1.nonce r1.answer r3.sig 4u32 into r103 as AuditRevealAnswer.record;
    call puzzle_pieces_v015.aleo/joint_stake_state_update r2 r3 r1.challenger_address into r104 r105;
    cast r1.opponent_address r1.game_multisig 4field true r2.amount r1.challenger_address r1.opponent_address r1.answer r0.opponent_answer r1.challenger_address r1.challenger_address r99 r98 9u32 into r106 as GameFinishReqNotification.record;
    cast r1.challenger_address r1.game_multisig 4field true r2.amount r1.challenger_address r1.opponent_address r1.answer r0.opponent_answer r1.challenger_address r1.challenger_address r99 r98 9u32 into r107 as GameFinishReqNotification.record;
    output r102 as RevealAnswer.record;
    output r103 as AuditRevealAnswer.record;
    output r104 as puzzle_pieces_v015.aleo/JointPieceWinner.record;
    output r105 as puzzle_pieces_v015.aleo/AuditJointPieceWinner.record;
    output r106 as GameFinishReqNotification.record;
    output r107 as GameFinishReqNotification.record;


function finish_game:
    input r0 as Game.record;
    input r1 as puzzle_pieces_v015.aleo/JointPieceWinner.record;
    input r2 as puzzle_pieces_v015.aleo/PieceJointStake.record;
    input r3 as puzzle_pieces_v015.aleo/JointPieceTimeClaim.record;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    is.eq r1.winner r0.challenger_address into r4;
    ternary r4 r0.opponent_address r0.challenger_address into r5;
    call puzzle_pieces_v015.aleo/joint_stake_transfer_to_winner r1 r2 r3 into r6 r7 r8;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 3field 0u32 into r9 as Game.record;
    cast r0.challenger_address r0.game_multisig 5field false r0.total_pot r0.challenger_address r0.opponent_address r1.winner r5 10u32 into r10 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 5field false r0.total_pot r0.challenger_address r0.opponent_address r1.winner r5 10u32 into r11 as GameFinishedNotification.record;
    output r6 as puzzle_pieces_v015.aleo/Piece.record;
    output r7 as puzzle_pieces_v015.aleo/AuditTransferToWinner.record;
    output r8 as puzzle_pieces_v015.aleo/AuditPieceOwner.record;
    output r9 as Game.record;
    output r10 as GameFinishedNotification.record;
    output r11 as GameFinishedNotification.record;


function finish_game_by_timeout:
    input r0 as Game.record;
    input r1 as puzzle_pieces_v015.aleo/PieceJointStake.record;
    input r2 as puzzle_pieces_v015.aleo/JointPieceTimeClaim.record;
    input r3 as signature.private;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 3field 0u32 into r4 as Game.record;
    cast r0.challenger_address r0.game_multisig 6field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address r0.challenger_address 10u32 into r5 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 6field false r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_address r0.challenger_address 10u32 into r6 as GameFinishedNotification.record;
    call puzzle_pieces_v015.aleo/joint_timeout_to_opponent r1 r2 r3 into r7 r8;
    async finish_game_by_timeout r2.block_ht into r9;
    output r7 as puzzle_pieces_v015.aleo/Piece.record;
    output r8 as puzzle_pieces_v015.aleo/AuditTransferToWinner.record;
    output r4 as Game.record;
    output r5 as GameFinishedNotification.record;
    output r6 as GameFinishedNotification.record;
    output r9 as football_game_v001.aleo/finish_game_by_timeout.future;

finalize finish_game_by_timeout:
    input r0 as u32.public;
    add r0 10000u32 into r1;
    gt block.height r1 into r2;
    assert.eq r2 true;
