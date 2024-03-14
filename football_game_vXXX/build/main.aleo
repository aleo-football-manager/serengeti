import puzzle_pieces_v016.aleo;
import multiparty_pvp_utils_v015_avh.aleo;
program football_game_v014.aleo;


























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
    attack as u16;
    defense as u16;
    speed as u16;
    power as u16;
    stamina as u16;
    technique as u16;
    goalkeeping as u16;

struct GameResult:
    goals_home as u64;
    goals_away as u64;

record Game:
    owner as address.private;
    challenger_commit as field.private;
    opponent_answer as [u8; 11u32].private;
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
    opponent_answer as [u8; 11u32].private;
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
    opponent_answer as [u8; 11u32].private;
    ix as u32.private;

record GameFinishReqNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    challenger_answer as [u8; 11u32].private;
    opponent_answer as [u8; 11u32].private;
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
	key as u8.public;
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
    input r13 as [u8; 11u32].private;
    input r14 as field.private;
    cast r12 into r15 as scalar;
    commit.bhp256 r13 r15 into r16 as field;
    call puzzle_pieces_v016.aleo/stake_transfer_in r0 r2 r3 r4 r5 r1 r6 r7 r8 r9 r10 r11 into r17 r18 r19 r20 r21;
    call multiparty_pvp_utils_v015_avh.aleo/mint_multisig_key r14 r1 r3 r4 r5 into r22 r23;
    add r1 r1 into r24;
    cast r4 r5 1field true r24 r3 r4 2u32 into r25 as GameReqNotification.record;
    add r1 r1 into r26;
    cast r3 r5 1field false r26 r3 r4 3u32 into r27 as WaitingAcceptanceNotification.record;
    cast  0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r28 as [u8; 11u32];
    add r1 r1 into r29;
    cast r5 r16 r28 r29 r3 r4 r5 1field 1u32 into r30 as Game.record;
    call multiparty_pvp_utils_v015_avh.aleo/mint_answer r3 r4 r5 r1 r12 r13 r6 r7 r8 r9 r10 r11 into r31 r32;
    output r17 as puzzle_pieces_v016.aleo/PieceClaim.record;
    output r18 as puzzle_pieces_v016.aleo/PieceStake.record;
    output r19 as puzzle_pieces_v016.aleo/ClaimSignature.record;
    output r20 as puzzle_pieces_v016.aleo/Piece.record;
    output r21 as puzzle_pieces_v016.aleo/AuditStakeIn.record;
    output r31 as multiparty_pvp_utils_v015_avh.aleo/Answer.record;
    output r32 as multiparty_pvp_utils_v015_avh.aleo/AuditMintAnswer.record;
    output r22 as multiparty_pvp_utils_v015_avh.aleo/Key.record;
    output r23 as multiparty_pvp_utils_v015_avh.aleo/AuditKey.record;
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
    input r1 as multiparty_pvp_utils_v015_avh.aleo/Key.record;
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
    input r1 as [u8; 11u32].private;
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
    input r1 as [u8; 11u32].public;
    sub block.height 1000u32 into r2;
    gte r0 r2 into r3;
    assert.eq r3 true;
    add block.height 1000u32 into r4;
    lte r0 r4 into r5;
    assert.eq r5 true;


function calculate_outcome:
    input r0 as RevealAnswerNotification.record;
    input r1 as multiparty_pvp_utils_v015_avh.aleo/Answer.record;
    assert.eq r0.challenger_address self.signer;
    assert.eq self.caller self.signer;
    cast r0.opponent_address r0.game_multisig 4field true r0.total_pot r0.challenger_address r0.opponent_address 9u32 into r2 as WaitingCalculationNotification.record;
    cast r0.challenger_address r0.game_multisig 4field true r0.total_pot r0.challenger_address r0.opponent_address r0.opponent_answer 10u32 into r3 as CalculatedOutcomeNotification.record;
    async calculate_outcome r0.game_multisig r0.challenger_address r0.opponent_address r1.answer r0.opponent_answer into r4;
    output r1 as multiparty_pvp_utils_v015_avh.aleo/Answer.record;
    output r2 as WaitingCalculationNotification.record;
    output r3 as CalculatedOutcomeNotification.record;
    output r4 as football_game_v014.aleo/calculate_outcome.future;

