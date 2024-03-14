// The 'cost_tests' program.
program cost_tests_v001.aleo {

    mapping players: u8 => Player;
    mapping game_outcomes: address => GameOutcome;


    struct GameOutcome {
        address_home: address,
        address_away: address
        team_id_home: u8,
        team_id_away: u8,
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

    transition main (player: Player) {
        // TODO: Only to be called by the contract owner
        return then finalize (player);
    }
    
    finalize main (player: Player) {
        Mapping::set(players, player.player_id, player);
    }
    
    transition add_player (player: Player) {
        // TODO: Only to be called by the contract owner
        return then finalize (player);
    }
    
    finalize add_player (player: Player) {
        Mapping::set(players, player.player_id, player);
    }

    // transition randomness_u8_1 () {
    //     return then finalize;
    // }

    // finalize randomness_u8_1 () {
    //     let val1: u8 = ChaCha::rand_u8();
    // }

    // transition randomness_u8_2 () {
    //     return then finalize;
    // }

    // finalize randomness_u8_2 () {
    //     let val1: u8 = ChaCha::rand_u8();
    //     let val2: u8 = ChaCha::rand_u8();
    // }


    // transition randomness_u8_10 () {
    //     return then finalize;
    // }

    // finalize randomness_u8_10 () {
    //     let val1: u8 = ChaCha::rand_u8();
    //     let val2: u8 = ChaCha::rand_u8();
    //     let val3: u8 = ChaCha::rand_u8();
    //     let val4: u8 = ChaCha::rand_u8();
    //     let val5: u8 = ChaCha::rand_u8();
    //     let val6: u8 = ChaCha::rand_u8();
    //     let val7: u8 = ChaCha::rand_u8();
    //     let val8: u8 = ChaCha::rand_u8();
    //     let val9: u8 = ChaCha::rand_u8();
    //     let val10: u8 = ChaCha::rand_u8();
    // }

    // transition randomness_u128_1 () {
    //     return then finalize;
    // }

    // finalize randomness_u128_1 () {
    //     let val1: u128 = ChaCha::rand_u128();
    // }


    // transition randomness_u128_10 () {
    //     return then finalize;
    // }

    // finalize randomness_u128_10 () {
    //     let val1: u128 = ChaCha::rand_u128();
    //     let val2: u128 = ChaCha::rand_u128();
    //     let val3: u128 = ChaCha::rand_u128();
    //     let val4: u128 = ChaCha::rand_u128();
    //     let val5: u128 = ChaCha::rand_u128();
    //     let val6: u128 = ChaCha::rand_u128();
    //     let val7: u128 = ChaCha::rand_u128();
    //     let val8: u128 = ChaCha::rand_u128();
    //     let val9: u128 = ChaCha::rand_u128();
    //     let val10: u128 = ChaCha::rand_u128();
    // }



    // transition randomness_field_1 () {
    //     return then finalize;
    // }

    // finalize randomness_field_1 () {
    //     let val1: field = ChaCha::rand_field();
    // }

    // transition randomness_field_10 () {
    //     return then finalize;
    // }

    // finalize randomness_field_10 () {
    //     let val1: field = ChaCha::rand_field();
    //     let val2: field = ChaCha::rand_field();
    //     let val3: field = ChaCha::rand_field();
    //     let val4: field = ChaCha::rand_field();
    //     let val5: field = ChaCha::rand_field();
    //     let val6: field = ChaCha::rand_field();
    //     let val7: field = ChaCha::rand_field();
    //     let val8: field = ChaCha::rand_field();
    //     let val9: field = ChaCha::rand_field();
    //     let val10: field = ChaCha::rand_field();
    // }



    // called by challenger to calculate and store outcome
    transition calculate_outcome
    (
        game_multisig: address,
        address_home: address,
        address_away: address,
        home_formation: [u8; 11],
        away_formation: [u8; 11],
    )
    {
        return then finalize (
            game_multisig,
            address_home,
            address_away,
            home_formation,
            away_formation,
            );
    }

    finalize calculate_outcome (
        game_multisig: address,
        address_home: address,
        address_away: address,
        home_formation: [u8; 11],
        away_formation: [u8; 11],
    ) {


        // In case of 1 invalid formation: Payout other player.
        // 2 valid formations > ?? (draw is not yet implemented)
        let goals_home: u64 = 0u64;
        let goals_away: u64 = 0u64;

        let home_player: Player = Mapping::get(players, home_formation[10u8]);
        let away_player: Player = Mapping::get(players, away_formation[10u8]);

        let valid_formations: bool = true;

        // // Validation of formation
        // for formation_i: u8 in 0u8..2u8 {
        //     let formation: [u8;11] = home_formation;
        //     if formation_i == 1u8 {
        //         formation = away_formation;
        //     }

        //     let amount_goalkeepers: u8 = 0u8;
        //     let same_team: bool = true;
        //     let player_one: Player = Mapping::get(players, formation[0u8]);

        //     for i: u8 in 1u8..11u8 {
        //         let player: Player = Mapping::get(players, formation[i]);
        //         if (player.position == 1field) {
        //             amount_goalkeepers += 1u8;
        //         }
        //         if player.team_id != player_one.team_id {
        //             same_team = false;
        //         }
        //     }
        //     if !same_team || amount_goalkeepers != 1u8 {
        //         valid_formations = false;
        //         if formation_i == 0u8 {
        //             goals_home = 3u64;
        //             goals_away = 0u64;
        //             // Home formation invalid => home team loss
        //         } else {
        //             // Away formation invalid => away team loss
        //             goals_home = 0u64;
        //             goals_away = 3u64;
        //         }
        //         // Todo: implement draw for both invalid outcomes
        //     }
        // }
        
        if valid_formations {
            for i: u8 in 1u8..11u8 {
                // See which team attacks 
                home_player = Mapping::get(players, home_formation[i]);
                away_player = Mapping::get(players, away_formation[i]);
                let attacker: Player = home_player;
                let defender: Player = away_player;
                if (home_player.speed < away_player.speed) {
                    attacker = away_player;
                    defender = home_player;
                } else {

                }
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
        }

        let team_id_home: u8 = home_player.team_id;
        let team_id_away: u8 = home_player.team_id;

        let game_outcome: GameOutcome = GameOutcome {
            address_home,
            address_away,
            team_id_home,
            team_id_away,
            goals_home,
            goals_away,
        };

        Mapping::set(game_outcomes, game_multisig, game_outcome);
    }

}
