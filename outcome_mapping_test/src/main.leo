import football_leaderboard_v002.leo;

// The 'mapping_test' program.
program mapping_test_avh6.aleo {
    
    struct GameOutcome {
        goals_home: u64,
        goals_away: u64
    }
    
    
    mapping game_outcomes: u128 => GameOutcome;

    mapping suc: address => bool; 

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

    transition test_leaderboard(home_address: address, away_address: address, goals_home: u64, goals_away: u64) {
        football_leaderboard_v002.leo/update_score_both_teams(home_address, away_address, goals_home, goals_away);
        return then finalize (home_address, away_address, goals_home, goals_away);
    }

    finalize test_leaderboard (home_address: address, away_address: address, goals_home: u64, goals_away: u64) {
        let b: bool = false;
        assert_eq(true, b);
        Mapping::set(suc, home_address, b);
    }


    transition test_leaderboard_no_assert(home_address: address, away_address: address, goals_home: u64, goals_away: u64) {
        football_leaderboard_v002.leo/update_score_both_teams(home_address, away_address, goals_home, goals_away);
        return then finalize (home_address, away_address, goals_home, goals_away);
    }

    finalize test_leaderboard_no_assert (home_address: address, away_address: address, goals_home: u64, goals_away: u64) {
        let b: bool = false;
        // assert_eq(true, b);
        Mapping::set(suc, home_address, b);
    }


}
