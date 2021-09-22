#include <vector>

// data type to use for numbers
typedef unsigned long number; 

// Sieve of Erastosthenes
// return a vector with all the prime numbers no larger than n
std::vector<number> primes_below_n(number n) {
    std::vector<bool> isPrime(n, true);
    isPrime[0] = false;
    number index = 1;
    char alpha = 1;
    number i;
    while (index < n) {
        i = (index+1)*(index+1)-1;
        while (i < n) {
            isPrime[i] = false;
            i += alpha * (index+1);
        }
        if (index==1) {
            alpha = 2;
        }
        index++;
        while ((!(isPrime[index])) && (index < n)) {
            index++;
        }
    }
    std::vector<number> res;
    for (number i=0; i<n; i++) {
        if (isPrime[i]) {
            res.push_back(i+1);
        }
    }
    return res;
}
