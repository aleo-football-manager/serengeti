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
    cast r1 r2 r5.team_id r6.team_id 0u64 0u64 into r7 as GameOutcome;
    set r7 into game_outcomes[r0];


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
