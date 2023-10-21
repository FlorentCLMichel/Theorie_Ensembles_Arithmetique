fn inverse_mod(n: isize, q: isize) -> Option<isize> {
    
    let mut a: isize = n;
    let mut b: isize = q;
    let mut c: isize;
    let mut u: isize = 1;
    let mut v: isize = 0;
    let mut w: isize;
    let mut e: isize;

    while b > 0 {
        e = a / b;
        w = u;
        u = v;
        v = w - e * v;
        c = b;
        b = a - e * b;
        a = c;
    }

    if a == 1 {
        let u_p : isize = u + q;
        return Some(u_p - Into::<isize>::into(u_p >= q) * q);
    } else {
        return None;
    }
}
