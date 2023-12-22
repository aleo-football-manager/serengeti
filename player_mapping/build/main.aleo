program player_mapping_v004.aleo;

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
    output r1 as player_mapping_v004.aleo/add_player.future;

finalize add_player:
    input r0 as SimplePlayer.public;
    contains player_mapping[r0.player_id] into r1;
    not r1 into r2;
    assert.eq r2 true;
    set r0 into player_mapping[r0.player_id];


function add_all_players:
    async add_all_players into r0;
    output r0 as player_mapping_v004.aleo/add_all_players.future;

finalize add_all_players:
    rand.chacha into r0 as u8;
    cast 1u8 false r0 into r1 as SimplePlayer;
    set r1 into player_mapping[1u8];
    rand.chacha into r2 as u8;
    cast 2u8 false r2 into r3 as SimplePlayer;
    set r3 into player_mapping[2u8];
    rand.chacha into r4 as u8;
    cast 3u8 false r4 into r5 as SimplePlayer;
    set r5 into player_mapping[3u8];
    rand.chacha into r6 as u8;
    cast 4u8 false r6 into r7 as SimplePlayer;
    set r7 into player_mapping[4u8];
    rand.chacha into r8 as u8;
    cast 5u8 false r8 into r9 as SimplePlayer;
    set r9 into player_mapping[5u8];
    rand.chacha into r10 as u8;
    cast 6u8 false r10 into r11 as SimplePlayer;
    set r11 into player_mapping[6u8];
    rand.chacha into r12 as u8;
    cast 7u8 false r12 into r13 as SimplePlayer;
    set r13 into player_mapping[7u8];
    rand.chacha into r14 as u8;
    cast 8u8 false r14 into r15 as SimplePlayer;
    set r15 into player_mapping[8u8];
    rand.chacha into r16 as u8;
    cast 9u8 false r16 into r17 as SimplePlayer;
    set r17 into player_mapping[9u8];
    rand.chacha into r18 as u8;
    cast 10u8 false r18 into r19 as SimplePlayer;
    set r19 into player_mapping[10u8];
