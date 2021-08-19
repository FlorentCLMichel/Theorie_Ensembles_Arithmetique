-- prepend an element to a list
prepend :: a -> [a] -> [a]
prepend x [] = [x]
prepend x (y:l) = y : (prepend x l)

-- last element of a list (re-implementtaion; the default one should be used in real-world applications)
last_list :: [a] -> a
last_list [x] = x
last_list (x:l) = last_list l

-- determine if p is prime given an ordered list of all prime numbers at least up to its square root
isPrime_l :: Integer -> [Integer] -> Bool
isPrime_l p [] = True
isPrime_l p (q:l) | isDivisible p q = False
                  | q*q > p = True
                  | otherwise = isPrime_l p l

-- find the next prime number given an ordered list of all previous ones
nextPrime :: Integer -> [Integer] -> Integer
nextPrime p l | isPrime_l (p+1) l = (p+1)
              | otherwise = nextPrime (p+1) l

-- find the N next prime numbers given an ordered list of all previous ones
findNextPrimes :: Integer -> [Integer] -> [Integer]
findNextPrimes 0 l = l
findNextPrimes n l = let y = (nextPrime (last_list l) l) in
    findNextPrimes (n-1) (prepend y l)

-- find the N first prime numbers
findNPrimes :: Integer -> [Integer]
findNPrimes n = findNextPrimes (n-1) [2]
