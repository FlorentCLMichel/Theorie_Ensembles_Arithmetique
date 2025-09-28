// data type to use for numbers
type Number = usize;

// create an array of bools initialized to true
// implemented as an array of u8, where each u8 codes for 8 bools
pub fn make_bool_array(length: usize) -> Vec<u8> {
    if length%8==0 {
        vec![255; length/8]
    } else {
        vec![255; length/8+1]
    }
}

// read an entry from an array of bools
pub fn read_bool_array(array: &Vec<u8>, index: usize) -> bool {
    let index_u8: usize = index/8;
    let index_bit = index%8;
    if array[index_u8] & (0b0000_0001 << index_bit) == 0 {
        false
    } else {
        true
    }
}

// set the value of an entry
pub fn set_bool_array(array: &mut Vec<u8>, index: usize, val: bool) {
    let index_u8: usize = index/8;
    let index_bit = index%8;
    if val {
        array[index_u8] |= 0b0000_0001 << index_bit;
    } else {
        array[index_u8] &= 255 - (0b0000_0001 << index_bit);
    }
}
