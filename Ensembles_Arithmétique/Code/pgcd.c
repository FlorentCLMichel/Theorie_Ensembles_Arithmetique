int pgcd(unsigned int n, unsigned int m) {
    
    unsigned int a;
    unsigned int b;
    unsigned int c;

    if (n <= m) {
        a = m;
        b = n;
    } else {
        a = n;
        b = m;
    }
    
    while (b > 0) {
        c = a % b;
        a = b;
        b = c;
    }

    return a;
}
