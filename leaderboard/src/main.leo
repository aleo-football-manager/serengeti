program football_leaderboard_v002.aleo {
    struct User {
        win: u64,
        draw: u64,
        loss: u64,
        goals_scored: u64,
        goals_conceded: u64
    }

    mapping users: address => User;

    transition update_score(user_id: address, goals_scored: u64, goals_conceded: u64) {
        // TODO: Who is able to call this? Should not be able to be called by anyone, except game contract
        // assert_eq(self.caller, self.signer);
        return then finalize(user_id, goals_scored, goals_conceded);
    }

    // TODO: Modify this to add results for both home and away team
    finalize update_score(user_id: address, goals_scored: u64, goals_conceded: u64) {
        let current_user: User = Mapping::get_or_use(users, user_id, User {
            win: 0u64,
            draw: 0u64,
            loss: 0u64,
            goals_scored: 0u64,
            goals_conceded: 0u64
        });

        Mapping::set(users, user_id, User {
            // Update result by 1
            win: goals_scored > goals_conceded ? current_user.win + 1u64 : current_user.win,
            draw: goals_scored == goals_conceded ? current_user.draw + 1u64 : current_user.draw,
            loss: goals_scored < goals_conceded ? current_user.loss + 1u64 : current_user.loss,
            
            // Update goals scored and conceded
            goals_scored: current_user.goals_scored + goals_scored,
            goals_conceded: current_user.goals_conceded + goals_conceded
        });
    }


    transition update_score_both_teams(home: address, away: address, goals_home: u64, goals_away: u64) {
        // TODO: Who is able to call this? Should not be able to be called by anyone, except game contract
        // assert_eq(self.caller, self.signer);
        return then finalize(home, away, goals_home, goals_away);
    }

    // TODO: untested code, this function is not deployed/tested yet. and needs to be updated with a for loop
    finalize update_score_both_teams(home: address, away: address, goals_home: u64, goals_away: u64) {
        let home_user: User = Mapping::get_or_use(users, home, User {
            win: 0u64,
            draw: 0u64,
            loss: 0u64,
            goals_scored: 0u64,
            goals_conceded: 0u64
        });

        let away_user: User = Mapping::get_or_use(users, away, User {
            win: 0u64,
            draw: 0u64,
            loss: 0u64,
            goals_scored: 0u64,
            goals_conceded: 0u64
        });

        // Todo user a for loop to remove duplicate code
        Mapping::set(users, home, User {
            // Update result by 1
            win: goals_home > goals_away ? home_user.win + 1u64 : home_user.win,
            draw: goals_home == goals_away ? home_user.draw + 1u64 : home_user.draw,
            loss: goals_home < goals_away ? home_user.loss + 1u64 : home_user.loss,
            
            // Update goals scored and conceded
            goals_scored: home_user.goals_scored + goals_home,
            goals_conceded: home_user.goals_conceded + goals_away
        });

        // Todo user a for loop to remove duplicate code
        Mapping::set(users, away, User {
            // Update result by 1
            win: goals_home < goals_away ? away_user.win + 1u64 : away_user.win,
            draw: goals_home == goals_away ? away_user.draw + 1u64 : away_user.draw,
            loss: goals_home > goals_away ? away_user.loss + 1u64 : away_user.loss,
            
            // Update goals scored and conceded
            goals_scored: away_user.goals_scored + goals_away,
            goals_conceded: away_user.goals_conceded + goals_home
        });
        
    }

    
}