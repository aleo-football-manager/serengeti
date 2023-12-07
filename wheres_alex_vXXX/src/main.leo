import puzzle_pieces_v015.leo;
// import multiparty_pvp_utils_v015.leo;

// The 'coinflip' program.
program football_game_v001.aleo {
    
    transition main (a: bool) {}

    /////////////////////////////
    // MAPPING                 //
    /////////////////////////////

  struct Player {
        player_id: u8,
        team_id: u8,
        goalkeeper: bool
        attack: u8,
        defense: u8,
        speed: u8,
        power: u8,
        stamina: u8,
        technique: u8,
        goalkeeping: u8,
    }

    // TODO: replace by nfts in V2.
    mapping player_mapping: u8 => Player;

    transition add_player (player: Player) {
        // only owner can add players
        // assert_eq(self.signer, self.signer);
        // player_mapping[player.player_id] = player;
        return then finalize(player);
    }

    finalize add_player (player: Player) {
        assert(!Mapping::contains(player_mapping, player.player_id));
        Mapping::set(player_mapping, player.player_id, player);
    }

    // ix: 1
    record Game {
        owner: address,
        challenger_commit: field,
        opponent_answer: [u8; 11],
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        game_state: field,
        ix: u32,
        goals_home: u64,
        goals_away: u64,
    }

    // GAME STATE RECORDED ON NOTIFICATIONS
    // private game_state: field,
        // NORMAL FLOW
        // 1 -> challenger proposed game
        // 2 -> opponent matched wager
        // 3 -> accepted game
        // 4 -> challenger revealed answer
        // 5 -> finished game
        //
        // ALTERNATE EXIT PATHS
        // 6 -> timeout finished game
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
        winner: address,
        loser: address,
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
        wager_record: puzzle_pieces_v015.leo/Piece.record,
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
    ) -> (
        puzzle_pieces_v015.leo/PieceClaim.record,
        puzzle_pieces_v015.leo/PieceStake.record,
        puzzle_pieces_v015.leo/ClaimSignature.record,
        puzzle_pieces_v015.leo/Piece.record,
        puzzle_pieces_v015.leo/AuditStakeIn.record,
        Answer,
        AuditMintAnswer,
        Key,
        AuditKey,
        Game,
        GameReqNotification,
        WaitingAcceptanceNotification,
    ) {

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // random edge case, maybe unnecessary
        assert_neq(game_multisig, opponent);

        // assert that player 1s answer is either "in weeds" or "behind building"
        
        // hash the answer and nonce
        let challenger_commit: field = BHP256::commit_to_field(challenger_answer, challenger_nonce as scalar);

        // assert that the wager amount > 0 and wager inside credit == wager amt passed
        assert(challenger_wager_amount > 0u64);
        // assert that the wager record has >= amount wagered
        assert(wager_record.amount >= challenger_wager_amount);

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
        ) = puzzle_pieces_v015.leo/stake_transfer_in(
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


        let puzzle_issuer: address = aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls;

        let key_record: Key = Key {
            owner: opponent,
            seed: game_multisig_seed,
            amount: challenger_wager_amount,
            challenger: challenger,
            opponent: opponent,
            game_multisig: game_multisig,
            ix: 5u32,
        };

        let audit_key_record: AuditKey = AuditKey {
            owner: puzzle_issuer,
            seed: game_multisig_seed,
            amount: challenger_wager_amount,
            challenger: challenger,
            opponent: opponent,
            game_multisig: game_multisig,
            ix: 6u32,
        };

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
            owner: game_multisig,
            challenger_commit: challenger_commit,
            opponent_answer: [0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8], // random field for now until opponent answer in accept_game
            total_pot: challenger_wager_amount + challenger_wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            game_state: 1field,
            ix: 1u32,
            goals_home: 0u64,
            goals_away: 0u64,
        };

        // let puzzle_issuer: address = aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls;

        let msg: Mssage = Mssage {
            field_1: challenger_message_1,
            field_2: challenger_message_2,
            field_3: challenger_message_3,
            field_4: challenger_message_4,
            field_5: challenger_message_5
        };

        // Verify signature against message to guarantee challenger is caller
        let signature_check: bool = true;
        let is_valid_sig: bool = challenger_sig.verify(challenger, msg);
        assert_eq(signature_check,is_valid_sig);

        let challenger_answer_record: Answer = Answer {
            owner: challenger,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            amount: challenger_wager_amount,
            nonce: challenger_nonce,
            answer: challenger_answer,
            message_1: challenger_message_1,
            message_2: challenger_message_2,
            message_3: challenger_message_3,
            message_4: challenger_message_4,
            message_5: challenger_message_5,
            ix: 1u32,
        };

        let audit_mint_answer_record: AuditMintAnswer = AuditMintAnswer {
            owner: puzzle_issuer,
            answer_owner: challenger,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            amount: challenger_wager_amount,
            nonce: challenger_nonce,
            answer: challenger_answer,
            message_1: challenger_message_1,
            message_2: challenger_message_2,
            message_3: challenger_message_3,
            message_4: challenger_message_4,
            message_5: challenger_message_5,
            ix: 2u32,
        };


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
        );
    }

    // challenger calls this function with Multisig key and signature as input
    // that was submitted when proposing game and that exists on claim record
    transition challenger_renege_stake
    (
        waiting_accept_game_notification: WaitingAcceptanceNotification,
        piece_stake_challenger: puzzle_pieces_v015.leo/PieceStake.record,
        piece_claim_challenger: puzzle_pieces_v015.leo/PieceClaim.record,
        challenger_sig: signature,
    ) -> (
        puzzle_pieces_v015.leo/Piece.record,
        puzzle_pieces_v015.leo/AuditStakeOut.record,
        StakeRenegedNotification,
        StakeRenegedNotification,
        )
    {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let (piece_record, audit_stake_out_record): (Piece, AuditStakeOut) = puzzle_pieces_v015.leo/stake_transfer_out(piece_stake_challenger, piece_claim_challenger, challenger_sig);

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
        opponent_wager_record: puzzle_pieces_v015.leo/Piece.record,
        key_record: Key,
        game_req_notification: GameReqNotification,
        opponent_message_1: field, //from output of useSignature
        opponent_message_2: field,
        opponent_message_3: field,
        opponent_message_4: field,
        opponent_message_5: field,
        opponent_sig: signature, //from output of useSignature
    ) -> (
        puzzle_pieces_v015.leo/PieceClaim.record,
        puzzle_pieces_v015.leo/PieceStake.record,
        puzzle_pieces_v015.leo/ClaimSignature.record,
        puzzle_pieces_v015.leo/Piece.record,
        puzzle_pieces_v015.leo/AuditStakeIn.record,
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
        ) = puzzle_pieces_v015.leo/stake_transfer_in(
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
        piece_stake_opponent: puzzle_pieces_v015.leo/PieceStake.record,
        piece_claim_opponent: puzzle_pieces_v015.leo/PieceClaim.record,
        opponent_sig: signature,
    ) -> (
        puzzle_pieces_v015.leo/Piece.record,
        puzzle_pieces_v015.leo/AuditStakeOut.record,
        StakeRenegedNotification,
        StakeRenegedNotification,
        )
    {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let (piece_record, audit_stake_out_record): (Piece, AuditStakeOut) = puzzle_pieces_v015.leo/stake_transfer_out(piece_stake_opponent, piece_claim_opponent, opponent_sig);

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
        piece_stake_challenger: puzzle_pieces_v015.leo/PieceStake.record,
        piece_claim_challenger: puzzle_pieces_v015.leo/PieceClaim.record,
        piece_stake_opponent: puzzle_pieces_v015.leo/PieceStake.record,
        piece_claim_opponent: puzzle_pieces_v015.leo/PieceClaim.record,
        block_ht: u32,
    ) -> (
        puzzle_pieces_v015.leo/PieceJointStake.record,
        puzzle_pieces_v015.leo/JointPieceTimeClaim.record,
        puzzle_pieces_v015.leo/JointPieceState.record,
        puzzle_pieces_v015.leo/AuditJointStake.record,
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
        ) = puzzle_pieces_v015.leo/transfer_stakes_to_joint(
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
            ix: 8u32,
        };

        let updated_game_record: Game = Game {
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field,
            ix: 1u32,
            goals_home: game_record.goals_home,
            goals_away: game_record.goals_away,
        };

        return (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            audit_joint_stake,
            waiting_reveal_answer_notifcation_record,
            reveal_answer_notification_record,
            updated_game_record,
        ) then finalize (block_ht);
    }


    finalize accept_game
    (
        block_ht: u32,
    )
    {
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

    transition reveal_answer_new 
    (
        reveal_answer_notification_record: RevealAnswerNotification,
        challenger_answer_record: Answer,
        joint_piece_state: puzzle_pieces_v015.leo/JointPieceState.record,
        challenger_claim_signature: puzzle_pieces_v015.leo/ClaimSignature.record,
    ) -> (
        RevealAnswer,
        AuditRevealAnswer,
        puzzle_pieces_v015.leo/JointPieceWinner.record,
        puzzle_pieces_v015.leo/AuditJointPieceWinner.record,
        GameFinishReqNotification,
        GameFinishReqNotification,
    ) {
        // assert that the correct state updater address is the challenger and the challenger
        // is invoking this
        assert_eq(joint_piece_state.state_updater_address, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);
        
        return then finalize (
            reveal_answer_notification_record.opponent_answer,
            challenger_answer_record.answer
            );
    }

    finalize reveal_answer_new (
        opponent_answer: [u8;11],
        answer: [u8;11]
    ) {
        let goals_home: u64 = 0u64;
        let goals_away: u64 = 0u64;
        for i: u8 in 1u8..11u8 {
            let attacker: Player = Mapping::get(player_mapping, answer[i]);
            let defender: Player = Mapping::get(player_mapping, opponent_answer[i]);
            let goalkeeper: Player = Mapping::get(player_mapping, opponent_answer[0u8]);
            let switch_sides: bool = attacker.speed < defender.speed;
            if switch_sides {
                attacker = Mapping::get(player_mapping, opponent_answer[i]);
                defender = Mapping::get(player_mapping, answer[i]);
                goalkeeper = Mapping::get(player_mapping, answer[0u8]);
            }


            // Attacker shoots, attack stat determines if it's on target.
            if  attacker.attack > ChaCha::rand_u8() {
                // Defender blocks, defense stat determines if it's blocked.
                if defender.defense < ChaCha::rand_u8() {
                    // Goalkeeper saves, goalkeeping stat determines if it's saved.
                    if goalkeeper.goalkeeping < ChaCha::rand_u8() {
                        // If not saved, record the goal for attacking team.
                        if (switch_sides) {
                            goals_home += 1u64;
                        } else {
                            goals_away += 1u64;
                        }
                    }
                }
            }
        }
        // // Update the game state
        // let updated_game_record: Game = Game {
        //     owner: game_record.owner,
        //     challenger_commit: game_record.challenger_commit,
        //     opponent_answer: opponent_answer,
        //     total_pot: game_record.total_pot,
        //     challenger_address: game_record.challenger_address,
        //     opponent_address: game_record.opponent_address,
        //     game_multisig: game_record.game_multisig,
        //     game_state: 3field, //todo
        //     ix: 0u32, // todo
        //     goals_home: goals_home,
        //     goals_away: goals_away,
        // };
    }


    // called by challenger to reveal answer record
    transition reveal_answer_game
    (
        reveal_answer_notification_record: RevealAnswerNotification,
        challenger_answer_record: Answer,
        joint_piece_state: puzzle_pieces_v015.leo/JointPieceState.record,
        challenger_claim_signature: puzzle_pieces_v015.leo/ClaimSignature.record,
    ) -> (
        RevealAnswer,
        AuditRevealAnswer,
        puzzle_pieces_v015.leo/JointPieceWinner.record,
        puzzle_pieces_v015.leo/AuditJointPieceWinner.record,
        GameFinishReqNotification,
        GameFinishReqNotification,
    )
    {

        // assert that the correct state updater address is the challenger and the challenger
        // is invoking this
        assert_eq(joint_piece_state.state_updater_address, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // determine winner! If opponent correctly picked where the challenger hid alex, the opponent wins otherwise the challenger wins
        // TODO - add logic to determine winner
        let winner_address: address = challenger_answer_record.challenger_address; // todo
        let loser_address: address = challenger_answer_record.challenger_address; // todo
        let challenger_sig: signature = challenger_claim_signature.sig; // todo

        // retrieve revealedanswer record
        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls;

        // Verify that owner is challenger
        assert_eq(challenger_answer_record.owner, challenger_answer_record.challenger_address);

        // Verify signature from Cagainst message to guarantee challenger is caller
        let msg: Mssage = Mssage {
            field_1: challenger_answer_record.message_1,
            field_2: challenger_answer_record.message_2,
            field_3: challenger_answer_record.message_3,
            field_4: challenger_answer_record.message_4,
            field_5: challenger_answer_record.message_5
        };

        let signature_check: bool = true;
        let is_valid_sig: bool = challenger_sig.verify(challenger_answer_record.challenger_address, msg);
        assert_eq(signature_check,is_valid_sig);


        let answer_owner: address = challenger_answer_record.owner;
        let answer_challenger_address: address = challenger_answer_record.challenger_address;
        let answer_opponent_address: address = challenger_answer_record.opponent_address;
        let game_multisig: address = challenger_answer_record.game_multisig;
        let answer_amount: u64 = challenger_answer_record.amount;
        let answer_nonce: field = challenger_answer_record.nonce;
        let answer_answer: [u8; 11] = challenger_answer_record.answer;

        let revealed_answer_record: RevealAnswer = RevealAnswer {
            owner: game_multisig,
            challenger_address: answer_challenger_address,
            opponent_address: answer_opponent_address,
            game_multisig: game_multisig,
            amount: answer_amount,
            nonce: answer_nonce,
            answer: answer_answer,
            sig: challenger_sig,
            ix: 3u32,
        };

        let audit_revealed_answer_record: AuditRevealAnswer = AuditRevealAnswer {
            owner: puzzle_issuer,
            challenger_address: answer_challenger_address,
            opponent_address: answer_opponent_address,
            game_multisig: game_multisig,
            amount: answer_amount,
            nonce: answer_nonce,
            answer: answer_answer,
            sig: challenger_sig,
            ix: 4u32,
        };
        

        let (joint_piece_winner, audit_joint_piece_winner): (JointPieceWinner, AuditJointPieceWinner) = puzzle_pieces_v015.leo/joint_stake_state_update(joint_piece_state, challenger_claim_signature, winner_address);

        let game_finish_req_notification_record_opponent: GameFinishReqNotification = GameFinishReqNotification {
            owner: challenger_answer_record.opponent_address,
            game_multisig: challenger_answer_record.game_multisig,
            game_state: 4field,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            challenger_address: challenger_answer_record.challenger_address,
            opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer_record.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            winner: winner_address,
            loser: loser_address,
            ix: 9u32,
        };

        let game_finish_req_notification_record_challenger: GameFinishReqNotification = GameFinishReqNotification{
            owner: challenger_answer_record.challenger_address,
            game_multisig: challenger_answer_record.game_multisig,
            game_state: 4field,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            challenger_address: challenger_answer_record.challenger_address,
            opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer_record.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            winner: winner_address,
            loser: loser_address,
            ix: 9u32,
        };

        return (revealed_answer_record, audit_revealed_answer_record, joint_piece_winner, audit_joint_piece_winner, game_finish_req_notification_record_opponent, game_finish_req_notification_record_challenger);
    }

    // called by ms key to finish the game and get the total pot!
    transition finish_game
    (
        game_record: Game,
        joint_piece_winner: puzzle_pieces_v015.leo/JointPieceWinner.record,
        piece_joint_stake: puzzle_pieces_v015.leo/PieceJointStake.record,
        joint_piece_time_claim: puzzle_pieces_v015.leo/JointPieceTimeClaim.record,
    ) -> (
        puzzle_pieces_v015.leo/Piece.record,
        puzzle_pieces_v015.leo/AuditTransferToWinner.record,
        puzzle_pieces_v015.leo/AuditPieceOwner.record,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {

        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let loser_address: address = joint_piece_winner.winner == game_record.challenger_address ? game_record.opponent_address : game_record.challenger_address;

        let (piece_record, audit_transfer_to_winner_record, audit_piece_owner): (Piece, AuditTransferToWinner, AuditPieceOwner) = puzzle_pieces_v015.leo/joint_stake_transfer_to_winner(
            joint_piece_winner,
            piece_joint_stake,
            joint_piece_time_claim,
        );

        let updated_game_record: Game = Game {
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field,
            ix: 0u32,
            goals_home: game_record.goals_home,
            goals_away: game_record.goals_away,
        };

        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 5field,
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
            game_state: 5field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: joint_piece_winner.winner,
            loser: loser_address,
            ix: 10u32,
        };

        return (piece_record, audit_transfer_to_winner_record, audit_piece_owner, updated_game_record, game_finished_notification_challenger_record, game_finished_notification_opponent_record);
    }

    // called by ms key via opponent to finish the game and get the total pot!
    transition finish_game_by_timeout(
        game_record: Game,
        piece_joint_stake: puzzle_pieces_v015.leo/PieceJointStake.record,
        joint_piece_time_claim: puzzle_pieces_v015.leo/JointPieceTimeClaim.record,
        sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
    ) -> (
        puzzle_pieces_v015.leo/Piece.record,
        puzzle_pieces_v015.leo/AuditTransferToWinner.record,
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
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field,
            ix: 0u32,
            goals_home: game_record.goals_home,
            goals_away: game_record.goals_away,
        };

        // Notification to challenger of game finished
        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 6field,
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
            game_state: 6field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: game_record.opponent_address,
            loser: game_record.challenger_address,
            ix: 10u32,
        };

        // Payout to winner
        let (piece_record_winner, audit_transfer_to_winner_record): (Piece, AuditTransferToWinner) = puzzle_pieces_v015.leo/joint_timeout_to_opponent(piece_joint_stake, joint_piece_time_claim, sig);

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

    struct Mssage {
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
    }

    // ix: 1u32
    record Answer {
        owner: address, //challenger
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: [u8; 11],
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        ix: u32,
    }

    // ix: 2u32,
    record AuditMintAnswer {
        owner: address,
        answer_owner: address,
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: [u8; 11],
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        ix: u32,
    }

    // ix: 3u32
    record RevealAnswer {
        owner: address, //challenger
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: [u8; 11],
        sig: signature,
        ix: u32,
    }

    // ix: 4u32
    record AuditRevealAnswer {
        owner: address, //challenger
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: [u8; 11],
        sig: signature
        ix: u32,
    }

    // ix: 5u32
    record Key {
        owner: address, //opponent
        seed: field,
        amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address,
        ix: u32,
    }

    // ix: 6u32
    record AuditKey {
        owner: address, //puzzle issuer
        seed: field,
        amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address,
        ix: u32,
    }

}