// data type to use for numbers
type Number = usize;

// create an array of bools initialized to true
// implemented as an array of u8, where each u8 codes for 8 bools
fn make_bool_array(length: usize) -> Vec<u8> {
    if length%8==0 {
        vec![255; length/8]
    } else {
        vec![255; length/8+1]
    }
}

// read an entry from an array of bools
fn read_bool_array(array: &Vec<u8>, index: usize) -> bool {
    let index_u8: usize = index/8;
    let index_bit = index%8;
    if array[index_u8] & (0b0000_0001 << index_bit) == 0 {
        false
    } else {
        true
    }
}

// set the value of an entry
fn set_bool_array(array: &mut Vec<u8>, index: usize, val: bool) {
    let index_u8: usize = index/8;
    let index_bit = index%8;
    if val {
        array[index_u8] |= 0b0000_0001 << index_bit;
    } else {
        array[index_u8] &= 255 - (0b0000_0001 << index_bit);
    }
}

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
        index+=1;
        while (index < n) && (!read_bool_array(&is_prime, index)) {
            index+=1;
        }
    }
    let mut res = Vec::<Number>::new();
    for i in 0..n {
        if read_bool_array(&is_prime, i) {
            res.push(i+1);
        }
    }
    return res;
}
