-- test if an integer is divisible by another
isDivisible :: Integer -> Integer -> Bool
isDivisible a b = b * (div a b) == a

-- check that p is not divisible by an integer between q and the square root of p
testNonDivisible :: Integer -> Integer -> Bool
testNonDivisible p q | q*q > p = True
                     | isDivisible p q = False
                     | otherwise = testNonDivisible p (q+1)

-- check if a non-negative integer p is prime
isPrime :: Integer -> Bool
isPrime p | p <= 1 = False
          |otherwise = testNonDivisible p 2
