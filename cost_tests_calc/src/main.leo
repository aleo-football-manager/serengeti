// The 'cost_tests' program.
program cost_tests_calc_v004.aleo {
    
    mapping randomness_u8: u8 => [u8;5];
    mapping randomness_u32: u32 => [u32; 5];

    transition random (i: u8)  {
        return then finalize(i);
    }
    finalize random (i: u8) {
        Mapping::set(randomness_u8, i, [ChaCha::rand_u8(),ChaCha::rand_u8(),ChaCha::rand_u8(),ChaCha::rand_u8(),ChaCha::rand_u8()]);
    }

    transition prandom (i: u32)  {
        return then finalize(i);
    }
    

    finalize prandom (i: u32) {
        let random_1: u32 = ChaCha::rand_u32();
        Mapping::set(randomness_u32, i, [
            random_1.mod(100u32),
            random_1.mod(5433452u32).mod(100u32),
            random_1.mod(27552u32).mod(100u32),
            random_1.mod(15433452u32).mod(100u32),
            random_1.mod(92452u32).mod(100u32)]);
    }


    function modmod(val: u32, mod1: u32, mod2: u32) -> u32 {
        let result: u32 = val.mod(mod1).mod(mod2);
        return result;
    }
}
