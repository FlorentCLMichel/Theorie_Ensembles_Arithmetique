fn is_prime(n: usize) -> bool{
    
    if n < 2 {
        return false;
    } 
    if n < 4 {
        return true;
    }
    if n%2 == 0 {
        return false;
    }

    let mut m: usize = 3;
    while m*m <= n {
        if n%m ==0 {
            return false;
        }
        m += 2;
    }

    true
}
