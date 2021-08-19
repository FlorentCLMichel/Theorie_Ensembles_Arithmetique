fn pgcd(n: usize, m: usize) -> usize {
    
    let mut a: usize;
    let mut b: usize;
    let mut c: usize;

    if n >= m {
        a = n;
        b = m
    } else {
        a = m;
        b = n;
    }

    while b>0 {
        c = b;
        b = a - (a/b)*b;
        a = c;
    }

    a
}
