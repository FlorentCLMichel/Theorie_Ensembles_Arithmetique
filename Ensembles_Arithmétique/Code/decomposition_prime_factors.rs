#[path="./Érastosthène.rs"]
#[allow(non_snake_case)]
mod Érastosthène;
use Érastosthène::primes_below_n;

use std::io::Write;

const N: usize = 200;

fn decomposition_prime_factors(mut n: usize, primes: &[usize]) -> Result<Vec<(usize, usize)>, NotEnoughPrimesError> {
    
    // vector to store the result
    let mut res = Vec::<(usize, usize)>::new();
    
    let mut index_prime = 0;
    while n > 1 {
        
        if index_prime >= primes.len() {
            return Err(NotEnoughPrimesError)
        }
        
        let mut power: usize = 0;
        while n % primes[index_prime] == 0 {
            power += 1;
            n /= primes[index_prime];
        }

        if power > 0 {
            res.push((primes[index_prime], power));
        }
        
        index_prime += 1;
    } 

    Ok(res)
}

fn print_decomposition(decomposition: &[(usize, usize)]) -> String {

    let mut res = "".to_string();
    for (p, a) in decomposition.iter() {
        res += &format!("{}^{{{}}} × ", p, a);
    }
    let mut chars = res.chars();

    // trim the last three characters
    chars.next_back();
    chars.next_back();
    chars.next_back();
    chars.as_str().to_string()
}

#[derive(Debug, Clone)]
struct NotEnoughPrimesError;

impl std::fmt::Display for NotEnoughPrimesError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "Not enough prime numbers!")
    }
}

impl std::error::Error for NotEnoughPrimesError {}


fn main() -> Result<(), Box<dyn std::error::Error>> {
    let primes = primes_below_n(N);
    let mut string_to_write = "\\begin{equation*}\n\\begin{aligned}".to_string();
    for n in 2..=N {
        string_to_write += &format!("\n& {} = {} \\\\", n, print_decomposition(&decomposition_prime_factors(n, &primes)?));
    }
    string_to_write += "\n\\end{aligned}\n\\end{equation*}";
    
    let f_name = "output_decomposition_prime_factors.tex";
    let mut output = std::fs::File::create(f_name)?;
    write!(output, "{}", string_to_write)?;
    
    Ok(())
}
