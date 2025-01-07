import Text.Read (readMaybe)
import Distribution.Simple.Utils (xargs)
import Distribution.Compat.Lens (_1)
--  Chapter 2: Baby's First Functions
doubleMe x = x + x

doubleUs x y = x*2 + y*2

-- calling a function from another function
doubleUs2 x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                        then x
                        else x*2

doubleSmallNumber2' x = (if x > 100 then x else x*2) + 1

boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

removeLowercase st = [c | c <- st, c `elem` ['A'..'Z']]

removeUppercase st = [c | c <- st, c `elem`['a'..'z']]



--  Chapter 4: Syntax in Functions

-- Pattern Matching
lucky :: (Integral a) => a -> String
lucky 7 = "Lucky Number Seven!"
lucky x = "Sorry, you're out of luck, pal!"



sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- Recursive factorial function
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n-1)

-- Pattern matching with tuples
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

 

first :: (a,b,c) -> a 
first (x, _, _) = x

second :: (a,b,c) -> b
second (_,y,_) = y 

third :: (a,b,c) -> c
third (_,_,c) = c


head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

capital :: String -> String 
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

-- Guards
densityTell :: (RealFloat a) => a-> a -> String
densityTell mass volume
    | mass / volume < 1.2 = "Wow! You're going for a ride in the sky!"  
    | mass / volume <= 1000.0 = "Have fun swimming, but watch out for sharks!"  
    | otherwise   = "If it's sink or swim, you're going to sink."

max' :: (Ord a) => a -> a -> a
max' a b
    | a > b = a
    | otherwise = b

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b = GT
    | a == b = EQ
    | otherwise = LT


densityTellMe :: (RealFloat a) => a -> a -> String
densityTellMe mass volume
    | density < air = "WoW! You're going for a ride in the sky!"
    | density <= water = "Have fun swimming, but watch out for sharks!"
    | otherwise = "If it's sink or swim, you're going to sink."
    where density = mass / volume
          air = 1.2
          water = 1000.0

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "." 
    where (f:_) = firstname
          (l:_) = lastname

calcDensity :: (RealFloat a) => [(a,a)] -> [a]
calcDensity xs = [density m v | (m,v) <- xs]
    where density mass volume = mass / volume

-- Let bindings
cylinder :: (RealFloat a ) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea = pi * r^2
    in sideArea + 2 * topArea



-- Case expressions
heads :: [a] -> a
heads xs = case xs of [] -> error "No head for empty Lists!"
                      (x:_) -> x
            

describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty"
                                               [a] -> "a singleton list"
                                               xs -> "a longer list."



maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Maximum of empty list!"
maximum' [x] = x
maximum'(x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs


maxmax  :: (Ord a) => [a] -> a
maxmax [] = error "Maximum of empty list!"
maxmax [x] = x
maxmax (x:xs) = max x (maxmax xs)

-- Replicating a number n times
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0  = []
    | otherwise = x:replicate' (n-1) x



take':: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x: take' (n-1) xs

-- Reversing a list
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x] -- where xs is tail and x is head we are trying to append the head to the end of the list

repeat' :: a -> [a]
repeat' x = x:repeat' x 

-- Zip two lists
zip' :: [a] -> [b] -> [(a,b)]
zip _ [] = []
zip [] _ =  []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

-- Checking if an element is in a list
-- elem' :: (Eq a) => a -> [a] -> Bool
-- elem' a [] = False
-- elem' a (x:xs)
--     | a == x = True
--     | otherwise = a `elem'` xs


elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x = True
    | otherwise = a `elem'` xs

-- Quick Sorting
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted