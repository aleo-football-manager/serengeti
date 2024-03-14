// The 'formation_tests' program.
program formation_tests_v002.aleo {

    mapping players: u8 => Player;
    mapping valid_formations: u8 => bool;
    mapping game_outcomes: address => GameOutcome;
    mapping validation_details: u8 => ValidationDetails;

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

    struct ValidationDetails {
        same_team: bool,
        wrong_team_index: u8,
    }


    transition main (
        players_input: [Player; 11],
    ) {
        // TODO: Only to be called by the contract owner
        return then finalize (
            players_input
            );
    }
    
    finalize main (
        players_input: [Player; 11],
    ) {
        for i: u8 in 1u8..11u8 {
            Mapping::set(players, players_input[i].player_id, players_input[i]);
        }
    }

    transition add_player (player: Player) {
        // TODO: Only to be called by the contract owner
        return then finalize (player);
    }
    
    finalize add_player (player: Player) {
        Mapping::set(players, player.player_id, player);
    }

    // // called by challenger to calculate and store outcome
    // transition calculate_outcome
    // (
    //     game_multisig: address,
    //     address_home: address,
    //     address_away: address,
    //     home_formation: [u8; 11],
    //     away_formation: [u8; 11],
    // )
    // {
    //     return then finalize (
    //         game_multisig,
    //         address_home,
    //         address_away,
    //         home_formation,
    //         away_formation,
    //         );
    // }
    // 
    // finalize calculate_outcome (
    //     game_multisig: address,
    //     address_home: address,
    //     address_away: address,
    //     home_formation: [u8; 11],
    //     away_formation: [u8; 11],
    // ) {


    //     // In case of 1 invalid formation: Payout other player.
    //     // 2 valid formations > ?? (draw is not yet implemented)
    //     let goals_home: u64 = 0u64;
    //     let goals_away: u64 = 0u64;

    //     let home_player: Player = Mapping::get(players, home_formation[10u8]);
    //     let away_player: Player = Mapping::get(players, away_formation[10u8]);

    //     for i: u8 in 1u8..11u8 {
    //         // See which team attacks 
    //         home_player = Mapping::get(players, home_formation[i]);
    //         away_player = Mapping::get(players, away_formation[i]);
    //         let attacker: Player = home_player;
    //         let defender: Player = away_player;
    //         if (home_player.speed < away_player.speed) {
    //             attacker = away_player;
    //             defender = home_player;
    //         } else {

    //         }
    //         let goalkeeper: Player = home_player.speed > away_player.speed ? Mapping::get(players, away_formation[0u8]) : Mapping::get(players, home_formation[0u8]);

    //         // Attacker shoots, attack stat determines if it's on target.
    //         if (attacker.attack > ChaCha::rand_u8()) {
    //             // Defender blocks, defense stat determines if it's blocked.
    //             if defender.defense < ChaCha::rand_u8() {
    //                 // Goalkeeper saves, goalkeeping stat determines if it's saved.
    //                 if goalkeeper.goalkeeping < ChaCha::rand_u8() {
    //                     // If not saved, record the goal for attacking team.
    //                     if (home_player.speed < away_player.speed) {
    //                         goals_away += 1u64;
    //                     } else {
    //                         goals_home += 1u64;
    //                     }
    //                 }
    //             }
    //         }
    //     }

    //     // const i: u8 = 1u8;
    //     if (home_player.speed < away_player.speed) {
    //         goals_away += 1u64;
    //     } else {
    //         goals_home += 1u64;
    //     }

    //     let team_id_home: u8 = home_player.team_id;
    //     let team_id_away: u8 = home_player.team_id;

    //     let game_outcome: GameOutcome = GameOutcome {
    //         address_home,
    //         address_away,
    //         team_id_home,
    //         team_id_away,
    //         goals_home,
    //         goals_away,
    //     };

    //     Mapping::set(game_outcomes, game_multisig, game_outcome);
    // }

    transition validate_formation (
        index: u8,
        formation: [u8; 11],)  {
    return then finalize (index, formation);
    }

    finalize validate_formation (
        index: u8,
        formation: [u8; 11],) {
    
        let same_team: bool = true;
        let player_one: Player = Mapping::get(players, formation[0u8]);
        let wrong_team_index: u8 = 0u8;

        for i: u8 in 1u8..11u8 {
            let player: Player = Mapping::get(players, formation[i]);
            if player.team_id != player_one.team_id {
                same_team = false;
                wrong_team_index = i;
            }
        }
        Mapping::set(valid_formations, index , same_team);
        
        let validation_detail: ValidationDetails = ValidationDetails {
            same_team,
            wrong_team_index,
        };
        Mapping::set(validation_details, index, validation_detail);

    }


}
