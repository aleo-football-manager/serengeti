// The 'cost_tests' program.
program cost_tests_calc_v011.aleo {
    
    // mapping players: field => Player;

    // transition add_player (player: Player) {
    //     return then finalize (player);
    // }
    // finalize add_player (player: Player) {
    //     Mapping::set(players, player.player_id, player);
    // }

    //  struct Player {
    //     player_id: field,
    //     team_id: field,
    //     position: field, // 0 = Emtpy, 1 = Goalkeep, 2 = Defense, 3 = Mid, 4 = Attack
    //     attack: u128,
    //     defense: u128,
    //     speed: u128,
    //     power: u128,
    //     stamina: u128,
    //     technique: u128,
    //     goalkeeping: u128,
    // }

    // transition calculate_outcome_new (
    //     home_formation: [field; 11],
    //     away_formation: [field; 11],) {
    //         return then finalize (home_formation, away_formation);
    
    // }

    // finalize calculate_outcome_new (
    //     home_formation: [field; 11],
    //     away_formation: [field; 11],
    // ) {

    //     // In case of 1 invalid formation: Payout other player.
    //     // 2 valid formations > ?? (draw is not yet implemented)
    //     let goals_home: u64 = 0u64;
    //     let goals_away: u64 = 0u64;

    //     let home_player: Player = Mapping::get(players, home_formation[0u8]);
    //     let away_player: Player = Mapping::get(players, away_formation[0u8]);
    //     let home_goalkeeper: Player = home_player; // TODO: check if it does not change
    //     let away_goalkeeper: Player = away_player;

    //     for i: u8 in 1u8..2u8 {
    //         // See which team attacks 
    //         home_player = Mapping::get(players, home_formation[i]);
    //         away_player = Mapping::get(players, away_formation[i]);
            

    //         let random: u128 = ChaCha::rand_u128();
    //         let fast: u128 = random.mod(home_player.speed + away_player.speed); // todo ensure total speed != 0? maybe check speed > 0 in add player

    //         let game_random: u128 = random.mod(1000000000000u128); // TODO check if this value is correct

    //         let home_first: bool = fast < home_player.speed;
    //         let attacker: Player = home_first ? home_player : away_player;
    //         let defender: Player = home_first ? away_player : home_player;
    //         let goalkeeper: Player = home_first ? away_goalkeeper : home_goalkeeper;

    //         let attack_power: u128 = attacker.attack.mul(attacker.power); // Max 100*100 = 10000
    //         let def_strength: u128 = defender.defense.mul(defender.technique); // Max 100*100 = 10000


    //         // let probability_of_goal: u128 = attack_power.mul(10000u128.sub(def_strength)).mul(goalkeeper.goalkeeping); // Max 10000 * 10000 = 100000000
    //         // if probability_of_goal > game_random {
    //         //     // If not saved, record the goal for attacking team.
    //         //     if home_first {
    //         //         goals_home += 1u64;
    //         //     } else {
    //         //         goals_away += 1u64;
    //         //     }
    //         // }
    //     }
    // }


    // transition test_random () {
    //     return then finalize;
    // }

    // finalize test_random () {
    //     let random: u128 = ChaCha::rand_u128();
    //     let fast: u128 = random.mod(160u128); // todo ensure total speed != 0? maybe check speed > 0 in add player
    //     let game_random: u128 = random.mod(1000000000000u128); // TODO check if this value is correct
    // }

    // transition test_prob () {
    //     return then finalize;
    // }

    // finalize test_prob () {
    //     let attack_power: u128 = 80u128.mul(80u128); // Max 100*100 = 10000
    //     let def_strength: u128 = 80u128.mul(80u128); // Max 100*100 = 10000
    //     let probability_of_goal: u128 = attack_power.mul(10000u128.sub(def_strength)).mul(100u128.sub(75u128)); // Max 10000 * 10000 = 100000000
        //     let probability_of_goal: u128 = (attack_power*10000u128) - (def_strength100u128) -sub(75u128)); // Max 10000 * 10000 = 100000000

    // }
    
// transition test_prob2 () {
//         return then finalize;
//     }

//     finalize test_prob2 () {
//         let attack_power: u8 = 80u8.mul(2u8); // Max 100*100 = 10000
//         let def_strength: u8 = 80u8; // Max 100*100 = 10000
//         let probability_of_goal: bool = attack_power.gt(def_strength);
//     }
    

// transition test_prob3 () {
//         return then finalize;
//     }

//     finalize test_prob3 () {
//         let attack_power: u128 = 80u128.mul(2u128); // Max 100*100 = 10000
//         let def_strength: u128 = 80u128; // Max 100*100 = 10000
//         let probability_of_goal: bool = attack_power.gt(def_strength);
//     }


// transition test_prob4 () {
//         return then finalize;
//     }

//     finalize test_prob4 () {
//         let attack_power: u8 = 80u8; // Max 100*100 = 10000
//         let def_strength: u8 = 80u8; // Max 100*100 = 10000
//         let probability_of_goal: bool = attack_power > def_strength;
//     }


// transition test_prob5 () {
//         return then finalize;
//     }

//     finalize test_prob5 () {
//         let attack_power: u8 = 80u8; // Max 100*100 = 10000
//         let def_strength: u8 = 80u8; // Max 100*100 = 10000
//         let probability_of_goal: bool = attack_power > def_strength;
//     }


//     transition test_random_p () {
//         return then finalize;
//     }

//     finalize test_random_p () {
//         let random: u128 = ChaCha::rand_u128();
//         let fast: u128 = random.mod(160u128); // todo ensure total speed != 0? maybe check speed > 0 in add player
//         let game_random1: u128 = random.mod(234272u128).mod(100u128); // TODO check if this value is correct
//         let game_random2: u128 = random.mod(2341272u128).mod(100u128); // TODO check if this value is correct
//         let game_random3: u128 = random.mod(234234272u128).mod(100u128); // TODO check if this value is correct
//         let game_random4: u128 = random.mod(91234272u128).mod(100u128); // TODO check if this value is correct
//         let game_random5: u128 = random.mod(2272u128).mod(100u128); // TODO check if this value is 
// }
//     transition test_random_r () {
//         return then finalize;
//     }

//     finalize test_random_r () {
//         let random: u128 = ChaCha::rand_u128();
//         let fast: u128 = random.mod(160u128); // todo ensure total speed != 0? maybe check speed > 0 in add player
//         let game_random1: u128 = ChaCha::rand_u128().mod(100u128);
//         let game_random2: u128 = ChaCha::rand_u128().mod(100u128);
//         let game_random3: u128 = ChaCha::rand_u128().mod(100u128);
//         let game_random4: u128 = ChaCha::rand_u128().mod(100u128);
//         let game_random5: u128 = ChaCha::rand_u128().mod(100u128);
// }


//     transition test_prob_simple () {
//         return then finalize;
//     }

//     finalize test_prob_simple () {
//         let attack_power: u128 = 80u128.mul(80u128); // Max 100*100 = 10000
//         let def_strength: u128 = 80u128.mul(80u128); // Max 100*100 = 10000
//         let goalkeep_power: u128 = 75u128;
//         let probability_of_goal: u128 = attack_power*(10000u128 - def_strength) * (100u128 - goalkeep_power); 
//     }




    transition test_random_p_iter () {
        return then finalize;
    }

    finalize test_random_p_iter () {
        let random: u128 = ChaCha::rand_u128();
        let fast: u128 = random.mod(160u128); // todo ensure total speed != 0? maybe check speed > 0 in add player
        let game_random1: u128 = random.mod(234272u128).mod(100u128); // TODO check if this value is correct
        let game_random2: u128 = random.mod(2341272u128).mod(100u128); // TODO check if this value is correct
        let game_random3: u128 = random.mod(234234272u128).mod(100u128); // TODO check if this value is correct
        let game_random4: u128 = random.mod(91234272u128).mod(100u128); // TODO check if this value is correct
        let game_random5: u128 = random.mod(2272u128).mod(100u128); // TODO check if this value is 

        let goal: bool = false;

        if 2429u128 < game_random1 {
            if 2329802u128 < game_random2 {
                if 21231234u128 < game_random3 {
                    if 19912912u128 < game_random4 {
                        if 2272u128 < game_random5 {
                            goal = true;
                        }
                    }
                }
            }
        }
    }}
