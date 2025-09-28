mod Erastosthenes_lib;
use Erastosthenes_lib::*;

// Sieve of Erastosthenes
// return a vector with all the prime numbers no larger than n
pub fn primes_below_n(n: Number) -> Vec<Number> {
    let mut is_prime = make_bool_array(n as usize);
    set_bool_array(&mut is_prime, 0, false);
    let mut index: Number = 1;
    let mut alpha: Number = 1;
    let mut i: Number;
    while index < n {
        i = (index+1)*(index+1)-1;
        while i < n {
            set_bool_array(&mut is_prime, i, false);
            i += alpha * (index+1);
        }
        if index==1 {
            alpha = 2;
        }
        index += 1;
        while (index < n) && (!read_bool_array(&is_prime, index)) {
            index += 1;
        }
    }
    let mut res = Vec::<Number>::new();
    for i in 0 .. n {
        if read_bool_array(&is_prime, i) {
            res.push(i+1);
        }
    }
    return res;
}
