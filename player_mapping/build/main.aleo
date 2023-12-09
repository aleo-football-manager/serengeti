program player_mapping_v002.aleo;

struct Player:
    player_id as u8;
    team_id as u8;
    goalkeeper as boolean;
    attack as u8;
    defense as u8;
    speed as u8;
    power as u8;
    stamina as u8;
    technique as u8;
    goalkeeping as u8;


mapping player_mapping:
	key as u8.public;
	value as Player.public;

function main:
    input r0 as boolean.private;


function add_player:
    input r0 as Player.private;
    async add_player r0 into r1;
    output r1 as player_mapping_v001.aleo/add_player.future;

finalize add_player:
    input r0 as Player.public;
    contains player_mapping[r0.player_id] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into player_mapping[r0.player_id];
