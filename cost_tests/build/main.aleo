program cost_tests_v001.aleo;

struct Player:
    player_id as u8;
    team_id as u8;
    position as field;
    attack as u8;
    defense as u8;
    speed as u8;
    power as u8;
    stamina as u8;
    technique as u8;
    goalkeeping as u8;


mapping players:
	key as u8.public;
	value as Player.public;

function main:
    input r0 as Player.private;
    async main r0 into r1;
    output r1 as cost_tests_v001.aleo/main.future;

finalize main:
    input r0 as Player.public;
    set r0 into players[r0.player_id];


function add_player:
    input r0 as Player.private;
    async add_player r0 into r1;
    output r1 as cost_tests_v001.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    set r0 into players[r0.player_id];