finalize calculate_outcome:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as [u8; 11u32].public;
    input r4 as [u8; 11u32].public;
    get players[r3[10u32]] into r5;
    get players[r4[10u32]] into r6;
    get players[r3[1u32]] into r7;
    get players[r4[1u32]] into r8;
    add r7.speed r8.speed into r9;
    rand.chacha into r10 as u16;
    mod r10 r9 into r11;
    get players[r3[2u32]] into r12;
    get players[r4[2u32]] into r13;
    add r12.speed r13.speed into r14;
    rand.chacha into r15 as u16;
    mod r15 r14 into r16;
    get players[r3[3u32]] into r17;
    get players[r4[3u32]] into r18;
    add r17.speed r18.speed into r19;
    rand.chacha into r20 as u16;
    mod r20 r19 into r21;
    get players[r3[4u32]] into r22;
    get players[r4[4u32]] into r23;
    add r22.speed r23.speed into r24;
    rand.chacha into r25 as u16;
    mod r25 r24 into r26;
    get players[r3[5u32]] into r27;
    get players[r4[5u32]] into r28;
    add r27.speed r28.speed into r29;
    rand.chacha into r30 as u16;
    mod r30 r29 into r31;
    get players[r3[6u32]] into r32;
    get players[r4[6u32]] into r33;
    add r32.speed r33.speed into r34;
    rand.chacha into r35 as u16;
    mod r35 r34 into r36;
    get players[r3[7u32]] into r37;
    get players[r4[7u32]] into r38;
    add r37.speed r38.speed into r39;
    rand.chacha into r40 as u16;
    mod r40 r39 into r41;
    get players[r3[8u32]] into r42;
    get players[r4[8u32]] into r43;
    add r42.speed r43.speed into r44;
    rand.chacha into r45 as u16;
    mod r45 r44 into r46;
    get players[r3[9u32]] into r47;
    get players[r4[9u32]] into r48;
    add r47.speed r48.speed into r49;
    rand.chacha into r50 as u16;
    mod r50 r49 into r51;
    get players[r3[10u32]] into r52;
    get players[r4[10u32]] into r53;
    add r52.speed r53.speed into r54;
    rand.chacha into r55 as u16;
    mod r55 r54 into r56;
    lt r52.speed r53.speed into r57;
    add 0u64 1u64 into r58;
    add 0u64 1u64 into r59;
    ternary r57 r58 0u64 into r60;
    ternary r57 0u64 r59 into r61;
    ternary true r52.player_id r5.player_id into r62;
    ternary true r52.team_id r5.team_id into r63;
    ternary true r52.position r5.position into r64;
    ternary true r52.attack r5.attack into r65;
    ternary true r52.defense r5.defense into r66;
    ternary true r52.speed r5.speed into r67;
    ternary true r52.power r5.power into r68;
    ternary true r52.stamina r5.stamina into r69;
    ternary true r52.technique r5.technique into r70;
    ternary true r52.goalkeeping r5.goalkeeping into r71;
    cast r62 r63 r64 r65 r66 r67 r68 r69 r70 r71 into r72 as Player;
    ternary true r53.player_id r6.player_id into r73;
    ternary true r53.team_id r6.team_id into r74;
    ternary true r53.position r6.position into r75;
    ternary true r53.attack r6.attack into r76;
    ternary true r53.defense r6.defense into r77;
    ternary true r53.speed r6.speed into r78;
    ternary true r53.power r6.power into r79;
    ternary true r53.stamina r6.stamina into r80;
    ternary true r53.technique r6.technique into r81;
    ternary true r53.goalkeeping r6.goalkeeping into r82;
    cast r73 r74 r75 r76 r77 r78 r79 r80 r81 r82 into r83 as Player;
    ternary true r60 0u64 into r84;
    ternary true r61 0u64 into r85;
    cast r1 r2 r72.team_id r72.team_id r85 r84 into r86 as GameOutcome;
    set r86 into game_outcomes[r0];


function reveal_answer_game:
    input r0 as puzzle_pieces_v016.aleo/ClaimSignature.record;
    input r1 as CalculatedOutcomeNotification.record;
    input r2 as puzzle_pieces_v016.aleo/JointPieceState.record;
    input r3 as multiparty_pvp_utils_v015_avh.aleo/Answer.record;
    input r4 as GameOutcome.private;
    assert.eq r2.state_updater_address self.signer;
    assert.eq self.caller self.signer;
    is.eq r1.opponent_answer r3.answer into r5;
    ternary r5 r3.opponent_address r3.challenger_address into r6;
    is.eq r6 r3.challenger_address into r7;
    ternary r7 r3.opponent_address r3.challenger_address into r8;
    call multiparty_pvp_utils_v015_avh.aleo/reveal_answer r3 r0.sig into r9 r10;
    call puzzle_pieces_v016.aleo/joint_stake_state_update r2 r0 r6 into r11 r12;
    cast r3.opponent_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r6 r8 11u32 into r13 as GameFinishReqNotification.record;
    cast r3.challenger_address r3.game_multisig 5field true r2.amount r3.challenger_address r3.opponent_address r3.answer r1.opponent_answer r6 r8 11u32 into r14 as GameFinishReqNotification.record;
    async reveal_answer_game r1.game_multisig r4 into r15;
    output r9 as multiparty_pvp_utils_v015_avh.aleo/RevealAnswer.record;
    output r10 as multiparty_pvp_utils_v015_avh.aleo/AuditRevealAnswer.record;
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
    cast r0.challenger_address r0.opponent_address 0u8 0u8 0u64 3u64 into r5 as GameOutcome;
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
