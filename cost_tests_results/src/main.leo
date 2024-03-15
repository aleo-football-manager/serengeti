// The 'cost_tests' program.
program cost_tests_results_v002.aleo {

    mapping game_outcomes: address => GameOutcome;

    mapping game_result_0: address => GameResult;
    mapping game_result_1: address => DetailedGameResult1;
    mapping game_result_2: address => [MatchGoalEvent; 10];


    struct GameOutcome {
        address_home: address,
        address_away: address
        team_id_home: field,
        team_id_away: field,
        goals_home: u64,
        goals_away: u64,
    }

    struct GameResult {
        goals_home: u64,
        goals_away: u64,
    }

    struct DetailedGameResult1 {
        goals_home: [field; 10];
        goals_away: [field; 10];
    }

    struct MatchGoalEvent {
        team_address: address,
        player_id: field,
        goal_time: field,
        goal_scored: bool,
    }



    transition test ()  {
        return then finalize;
    }

// ├ Storage fee: 0.001194
// ├ Finalize fee: 0.122
    finalize test () {

        let goals_home: u64 = 0u64;
        let away_home: u64 = 0u64;

        for i: u8 in 1u8..11u8 {
            goals_home += 1u64;
        }
    
        let game_outcome:GameOutcome = GameOutcome {
            address_home: aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm,
            address_away: aleo10rdcc92pecx8en6k44zxufvgyy0f98w6c5n7ql6f2er7mehjfyrs3p76nk,
            team_id_home: 1field,
            team_id_away: 2field,
            goals_home: goals_home,
            goals_away: away_home,
        };
        Mapping::set(game_outcomes, aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm, game_outcome);
    }

    transition test_0 ()  {
        return then finalize;
    }

// ├ Storage fee: 0.001198
// ├ Finalize fee: 0.122
    finalize test_0 () {

        let goals_home: u64 = 0u64;
        let away_home: u64 = 0u64;

        for i: u8 in 1u8..11u8 {
            goals_home += 1u64;
        }
    
        let game_outcome: GameResult = GameResult {
            goals_home: goals_home,
            goals_away: away_home,
        };
        Mapping::set(game_result_0, aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm, game_outcome);
    }


// ├ Storage fee: 0.001198
// ├ Finalize fee: 0.126
    transition test_1 ()  {
        return then finalize;
    }

    finalize test_1 () {

        let goals_home: u64 = 0u64;
        let away_home: u64 = 0u64;

        for i: u8 in 1u8..11u8 {
            goals_home += 1u64;
        }
    
        let game_outcome: DetailedGameResult1 = DetailedGameResult1 {
            goals_home: [8field,8field,8field,8field,8field,8field,8field,8field,8field,8field],
            goals_away: [8field,8field,8field,8field,8field,8field,8field,8field,8field,8field],
        };
        Mapping::set(game_result_1, aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm, game_outcome);
    }


// ├ Storage fee: 0.001198
// ├ Finalize fee: 0.124
    transition test_2 ()  {
        return then finalize;
    }

    finalize test_2 () {

        let goals_home: u64 = 0u64;
        let away_home: u64 = 0u64;

        for i: u8 in 1u8..11u8 {
            goals_home += 1u64;
        }

        let event: MatchGoalEvent = MatchGoalEvent {
            team_address: aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm,
            player_id: 1field,
            goal_time: 50field,
            goal_scored: true,
        };
    
        let game_outcome: [MatchGoalEvent; 10] = [event, event, event, event, event, event, event, event, event, event];
        Mapping::set(game_result_2, aleo18w8pfxt0uae3a77kw2wrecwudvny2w7qszgyumcy2nt398rqxsyqm8pppm, game_outcome);
    }


    // transition test_3 ()  {
    //     return then finalize;
    // }

    // finalize test_3 () {

    //     let goals_home: u64 = 0u64;

    //     for i: u8 in 1u8..11u8 {
    //         goals_home += 1u64;
    //     }

    // }
    // transition test_4 ()  {
    //     return then finalize;
    // }

    // finalize test_4 () {

    //     let goals_home: u64 = 0u64;

    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;
    //     goals_home += 1u64;


    // }



}
