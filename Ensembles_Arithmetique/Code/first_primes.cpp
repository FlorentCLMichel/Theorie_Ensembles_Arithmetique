#include <fstream>
#include <iterator>
#include "Érastosthène.cpp"

const number MAX_NUMBER = 9437;

int main() {
    const std::vector primes = primes_below_n(MAX_NUMBER);
    std::ofstream output_file("./first_primes.dat");
    std::ostream_iterator<number> output_iterator(output_file, "\n");
    std::copy(std::begin(primes), std::end(primes), output_iterator);
    return 0;
}
