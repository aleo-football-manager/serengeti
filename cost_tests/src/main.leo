// The 'cost_tests' program.
program cost_tests_v001.aleo {

    mapping players: u8 => Player;

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

    transition randomness_u8_1 () {
        return then finalize;
    }

    finalize randomness_u8_1 () {
        let val1: u8 = ChaCha::rand_u8();
    }

    transition randomness_u8_2 () {
        return then finalize;
    }

    finalize randomness_u8_2 () {
        let val1: u8 = ChaCha::rand_u8();
        let val2: u8 = ChaCha::rand_u8();
    }


    transition randomness_u8_10 () {
        return then finalize;
    }

    finalize randomness_u8_10 () {
        let val1: u8 = ChaCha::rand_u8();
        let val2: u8 = ChaCha::rand_u8();
        let val3: u8 = ChaCha::rand_u8();
        let val4: u8 = ChaCha::rand_u8();
        let val5: u8 = ChaCha::rand_u8();
        let val6: u8 = ChaCha::rand_u8();
        let val7: u8 = ChaCha::rand_u8();
        let val8: u8 = ChaCha::rand_u8();
        let val9: u8 = ChaCha::rand_u8();
        let val10: u8 = ChaCha::rand_u8();
    }

    transition randomness_u128_1 () {
        return then finalize;
    }

    finalize randomness_u128_1 () {
        let val1: u128 = ChaCha::rand_u128();
    }


    transition randomness_u128_10 () {
        return then finalize;
    }

    finalize randomness_u128_10 () {
        let val1: u128 = ChaCha::rand_u128();
        let val2: u128 = ChaCha::rand_u128();
        let val3: u128 = ChaCha::rand_u128();
        let val4: u128 = ChaCha::rand_u128();
        let val5: u128 = ChaCha::rand_u128();
        let val6: u128 = ChaCha::rand_u128();
        let val7: u128 = ChaCha::rand_u128();
        let val8: u128 = ChaCha::rand_u128();
        let val9: u128 = ChaCha::rand_u128();
        let val10: u128 = ChaCha::rand_u128();
    }



    transition randomness_field_1 () {
        return then finalize;
    }

    finalize randomness_field_1 () {
        let val1: field = ChaCha::rand_field();
    }

    transition randomness_field_10 () {
        return then finalize;
    }

    finalize randomness_field_10 () {
        let val1: field = ChaCha::rand_field();
        let val2: field = ChaCha::rand_field();
        let val3: field = ChaCha::rand_field();
        let val4: field = ChaCha::rand_field();
        let val5: field = ChaCha::rand_field();
        let val6: field = ChaCha::rand_field();
        let val7: field = ChaCha::rand_field();
        let val8: field = ChaCha::rand_field();
        let val9: field = ChaCha::rand_field();
        let val10: field = ChaCha::rand_field();
    }


}
