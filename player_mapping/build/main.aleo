program player_mapping_v002.aleo;

struct SimplePlayer:
    player_id as u8;
    goalkeeper as boolean;
    attack as u8;


mapping player_mapping:
	key as u8.public;
	value as SimplePlayer.public;

function main:
    input r0 as boolean.private;


function add_player:
    input r0 as SimplePlayer.private;
    async add_player r0 into r1;
    output r1 as player_mapping_v002.aleo/add_player.future;

finalize add_player:
    input r0 as SimplePlayer.public;
    contains player_mapping[r0.player_id] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into player_mapping[r0.player_id];


function add_player_owner:
    input r0 as SimplePlayer.private;
    assert.eq self.caller self.signer;
    async add_player_owner r0 into r1;
    output r1 as player_mapping_v002.aleo/add_player_owner.future;

finalize add_player_owner:
    input r0 as SimplePlayer.public;
    contains player_mapping[r0.player_id] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into player_mapping[r0.player_id];
