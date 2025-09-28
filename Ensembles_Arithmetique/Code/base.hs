-- read a non-negative integer (first argument) in base b
from_base_acc :: Integer -> [Integer] -> Integer -> Integer
from_base_acc acc [] b = acc
from_base_acc acc (x:l) b = from_base_acc (x + b*acc) l b 
from_base = from_base_acc 0

-- conversion of a non-negative integer n in base b
to_base_acc :: [Integer] -> Integer -> Integer -> [Integer]
to_base_acc acc x b | x == 0 = acc
                    | otherwise = let y = (mod x b) in 
                         to_base_acc (y:acc) (div (x-y) b) b
to_base = to_base_acc []
