// import puzzle_pieces_v015.leo;
// import multiparty_pvp_utils_v015.leo; // moved all files from this import in here

program player_mapping_v002.aleo {
    
    transition main (a: bool) {}

    /////////////////////////////
    // MAPPING                 //
    /////////////////////////////

  struct SimplePlayer {
        player_id: u8,
        goalkeeper: bool,
        attack: u8,
    }
    
    // TODO: replace by nfts in V2.
    mapping player_mapping: u8 => SimplePlayer;

    transition add_player (player: SimplePlayer) {
        // only owner can add players
        // assert_eq(self.caller, self.signer);
        return then finalize(player);
    }

    finalize add_player (player: SimplePlayer) {
        assert(!Mapping::contains(player_mapping, player.player_id));
        Mapping::set(player_mapping, player.player_id, player);
    }

    transition add_player_owner (player: SimplePlayer) {
        // only owner can add players
        assert_eq(self.caller, self.signer);
        return then finalize(player);
    }

    finalize add_player_owner (player: SimplePlayer) {
        assert(!Mapping::contains(player_mapping, player.player_id));
        Mapping::set(player_mapping, player.player_id, player);
    }


}