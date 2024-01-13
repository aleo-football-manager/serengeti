program football_random_v011.aleo {

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

    // called by challenger to calculate and store outcome
    transition calculate_outcome
    (
        uuid: field,
        home_formation: [u8; 11],
        away_formation: [u8; 11],
        validate_formation: bool,
    ) {
        return then finalize(uuid, home_formation, away_formation, validate_formation);
    }

    finalize calculate_outcome (
        uuid: field,
        home_formation: [u8; 11],
        away_formation: [u8; 11],
        validate_formation: bool,
    ) {
        // In case of 1 invalid formation: Payout other player.
        // 2 valid formations > ?? (draw is not yet implemented)
        let goals_home: u64 = 0u64;
        let goals_away: u64 = 0u64;

        let home_player: Player = Mapping::get(players, home_formation[10u8]);
        let away_player: Player = Mapping::get(players, away_formation[10u8]);

        let valid_formations: bool = true;

        if validate_formation {
            // Validation of formation
            for formation_i: u8 in 0u8..2u8 {
                let formation: [u8;11] = home_formation;
                if formation_i == 1u8 {
                    formation = away_formation;
                }

                let amount_goalkeepers: u8 = 0u8;
                let same_team: bool = true;
                let player_one: Player = Mapping::get(players, formation[0u8]);

                for i: u8 in 1u8..11u8 {
                    let player: Player = Mapping::get(players, formation[i]);
                    if (player.position == 1field) {
                        amount_goalkeepers += 1u8;
                    }
                    if player.team_id != player_one.team_id {
                        same_team = false;
                    }
                }
                if !same_team || amount_goalkeepers != 1u8 {
                    valid_formations = false;
                    if formation_i == 0u8 {
                        goals_home = 3u64;
                        goals_away = 0u64;
                        // Home formation invalid => home team loss
                    } else {
                        // Away formation invalid => away team loss
                        goals_home = 0u64;
                        goals_away = 3u64;
                    }
                    // Todo: implement draw for both invalid outcomes
                }
                
            }
        }
        if valid_formations {
            for i: u8 in 1u8..11u8 {
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
        }

        let game_outcome: GameOutcome = GameOutcome {
            goals_home,
            goals_away,
        };

        Mapping::set(game_outcomes, uuid, game_outcome);
    }

}