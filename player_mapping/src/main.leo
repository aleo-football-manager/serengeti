import puzzle_pieces_v015.leo;
// import multiparty_pvp_utils_v015.leo; // moved all files from this import in here

program football_game_v001.aleo {
    
    transition main (a: bool) {}

    /////////////////////////////
    // MAPPING                 //
    /////////////////////////////

  struct Player {
        player_id: u8,
        team_id: u8,
        goalkeeper: bool,
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
        // assert_eq(self.caller, self.signer);
        return then finalize(player);
    }

    finalize add_player (player: Player) {
        assert(!Mapping::contains(player_mapping, player.player_id));
        Mapping::set(player_mapping, player.player_id, player);
    }

}