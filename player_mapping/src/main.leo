// import puzzle_pieces_v015.leo;
// import multiparty_pvp_utils_v015.leo; // moved all files from this import in here

program player_mapping_v004.aleo {
    
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
        return then finalize(player);
    }

    finalize add_player (player: SimplePlayer) {
        assert(!Mapping::contains(player_mapping, player.player_id));
        Mapping::set(player_mapping, player.player_id, player);
    }
    
    transition add_all_players () {
        return then finalize();
    }


    finalize add_all_players () {
        for i: u8 in 1u8..11u8 {
            Mapping::set(player_mapping, i, SimplePlayer{player_id: i, goalkeeper: false, attack: ChaCha::rand_u8()});
        }
        
    }

}