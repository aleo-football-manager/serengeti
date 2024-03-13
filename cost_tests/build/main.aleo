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


function randomness_u8_1:
    async randomness_u8_1 into r0;
    output r0 as cost_tests_v001.aleo/randomness_u8_1.future;

finalize randomness_u8_1:
    rand.chacha into r0 as u8;


function randomness_u8_2:
    async randomness_u8_2 into r0;
    output r0 as cost_tests_v001.aleo/randomness_u8_2.future;

finalize randomness_u8_2:
    rand.chacha into r0 as u8;
    rand.chacha into r1 as u8;


function randomness_u8_10:
    async randomness_u8_10 into r0;
    output r0 as cost_tests_v001.aleo/randomness_u8_10.future;

finalize randomness_u8_10:
    rand.chacha into r0 as u8;
    rand.chacha into r1 as u8;
    rand.chacha into r2 as u8;
    rand.chacha into r3 as u8;
    rand.chacha into r4 as u8;
    rand.chacha into r5 as u8;
    rand.chacha into r6 as u8;
    rand.chacha into r7 as u8;
    rand.chacha into r8 as u8;
    rand.chacha into r9 as u8;


function randomness_u128_1:
    async randomness_u128_1 into r0;
    output r0 as cost_tests_v001.aleo/randomness_u128_1.future;

finalize randomness_u128_1:
    rand.chacha into r0 as u128;


function randomness_u128_10:
    async randomness_u128_10 into r0;
    output r0 as cost_tests_v001.aleo/randomness_u128_10.future;

finalize randomness_u128_10:
    rand.chacha into r0 as u128;
    rand.chacha into r1 as u128;
    rand.chacha into r2 as u128;
    rand.chacha into r3 as u128;
    rand.chacha into r4 as u128;
    rand.chacha into r5 as u128;
    rand.chacha into r6 as u128;
    rand.chacha into r7 as u128;
    rand.chacha into r8 as u128;
    rand.chacha into r9 as u128;


function randomness_field_1:
    async randomness_field_1 into r0;
    output r0 as cost_tests_v001.aleo/randomness_field_1.future;

finalize randomness_field_1:
    rand.chacha into r0 as field;


function randomness_field_10:
    async randomness_field_10 into r0;
    output r0 as cost_tests_v001.aleo/randomness_field_10.future;

finalize randomness_field_10:
    rand.chacha into r0 as field;
    rand.chacha into r1 as field;
    rand.chacha into r2 as field;
    rand.chacha into r3 as field;
    rand.chacha into r4 as field;
    rand.chacha into r5 as field;
    rand.chacha into r6 as field;
    rand.chacha into r7 as field;
    rand.chacha into r8 as field;
    rand.chacha into r9 as field;
