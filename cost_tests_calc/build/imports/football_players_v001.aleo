program football_players_v001.aleo;

struct Player:
    player_id as field;
    team_id as field;
    position as field;
    attack as u128;
    defense as u128;
    speed as u128;
    power as u128;
    stamina as u128;
    technique as u128;
    goalkeeping as u128;


mapping players:
	key as field.public;
	value as Player.public;

function add_player:
    input r0 as Player.private;
    async add_player r0 into r1;
    output r1 as football_players_v001.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    set r0 into players[r0.player_id];
