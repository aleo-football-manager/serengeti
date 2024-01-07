import puzzle_pieces_v016.leo;
import multiparty_pvp_utils_v015_avh.leo; //customized for u8 player array instead of field
import football_leaderboard_v003.leo;

program football_game_v007.aleo {
    
    transition main (a: bool) {}

    /////////////////////////////
    // MAPPING                 //
    /////////////////////////////

    // Frontend generates unique id (field) to map gameOutcome.
    mapping game_outcomes: field => GameOutcome;
    mapping players: u8 => Player;

    transition add_player (player: Player) {
        // Only to be called by the contract owner
        assert_eq(self.caller, self.signer);
        return then finalize (player);
    }
    finalize add_player (player: Player) {
        // Player with player_id 0 should have 0 for all stats. Don't allow manually adding this player_id.
        if (player.player_id == 0u8) {
            Mapping::set(players, player.player_id, Player{
                player_id: 0u8,
                team_id: 0u8,
                position: 0field, // 0 = Emtpy, 1 = Goalkeep, 2 = Defense, 3 = Mid, 4 = Attack
                attack: 0u8,
                defense: 0u8,
                speed: 0u8,
                power: 0u8,
                stamina: 0u8,
                technique: 0u8,
                goalkeeping: 0u8,
            });
        } else {
            // TODO: Allow overwrites or not?
            assert(player.position == 1field || player.position == 2field || player.position == 3field || player.position == 4field);
            Mapping::set(players, player.player_id, player);
        }
    }

    function test (x: address) {
        let y: field = x as field;
    }

    /////////////////////////////
    // STRUCTS                 //
    /////////////////////////////

    struct GameOutcome {
        goals_home: u64,
        goals_away: u64,
    }

  struct Player {
        player_id: u8,
        team_id: u8,
        position: field, // 0 = Emtpy, 1 = Goalkeep, 2 = Defense, 3 = Mid, 4 = Attack
        attack: u8,
        defense: u8,
        speed: u8,
        power: u8,
        stamina: u8,
        technique: u8,
        goalkeeping: u8,
    }


    struct GameResult {
        goals_home: u64,
        goals_away: u64,
    }

    // ix: 1
    record Game {
        owner: address,
        uuid: field,
        challenger_commit: field,
        opponent_answer: [u8; 11],
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        game_state: field,
        ix: u32,
    }

    // GAME STATE RECORDED ON NOTIFICATIONS
    // private game_state: field,
        // NORMAL FLOW
        // 1 -> challenger proposed game
        // 2 -> opponent matched wager
        // 3 -> accepted game
        // 4 -> determine winner using randomness
        // 5 -> challenger revealed answer +
        // 6 -> process outcome and claim total pot
        // 7 -> finished game
        //
        // ALTERNATE EXIT PATHS
        // 9 -> timeout finished game
        // 0 -> Game reneged

    // your turn:
        // true -> your turn or ms turn
        // false -> awaiting other party turn

    // sent to opponent on propose game for FE/client detection.
    // consumed in match wager
    // ix: 2
    record GameReqNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        ix: u32,
    }

    // sent to challenger on propose game for FE/client detection.
    // consumed in reveal answer
    // ix: 3
    record WaitingAcceptanceNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        ix: u32,
    }

    // ix: 4
    record StakeRenegedNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        renege_address: address,
        ix: u32,
    }

    // sent to challenger on submit wager for FE/client detection.
    // consumed in reveal answer
    // ix: 5
    record ChallengerWagerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        ix: u32,
    }

    // ix: 6
    record OpponentWagerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        ix: u32,
    }

    // sent to opponent on accept game for FE/client detection.
    // consumed in finish_game/claim total pot
    // ix: 7
    record WaitingRevealNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        ix: u32,
    }
    
    // sent to opponent on accept game for FE/client detection.
    // consumed in finish_game/claim total pot
    // ix: 7
    record CalculatedOutcomeNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        result_mapping_uuid: field,
        ix: u32,
    }

    // sent to challenger on accept game for FE/client detection.
    // consumed in reveal answer
    // ix: 8
    record RevealAnswerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        opponent_answer: [u8; 11],
        game_uuid: field,
        ix: u32,
    }

    // sent to opponent on reveal answer for FE/client detection.
    // ix: 9
    record GameFinishReqNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        challenger_answer: [u8; 11],
        opponent_answer: [u8; 11],
        ix: u32,
    }

    // sent to both opponent and challenger on finish game
    // ix: 10
    record GameFinishedNotification {
        owner: address,
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        winner: address,
        loser: address,
        ix: u32,
    }

    // New propose game
    transition propose_game (
        //puzzle_pieces.stake_transfer_in() data
        wager_record: puzzle_pieces_v016.leo/Piece.record,
        challenger_wager_amount: u64,
        sender: address, // Challenger address proposing game
        challenger: address,
        opponent: address,
        game_multisig: address,
        challenger_message_1: field, //from output of useSignature
        challenger_message_2: field,
        challenger_message_3: field,
        challenger_message_4: field,
        challenger_message_5: field,
        challenger_sig: signature, //from output of useSignature
        //multiparty_pvp_utils data
        challenger_nonce: field,
        challenger_answer: [u8; 11],
        game_multisig_seed: field, //game_multisig seed to send to user
        //wheres_alex data
        uuid: field,
    ) -> (
        puzzle_pieces_v016.leo/PieceClaim.record,
        puzzle_pieces_v016.leo/PieceStake.record,
        puzzle_pieces_v016.leo/ClaimSignature.record,
        puzzle_pieces_v016.leo/Piece.record,
        puzzle_pieces_v016.leo/AuditStakeIn.record,
        multiparty_pvp_utils_v015_avh.leo/Answer.record,
        multiparty_pvp_utils_v015_avh.leo/AuditMintAnswer.record,
        multiparty_pvp_utils_v015_avh.leo/Key.record,
        multiparty_pvp_utils_v015_avh.leo/AuditKey.record,
        Game,
        GameReqNotification,
        WaitingAcceptanceNotification,
    ) {

        // assert contracts can't call this
        // assert_eq(self.caller, self.signer);

        // random edge case, maybe unnecessary
        // assert_neq(game_multisig, opponent);

        // assert that player 1s answer is either "in weeds" or "behind building"
        
        // hash the answer and nonce
        let challenger_commit: field = BHP256::commit_to_field(challenger_answer, challenger_nonce as scalar);

        // assert that the wager amount > 0 and wager inside credit == wager amt passed
        // assert(challenger_wager_amount > 0u64);
        // assert that the wager record has >= amount wagered
        // assert(wager_record.amount >= challenger_wager_amount);

        let (
            piece_claim_challenger,
            piece_stake_challenger,
            claim_signature_challenger,
            piece_change_challenger,
            audit_stake_in_record
        ): (
            PieceClaim,
            PieceStake,
            ClaimSignature,
            Piece,
            AuditStakeIn
        ) = puzzle_pieces_v016.leo/stake_transfer_in(
            wager_record,
            sender,
            challenger,
            opponent,
            game_multisig,
            challenger_wager_amount,
            challenger_message_1,
            challenger_message_2,
            challenger_message_3,
            challenger_message_4,
            challenger_message_5,
            challenger_sig
        );

        let (
            key_record,
            audit_key_record
        ) : (
            Key,
            AuditKey
        ) = multiparty_pvp_utils_v015_avh.leo/mint_multisig_key(game_multisig_seed,challenger_wager_amount,challenger,opponent,game_multisig);


        let game_request_notification_record: GameReqNotification = GameReqNotification {
            owner: opponent, //opponent
            game_multisig: game_multisig,
            game_state: 1field,
            your_turn: true,
            total_pot: challenger_wager_amount + challenger_wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
            ix: 2u32,
        };

        let game_waiting_acceptance_notification_record: WaitingAcceptanceNotification = WaitingAcceptanceNotification {
            owner: challenger, //challenger
            game_multisig: game_multisig,
            game_state: 1field,
            your_turn: false,
            total_pot: challenger_wager_amount + challenger_wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
            ix: 3u32,
        };


        let game_record: Game = Game {
            uuid: uuid,
            owner: game_multisig,
            challenger_commit: challenger_commit,
            opponent_answer: [0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8], // random field for now until opponent answer in accept_game
            total_pot: challenger_wager_amount + challenger_wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            game_state: 1field,
            ix: 1u32,
        };

        let (challenger_answer_record, audit_mint_answer_record):  (Answer, AuditMintAnswer) = multiparty_pvp_utils_v015_avh.leo/mint_answer(
                challenger,
                opponent,
                game_multisig,
                challenger_wager_amount,
                challenger_nonce,
                challenger_answer,
                challenger_message_1,
                challenger_message_2,
                challenger_message_3,
                challenger_message_4,
                challenger_message_5,
                challenger_sig
        );

        return (
            piece_claim_challenger,
            piece_stake_challenger,
            claim_signature_challenger,
            piece_change_challenger,
            audit_stake_in_record,
            challenger_answer_record,
            audit_mint_answer_record,
            key_record,
            audit_key_record,
            game_record,
            game_request_notification_record,
            game_waiting_acceptance_notification_record,
        )
        then finalize (challenger_answer);
        
    }

    finalize propose_game (
        challenger_answer: [u8; 11],
        ) {
            let amount_goalkeepers: u8 = 0u8;
            let player_one: Player = Mapping::get(players, challenger_answer[0u8]);
            
            // for i: u8 in 1u8..11u8 {
            //     let player: Player = Mapping::get(players, challenger_answer[i]);
            //     if (player.position == 1field) {
            //         amount_goalkeepers += 1u8;
            //     }
            //     assert_eq(player.team_id, player_one.team_id);
            // }
            // assert_eq(amount_goalkeepers, 1u8);
    }

    // challenger calls this function with Multisig key and signature as input
    // that was submitted when proposing game and that exists on claim record
    transition challenger_renege_stake
    (
        waiting_accept_game_notification: WaitingAcceptanceNotification,
        piece_stake_challenger: puzzle_pieces_v016.leo/PieceStake.record,
        piece_claim_challenger: puzzle_pieces_v016.leo/PieceClaim.record,
        challenger_sig: signature,
    ) -> (
        puzzle_pieces_v016.leo/Piece.record,
        puzzle_pieces_v016.leo/AuditStakeOut.record,
        StakeRenegedNotification,
        StakeRenegedNotification,
        )
    {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let (piece_record, audit_stake_out_record): (Piece, AuditStakeOut) = puzzle_pieces_v016.leo/stake_transfer_out(piece_stake_challenger, piece_claim_challenger, challenger_sig);

        let notify_challenger_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
            owner: waiting_accept_game_notification.challenger_address, //opponent
            game_multisig: waiting_accept_game_notification.game_multisig,
            game_state: 0field,
            your_turn: false,
            total_pot: waiting_accept_game_notification.total_pot,
            challenger_address: waiting_accept_game_notification.challenger_address,
            opponent_address: waiting_accept_game_notification.opponent_address,
            renege_address: waiting_accept_game_notification.challenger_address,
            ix: 4u32,
        };


        let notify_opponent_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
            owner: waiting_accept_game_notification.opponent_address, //opponent
            game_multisig: waiting_accept_game_notification.game_multisig,
            game_state: 0field,
            your_turn: false,
            total_pot: waiting_accept_game_notification.total_pot,
            challenger_address: waiting_accept_game_notification.challenger_address,
            opponent_address: waiting_accept_game_notification.opponent_address,
            renege_address: waiting_accept_game_notification.challenger_address,
            ix: 4u32,
        };

        return (piece_record, audit_stake_out_record, notify_challenger_stake_reneged, notify_opponent_stake_reneged);

    }

    transition submit_wager (
        opponent_wager_record: puzzle_pieces_v016.leo/Piece.record,
        key_record: multiparty_pvp_utils_v015_avh.leo/Key.record,
        game_req_notification: GameReqNotification,
        opponent_message_1: field, //from output of useSignature
        opponent_message_2: field,
        opponent_message_3: field,
        opponent_message_4: field,
        opponent_message_5: field,
        opponent_sig: signature, //from output of useSignature
    ) -> (
        puzzle_pieces_v016.leo/PieceClaim.record,
        puzzle_pieces_v016.leo/PieceStake.record,
        puzzle_pieces_v016.leo/ClaimSignature.record,
        puzzle_pieces_v016.leo/Piece.record,
        puzzle_pieces_v016.leo/AuditStakeIn.record,
        ChallengerWagerNotification,
        OpponentWagerNotification,
    )
    {

        // Logic Checks
        // limit calls to only users
        assert_eq(self.caller, self.signer);

        // assert that the wager amount > 0 and wager inside credit == wager amt passed
        assert(opponent_wager_record.amount > 0u64);
        // assert that the wager record has >= total pot / 2u64
        assert(opponent_wager_record.amount >= game_req_notification.total_pot / 2u64);

        let (
            piece_claim_opponent,
            piece_stake_opponent,
            claim_signature_opponent,
            piece_change_opponent,
            audit_stake_in_record,
        ): (
            PieceClaim,
            PieceStake,
            ClaimSignature,
            Piece,
            AuditStakeIn
        ) = puzzle_pieces_v016.leo/stake_transfer_in(
            opponent_wager_record,
            game_req_notification.opponent_address, // sender
            game_req_notification.challenger_address, // challenger
            game_req_notification.opponent_address,
            game_req_notification.game_multisig,
            game_req_notification.total_pot / 2u64, // divide total pot by 2
            opponent_message_1,
            opponent_message_2,
            opponent_message_3,
            opponent_message_4,
            opponent_message_5,
            opponent_sig,
        );

        let challenger_submitted_wager_notification_record: ChallengerWagerNotification = ChallengerWagerNotification {
            owner: game_req_notification.challenger_address,
            game_multisig: game_req_notification.game_multisig,
            game_state: 2field,
            your_turn: false,
            total_pot: game_req_notification.total_pot,
            challenger_address: game_req_notification.challenger_address,
            opponent_address: game_req_notification.opponent_address,
            ix: 5u32,

        };

        let opponent_submitted_wager_notification_record: OpponentWagerNotification = OpponentWagerNotification {
            owner: game_req_notification.opponent_address,
            game_multisig: game_req_notification.game_multisig,
            game_state: 2field,
            your_turn: true,
            total_pot: game_req_notification.total_pot,
            challenger_address: game_req_notification.challenger_address,
            opponent_address: game_req_notification.opponent_address,
            ix: 6u32,
        };

        return (
            piece_claim_opponent,
            piece_stake_opponent,
            claim_signature_opponent,
            piece_change_opponent,
            audit_stake_in_record,
            challenger_submitted_wager_notification_record,
            opponent_submitted_wager_notification_record,
        );
    }

    // opponent calls this function with Multisig key and signature as input
    // that was submitted when submitting wager that exists on claim record
    transition opponent_renege_stake
    (
        waiting_accept_game_notification: WaitingAcceptanceNotification,
        piece_stake_opponent: puzzle_pieces_v016.leo/PieceStake.record,
        piece_claim_opponent: puzzle_pieces_v016.leo/PieceClaim.record,
        opponent_sig: signature,
    ) -> (
        puzzle_pieces_v016.leo/Piece.record,
        puzzle_pieces_v016.leo/AuditStakeOut.record,
        StakeRenegedNotification,
        StakeRenegedNotification,
        )
    {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let (piece_record, audit_stake_out_record): (Piece, AuditStakeOut) = puzzle_pieces_v016.leo/stake_transfer_out(piece_stake_opponent, piece_claim_opponent, opponent_sig);

        let notify_challenger_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
            owner: waiting_accept_game_notification.challenger_address, //opponent
            game_multisig: waiting_accept_game_notification.game_multisig,
            game_state: 0field,
            your_turn: false,
            total_pot: waiting_accept_game_notification.total_pot,
            challenger_address: waiting_accept_game_notification.challenger_address,
            opponent_address: waiting_accept_game_notification.opponent_address,
            renege_address: waiting_accept_game_notification.opponent_address,
            ix: 4u32,
        };


        let notify_opponent_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
            owner: waiting_accept_game_notification.opponent_address, //opponent
            game_multisig: waiting_accept_game_notification.game_multisig,
            game_state: 0field,
            your_turn: false,
            total_pot: waiting_accept_game_notification.total_pot,
            challenger_address: waiting_accept_game_notification.challenger_address,
            opponent_address: waiting_accept_game_notification.opponent_address,
            renege_address: waiting_accept_game_notification.opponent_address,
            ix: 4u32,
        };

        return (piece_record, audit_stake_out_record, notify_challenger_stake_reneged, notify_opponent_stake_reneged);

    }

    // called by ms key after wager is confirmed on network
    transition accept_game
    (
        game_record: Game,
        opponent_answer: [u8;11],
        piece_stake_challenger: puzzle_pieces_v016.leo/PieceStake.record,
        piece_claim_challenger: puzzle_pieces_v016.leo/PieceClaim.record,
        piece_stake_opponent: puzzle_pieces_v016.leo/PieceStake.record,
        piece_claim_opponent: puzzle_pieces_v016.leo/PieceClaim.record,
        block_ht: u32,
    ) -> (
        puzzle_pieces_v016.leo/PieceJointStake.record,
        puzzle_pieces_v016.leo/JointPieceTimeClaim.record,
        puzzle_pieces_v016.leo/JointPieceState.record,
        puzzle_pieces_v016.leo/AuditJointStake.record,
        WaitingRevealNotification,
        RevealAnswerNotification,
        Game,
    )
    {

        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // TODO: assert that player 1s answer is a valid formation

        let (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            audit_joint_stake
        ): (
            PieceJointStake,
            JointPieceTimeClaim,
            JointPieceState,
            AuditJointStake
        ) = puzzle_pieces_v016.leo/transfer_stakes_to_joint(
            piece_stake_challenger,
            piece_claim_challenger,
            piece_stake_opponent,
            piece_claim_opponent,
            block_ht,
        );

        // sent to opponent on accept_game
        let waiting_reveal_answer_notifcation_record: WaitingRevealNotification = WaitingRevealNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.owner,
            game_state: 3field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            ix: 7u32,
        };

        // sent to challenger on accept_game
        let reveal_answer_notification_record: RevealAnswerNotification = RevealAnswerNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.owner,
            game_state: 3field,
            your_turn: true,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            opponent_answer: opponent_answer,
            game_uuid: game_record.uuid,
            ix: 8u32,
        };

        let updated_game_record: Game = Game {
            uuid: game_record.uuid,
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field,
            ix: 1u32,
        };

        return (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            audit_joint_stake,
            waiting_reveal_answer_notifcation_record,
            reveal_answer_notification_record,
            updated_game_record,
        ) then finalize (block_ht, opponent_answer);
    }

    finalize accept_game
    (
        block_ht: u32,
        opponent_answer: [u8; 11],
    )
    {
        // Validate opponent formation
        let amount_goalkeepers: u8 = 0u8;
        let same_team: bool = true;
        let player_one: Player = Mapping::get(players, opponent_answer[0u8]);
        
        for i: u8 in 1u8..11u8 {
            let player: Player = Mapping::get(players, opponent_answer[0u8]);
            if (player.position == 1field) {
                amount_goalkeepers += 1u8;
            }
            assert_eq(player.team_id, player_one.team_id);
        }
        assert_eq(amount_goalkeepers, 1u8);

        // block every 5 seconds or so
        // would need to wait for time between `accept_game` req. from client to being proved
        // ~ 5s per block
        // leeway of 100 blocks = 100 * 5 = 500 / 60 = ~8.33 mins.
        // assert that block_ht passed in is within 1000 blocks of current block ht.
        //
        // Check legit block height as input
        let current_block_ht: u32 = block.height;
        assert(block_ht >= current_block_ht - 1000u32);
        assert(block_ht <= current_block_ht + 1000u32);
    }

    // called by challenger to calculate and store outcome
    transition calculate_outcome
    (
        challenger_claim_signature: puzzle_pieces_v016.leo/ClaimSignature.record,
        reveal_answer_notification_record: RevealAnswerNotification,
        joint_piece_state: puzzle_pieces_v016.leo/JointPieceState.record,
        challenger_answer_record: multiparty_pvp_utils_v015_avh.leo/Answer.record,
    ) 
    -> (
        multiparty_pvp_utils_v015_avh.leo/Answer.record,
        puzzle_pieces_v016.leo/JointPieceState.record,
        )
    {

        // assert that the correct state updater address is the challenger and the challenger
        // is invoking this
        assert_eq(joint_piece_state.state_updater_address, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // determine winner! If opponent correctly picked where the challenger hid alex, the opponent wins otherwise the challenger wins
        let challenger_sig: signature = challenger_claim_signature.sig;

        // retrieve revealedanswer record

        let (revealed_answer_record, audit_revealed_answer_record): (RevealAnswer, AuditRevealAnswer) = multiparty_pvp_utils_v015_avh.leo/reveal_answer(challenger_answer_record, challenger_sig);

        // sent to challenger on accept_game
        let calculate_outcome_notification_record: CalculatedOutcomeNotification = CalculatedOutcomeNotification {
            owner: reveal_answer_notification_record.challenger_address, //TODO is this correct?
            game_multisig: reveal_answer_notification_record.game_multisig,
            game_state: 4field,
            your_turn: true,
            total_pot: reveal_answer_notification_record.total_pot,
            challenger_address: reveal_answer_notification_record.challenger_address,
            opponent_address: reveal_answer_notification_record.opponent_address,
            result_mapping_uuid: reveal_answer_notification_record.game_uuid,
            ix: 8u32,
        };

        return (challenger_answer_record, joint_piece_state)
        
        then finalize (reveal_answer_notification_record.game_uuid, reveal_answer_notification_record.opponent_answer, challenger_answer_record.answer);
    }

    finalize calculate_outcome (
        uuid: field,
        home_formation: [u8; 11],
        away_formation: [u8; 11],
    ) {
        // let home_formation: [Player;11] = challenger_answer_record.answer;
        // let away_formation: [Player;11] = reveal_answer_notification_record.opponent_answer;
        let goals_home: u64 = 0u64;
        let goals_away: u64 = 0u64;

        let home_player: Player = Mapping::get(players, home_formation[10u8]);
        let away_player: Player = Mapping::get(players, away_formation[10u8]);

        for i: u8 in 1u8..11u8 {

            // TODO GET PLAYER FROM MAPPING
        // for i: u8 in 1u8..11u8 { // put this back lol i gave keeper 200 attack 
            // See which team attacks 
            home_player = Mapping::get(players, home_formation[i]);
            away_player = Mapping::get(players, away_formation[i]);
            let attacker: Player = home_player.speed > away_player.speed ? home_player : away_player;
            let defender: Player = home_player.speed > away_player.speed ? away_player : home_player;
            let goalkeeper: Player = home_player.speed > away_player.speed ? Mapping::get(players, away_formation[0u8]) : Mapping::get(players, home_formation[0u8]);

            // Attacker shoots, attack stat determines if it's on target.
            if (attacker.attack > ChaCha::rand_u8()) {
                // Defender blocks, defense stat determines if it's blocked.
                if defender.defense < ChaCha::rand_u8() {
                    // Goalkeeper saves, goalkeeping stat determines if it's saved.
                    if goalkeeper.goalkeeping < ChaCha::rand_u8() {
                        // If not saved, record the goal for attacking team.
                        if (home_player.speed < away_player.speed) {
                            goals_away += 1u64;
                        } else {
                            goals_home += 1u64;
                        }
                    }
                }
            }
        }

        // const i: u8 = 1u8;
        if (home_player.speed < away_player.speed) {
            goals_away += 1u64;
        } else {
            goals_home += 1u64;
        }

        let game_outcome: GameOutcome = GameOutcome {
            goals_home,
            goals_away,
        };

        Mapping::set(game_outcomes, uuid, game_outcome);
    }

    transition reveal_answer_game (
        challenger_claim_signature: puzzle_pieces_v016.leo/ClaimSignature.record,
        reveal_answer_notification_record: RevealAnswerNotification,
        joint_piece_state: puzzle_pieces_v016.leo/JointPieceState.record,
        challenger_answer_record: multiparty_pvp_utils_v015_avh.leo/Answer.record,
        game_outcome: GameOutcome,
    ) -> (
        multiparty_pvp_utils_v015_avh.leo/RevealAnswer.record,
        multiparty_pvp_utils_v015_avh.leo/AuditRevealAnswer.record,
        puzzle_pieces_v016.leo/JointPieceWinner.record,
        puzzle_pieces_v016.leo/AuditJointPieceWinner.record,
        GameFinishReqNotification,
        GameFinishReqNotification,)
    {
    // // assert that the correct state updater address is the challenger and the challenger
        // is invoking this
        assert_eq(joint_piece_state.state_updater_address, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // determine winner! If opponent correctly picked where the challenger hid alex, the opponent wins otherwise the challenger wins
        let winner_address: address = reveal_answer_notification_record.opponent_answer == challenger_answer_record.answer ? challenger_answer_record.opponent_address : challenger_answer_record.challenger_address;
        let loser_address: address = winner_address == challenger_answer_record.challenger_address ? challenger_answer_record.opponent_address : challenger_answer_record.challenger_address;
        let challenger_sig: signature = challenger_claim_signature.sig;

        // retrieve revealedanswer record
        let (revealed_answer_record, audit_revealed_answer_record): (RevealAnswer, AuditRevealAnswer) = multiparty_pvp_utils_v015_avh.leo/reveal_answer(challenger_answer_record, challenger_sig);

        let (joint_piece_winner, audit_joint_piece_winner): (JointPieceWinner, AuditJointPieceWinner) = puzzle_pieces_v016.leo/joint_stake_state_update(joint_piece_state, challenger_claim_signature, winner_address);


        let game_finish_req_notification_record_opponent: GameFinishReqNotification = GameFinishReqNotification {
            owner: challenger_answer_record.opponent_address,
            game_multisig: challenger_answer_record.game_multisig,
            game_state: 5field,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            challenger_address: challenger_answer_record.challenger_address,
            opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer_record.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            ix: 9u32,
        };

        let game_finish_req_notification_record_challenger: GameFinishReqNotification = GameFinishReqNotification{
            owner: challenger_answer_record.challenger_address,
            game_multisig: challenger_answer_record.game_multisig,
            game_state: 5field,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            challenger_address: challenger_answer_record.challenger_address,
            opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer_record.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            ix: 9u32,
        };
    
        return (revealed_answer_record, audit_revealed_answer_record, joint_piece_winner, audit_joint_piece_winner, game_finish_req_notification_record_opponent, game_finish_req_notification_record_challenger)
        then finalize (reveal_answer_notification_record.game_uuid, game_outcome);
    }

    finalize reveal_answer_game (uuid: field, input_outcome: GameOutcome) {
        // Compare the input outcome to the stored outcome from mapping.
        let stored_outcome: GameOutcome = Mapping::get(game_outcomes, uuid);
        assert_eq(input_outcome.goals_home, stored_outcome.goals_home);
        assert_eq(input_outcome.goals_away, stored_outcome.goals_away);
    }

    // called by ms key to finish the game and get the total pot!
    transition finish_game
    (
        game_record: Game,
        joint_piece_winner: puzzle_pieces_v016.leo/JointPieceWinner.record,
        piece_joint_stake: puzzle_pieces_v016.leo/PieceJointStake.record,
        joint_piece_time_claim: puzzle_pieces_v016.leo/JointPieceTimeClaim.record,
        game_outcome: GameOutcome,
    ) -> (
        puzzle_pieces_v016.leo/Piece.record,
        puzzle_pieces_v016.leo/AuditTransferToWinner.record,
        puzzle_pieces_v016.leo/AuditPieceOwner.record,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {

        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let winner_address: address = game_outcome.goals_home > game_outcome.goals_away ? game_record.challenger_address : game_record.opponent_address;
        let loser_address: address = game_outcome.goals_home > game_outcome.goals_away ? game_record.opponent_address : game_record.challenger_address;

        let (piece_record, audit_transfer_to_winner_record, audit_piece_owner): (Piece, AuditTransferToWinner, AuditPieceOwner) = puzzle_pieces_v016.leo/joint_stake_transfer_to_winner(
            joint_piece_winner,
            piece_joint_stake,
            joint_piece_time_claim,
        );

        let updated_game_record: Game = Game {
            uuid: game_record.uuid,
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field,
            ix: 0u32,
        };

        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 6field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: joint_piece_winner.winner,
            loser: loser_address,
            ix: 10u32,
        };

        let game_finished_notification_opponent_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 6field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: joint_piece_winner.winner,
            loser: loser_address,
            ix: 10u32,
        };

        football_leaderboard_v003.leo/update_leaderboard(game_record.challenger_address, game_record.opponent_address, game_outcome.goals_home, game_outcome.goals_home);

        return (piece_record, audit_transfer_to_winner_record, audit_piece_owner, updated_game_record, game_finished_notification_challenger_record, game_finished_notification_opponent_record)
        then finalize(game_record.uuid, game_record.challenger_address, game_record.opponent_address, game_outcome);
    }

    finalize finish_game (uuid: field, home_address: address, away_address: address, input_outcome: GameOutcome) {
        // Compare the input outcome to the stored outcome from mapping.
        let stored_outcome: GameOutcome = Mapping::get(game_outcomes, uuid);
        assert_eq(input_outcome.goals_home, stored_outcome.goals_home);
        assert_eq(input_outcome.goals_away, stored_outcome.goals_away);

    }

    // called by ms key via opponent to finish the game and get the total pot!
    transition finish_game_by_timeout(
        game_record: Game,
        piece_joint_stake: puzzle_pieces_v016.leo/PieceJointStake.record,
        joint_piece_time_claim: puzzle_pieces_v016.leo/JointPieceTimeClaim.record,
        sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
    ) -> (
        puzzle_pieces_v016.leo/Piece.record,
        puzzle_pieces_v016.leo/AuditTransferToWinner.record,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {
        // assert that the game address/multisig is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // Update the game state
        let updated_game_record: Game = Game {
            uuid: game_record.uuid,
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field,
            ix: 0u32,
        };

        // Notification to challenger of game finished
        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 7field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: game_record.opponent_address,
            loser: game_record.challenger_address,
            ix: 10u32,
        };

        // Notification to opponent of game finished
        let game_finished_notification_opponent_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 7field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: game_record.opponent_address,
            loser: game_record.challenger_address,
            ix: 10u32,
        };

        // Payout to winner
        let (piece_record_winner, audit_transfer_to_winner_record): (Piece, AuditTransferToWinner) = puzzle_pieces_v016.leo/joint_timeout_to_opponent(piece_joint_stake, joint_piece_time_claim, sig);

        return (
            piece_record_winner,
            audit_transfer_to_winner_record,
            updated_game_record,
            game_finished_notification_challenger_record,
            game_finished_notification_opponent_record
        ) then finalize (joint_piece_time_claim.block_ht);
    }

    finalize finish_game_by_timeout (joint_time_claim_block_ht: u32) {
        // assert that 10000 blocks have passed (~ 83 minutes)
        let current_block_ht: u32 = block.height;
        let threshold_block_ht: u32 = joint_time_claim_block_ht + 10000u32;
        assert(current_block_ht > threshold_block_ht);
    }

}