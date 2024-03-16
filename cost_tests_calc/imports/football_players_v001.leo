// The 'football_players' program.
program football_players_v001.aleo {
    
    mapping players: field => Player;

    transition add_player (player: Player) {
        return then finalize (player);
    }
    finalize add_player (player: Player) {
        Mapping::set(players, player.player_id, player);
    }

     struct Player {
        player_id: field,
        team_id: field,
        position: field, // 0 = Emtpy, 1 = Goalkeep, 2 = Defense, 3 = Mid, 4 = Attack
        attack: u128,
        defense: u128,
        speed: u128,
        power: u128,
        stamina: u128,
        technique: u128,
        goalkeeping: u128,
    }

}
