<img src="https://github.com/aleo-football-manager/serengeti/blob/658cf50f430938d9efff826cffa2a16816290d7c/files/cover1.png" alt="cover" />
<h4 align="center">
  <a href="https://superleolig.vercel.app/">Deployed app</a> |
  <a href="https://github.com/aleo-football-manager/game-frontend">Front-end repo</a>
</h4>

# Super Leo Lig
Super Leo Lig is a game based on the [Where's Alex game by that is created by Puzzle](https://wheresalex.puzzle.online/). Super Leo Lig uses the same flow as the Where's Alex game, but changed the logic to turn it into a simple football management game.

<br /> 

## How does the game works?
Challenge another person on Aleo with a wager. Select a team and come up with the best formation/strategy. If your team beats the opponent, then you win the prize pot! 

<br />

## Differences with Where's Alex

- *Randomness:* The outcomes or Super Leo Lig are not only determined by user's choices/input, but also partly based on randomness.
- *Input:* Instead of using a single input value, users now select 11 players. All players have a full profile of stats, which all affect the outcome of the game.

<br />


## How does the game work?
The FE for the game utilizes key multisig features using the Puzzle Wallet and Puzzle SDK described below. <br /> <br />
The game is split into 3 Leo Programs described below:
1. Puzzle Pieces token program (with _n_ of _n_ programmable multisig functions)
2. Multiparty PVP utils program (Modified to accept array of 11 u8's instead of a single field var)
3. Football Game program

<br /> 

If you're interested in building your own multiparty game on Aleo, fork this repo and give it a shot! 

# How to play Super Leo Lig
1. Starting a new game (challenger)
- mint Puzzle Pieces if you don't have already
- challenge another Aleo address
- pick a team and select 11 players (1 goalkeeper and 10 field players)
- set your wager amount to win if your opponent guesses wrong!

<br /> 

2. Accepting a new game (opponent)
- mint puzzle pieces if you don't have already
- match wager from the challenger
- pick a team and select 11 players (1 goalkeeper and 10 field players)
- accept the game and lock in the wagers to win if you guess correct!

<br /> 

3. Finishing a game (challenger)
- Reveal your answer
- Finish the geam and payout the wagers to you if the opponent guessed wrong or the opponent if they guessed right!

NOTE: Different function executions require different keys (player 1, player 2, multisig keys). For testing purposes, you can run the below to switch execution keys.

<br /><br />

We also have a `test.sh` script [here](./football_game_vXXX/test.sh) that runs through all the flows.

```
echo "
NETWORK=testnet3
PRIVATE_KEY={MS_PK || P1_PK | P2_PK}
" > .env
```

