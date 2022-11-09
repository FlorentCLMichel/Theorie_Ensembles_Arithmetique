pgcd :: Integer -> Integer -> Integer
pgcd n 0 = n
pgcd n m | n < m = pgcd m n
         | otherwise = pgcd m (n - (m * (div n m)))
