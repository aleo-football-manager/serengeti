// The 'mapping_test' program.
program mapping_test_avh4.aleo {
    
    struct GameOutcome {
        goals_home: u64,
        goals_away: u64
    }
    
    
    mapping game_outcomes: (address, u128) => GameOutcome;

    transition add_outcome_random () -> bool {

        return true
        then finalize;
    
    }

    finalize add_outcome_random () {
        let goals_home: u64 = ChaCha::rand_u64();
        let goals_away: u64 = ChaCha::rand_u64();
        Mapping::set(game_outcomes, 0u128, GameOutcome{goals_home, goals_away});
    }

    transition add_outcome_manual (goals_home: u64, goals_away: u64) {

        return then finalize (goals_home, goals_away);
    
    }

    finalize add_outcome_manual (goals_home: u64, goals_away: u64) {
        Mapping::set(game_outcomes, 0u128, GameOutcome{goals_home, goals_away});
    }


}
