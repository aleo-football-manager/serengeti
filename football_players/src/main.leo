program football_players_v003.aleo {
    
    /////////////////////////////
    // MAPPING                 //
    /////////////////////////////

    mapping players: u8 => Player;

    /////////////////////////////
    // STRUCTS                 //
    /////////////////////////////

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

    /////////////////////////////
    // MESSAGES                //
    /////////////////////////////

    record PlayerAddedNotification {
        owner: address,
        player: Player,
    }

    record FormationValidatedNotification {
        owner: address,
        formation: [u8; 11],
    }

    /////////////////////////////
    // FUNCTIONS               //
    /////////////////////////////

    transition add_player (player: Player) -> PlayerAddedNotification {
        // Only to be called by the contract owner
        assert_eq(self.caller, self.signer);
        
        let playerAddedNotification: PlayerAddedNotification = PlayerAddedNotification {
            owner: self.caller,
            player
        };
        
        return playerAddedNotification
        then finalize (player);
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

    transition validate_formation(formation: [u8; 11])  -> FormationValidatedNotification{
        let notification: FormationValidatedNotification = FormationValidatedNotification {
            owner: self.caller,
            formation: formation,
        };
        return notification then finalize(formation);
    }

    finalize validate_formation(formation: [u8; 11]) {
        let amount_goalkeepers: u8 = 0u8;
            let player_one: Player = Mapping::get(players, formation[0u8]);
            
            for i: u8 in 1u8..11u8 {
                let player: Player = Mapping::get(players, formation[i]);
                if (player.position == 1field) {
                    amount_goalkeepers += 1u8;
                }
                assert_eq(player.team_id, player_one.team_id);
            }
            assert_eq(amount_goalkeepers, 1u8);
    }
}