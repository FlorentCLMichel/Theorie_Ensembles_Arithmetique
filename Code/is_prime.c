bool is_prime(unsigned int n) {
    
    if (n < 2) {
        return false;
    } 
    if (n < 4) {
        return true;
    }
    if (n%2 == 0) {
        return false;
    }

    unsigned int m = 3;
    while (m*m <= n) {
        if (n%m == 0) {
            return false;
        }
        m += 2;
    }

    return true;
}
