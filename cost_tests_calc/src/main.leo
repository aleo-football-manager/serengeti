// The 'cost_tests' program.
program cost_tests_calc_v001.aleo {
    
    transition greater_1 (var1: u8, var2: u8)  {
        return then finalize (var1, var2);
    }
    finalize greater_1 (var1: u8, var2: u8) {
        let r: bool = var1.gt(var2);
    }
    transition greater_2 (var1: u8, var2: u8)  {
        return then finalize (var1, var2);
    }
    finalize greater_2 (var1: u8, var2: u8) {
        let r: bool = var1 > var2;
    }
    transition greater_1_field (var1: field, var2: field)  {
        return then finalize (var1, var2);
    }
    finalize greater_1_field (var1: field, var2: field) {
        let r: bool = var1.gt(var2);
    }
    transition greater_2_field (var1: field, var2: field)  {
        return then finalize (var1, var2);
    }
    finalize greater_2_field (var1: field, var2: field) {
        let r: bool = var1 > var2;
    }

    transition main (a: u8, b: u8) -> u8 {
        let c: u8 = a + b;
        return c;
    }
}
