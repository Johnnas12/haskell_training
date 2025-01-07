-- | The `map` function applies a given function to each element in the list.
-- | It returns a new list where each element is the result of applying the function.
-- 
-- Example:
-- >>> map' (+1) [1, 2, 3]
-- [2, 3, 4]
map' :: (a->b) -> [a] -> [b]
map' _ [] = [] 
map' f (x:xs) = f x : map' f xs

-- | The `filter` function returns a list containing only the elements that satisfy a predicate.
-- 
-- Example:
-- >>> filter' even [1, 2, 3, 4]
filter' :: (a-> Bool) -> [a] -> [a] 
filter' _ [] = []
filter' p (x:xs) 
    | p x = x : filter' p xs 
    | otherwise = filter' p xs

-- | The `foldl` function reduces a list from the left using an accumulator and a function.
-- | The initial accumulator value is provided as the first argument.
-- 
-- Example:
-- >>> foldl' (+) 0 [1, 2, 3, 4]
-- 10
-- 
-- inside out approach
foldl' :: (b -> a -> b) -> b -> [a] -> b 
foldl' _ acc []     = acc              
foldl' f acc (x:xs) = foldl' f (f acc x) xs 

-- | The `foldr` function reduces a list from the right using an accumulator and a function.
-- | The initial accumulator value is provided as the first argument.
--
-- Example:
-- >>> foldr' (+) 0 [1, 2, 3, 4]
-- 10
-- outside in approach
foldr' :: (a -> b -> b) -> b -> [a] -> b 
foldr' _ acc []     = acc             
foldr' f acc (x:xs) = f x (foldr' f acc xs) 

-- | The `sum` function calculates the sum of all elements in a list.
-- | It is implemented using `foldl`.
-- 
-- Example:
-- >>> sum' [1, 2, 3, 4]
-- 10

sums :: (Num a) => [a] -> a
sums [] = 0 
sums (x:xs) = x + sums xs


-- same thing of doing the sum using foldl
-- sums :: Num a => [a] -> a
-- sums = foldl' (+) 0      


-- | The `product` function calculates the product of all elements in a list.
-- | It is not implemented using `foldl`.
--
product' :: (Num a) => [a] -> a
product' [] = 1 
product' (x:xs) = x * product' xs 

-- | count function counts the number of elements in a list that satisfy a predicate.
-- | It is implemented without using `foldl`.
count' :: (a -> Bool) -> [a] -> Int
count' _ [] = 0 
count' p (x:xs) 
    | p x = 1 + count' p xs 
    | otherwise = count' p xs 

-- compose function takes two functions and returns a new function that is the composition of the two functions.
compose' :: (b -> c) -> (a->b) -> (a -> c)
compose' f g = \x -> f (g x)