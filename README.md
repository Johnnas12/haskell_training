# **README: Running and Understanding `training002_task.hs`**

---

## **Prerequisites**

1. **Install Haskell Compiler**:
   - Install the [Glasgow Haskell Compiler (GHC)](https://www.haskell.org/ghc/) on your system.
   - Use `ghcup` for installation (recommended):
     ```bash
     curl -sSL https://get-ghcup.haskell.org | sh
     ghcup install ghc
     ghcup install cabal
     ```
   - Confirm installation:
     ```bash
     ghc --version
     cabal --version
     ```

2. **Set Up on Windows (Optional)**:
   - Use Windows Subsystem for Linux (WSL) if running on Windows, and install Haskell within WSL.

---

## **Steps to Run the File**

1. **Navigate to the Directory**:
   - Open a terminal and navigate to the folder containing `training002_task.hs`:
     ```bash
     cd /path/to/your/file
     ```

2. **Start GHCi**:
   - Launch the interactive GHCi REPL:
     ```bash
     ghci
     ```

3. **Load the File**:
   - Load `training002_task.hs` into GHCi:
     ```haskell
     :l training002_task.hs
     ```

4. **Test the Functions**:
   - After loading, you can test the functions directly in GHCi. For example:
     ```haskell
     map' (+1) [1, 2, 3]        -- Output: [2, 3, 4]
     filter' even [1, 2, 3, 4]  -- Output: [2, 4]
     foldl' (+) 0 [1, 2, 3, 4]  -- Output: 10
     sums [1, 2, 3, 4]          -- Output: 10
     product' [1, 2, 3, 4]      -- Output: 24
     count' even [1, 2, 3, 4]   -- Output: 2
     ```

---

## **Explanation of Functions in `training002_task.hs`**

### **1. `map'`**
Applies a function to every element of a list.
```haskell
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []  -- Base case: An empty list returns an empty list.
map' f (x:xs) = f x : map' f xs -- Apply f to the head, and recurse on the tail.
```

**Example**:
```haskell
map' (+1) [1, 2, 3] -- [2, 3, 4]
```

---

### **2. `filter'`**
Filters a list, keeping only elements that satisfy a predicate.
```haskell
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = [] -- Base case: An empty list returns an empty list.
filter' p (x:xs)
    | p x       = x : filter' p xs -- Include the element if it satisfies the predicate.
    | otherwise = filter' p xs     -- Skip the element otherwise.
```

**Example**:
```haskell
filter' even [1, 2, 3, 4] -- [2, 4]
```

---

### **3. `foldl'`**
Reduces a list from the left with an accumulator.
```haskell
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ acc []     = acc          -- Base case: Return the accumulator for an empty list.
foldl' f acc (x:xs) = foldl' f (f acc x) xs -- Apply f to acc and head, then recurse.
```

**Example**:
```haskell
foldl' (+) 0 [1, 2, 3, 4] -- 10
```

---

### **4. `foldr'`**
Reduces a list from the right.
```haskell
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ acc []     = acc          -- Base case: Return the accumulator for an empty list.
foldr' f acc (x:xs) = f x (foldr' f acc xs) -- Apply f to head and the result of folding the tail.
```

**Example**:
```haskell
foldr' (+) 0 [1, 2, 3, 4] -- 10
```

---

### **5. `sums`**
Calculates the sum of all elements in a list.
```haskell
sums :: (Num a) => [a] -> a
sums [] = 0               -- Base case: The sum of an empty list is 0.
sums (x:xs) = x + sums xs -- Add the head to the sum of the tail.
```

**Example**:
```haskell
sums [1, 2, 3, 4] -- 10
```

---

### **6. `product'`**
Calculates the product of all elements in a list.
```haskell
product' :: (Num a) => [a] -> a
product' [] = 1               -- Base case: The product of an empty list is 1.
product' (x:xs) = x * product' xs -- Multiply the head with the product of the tail.
```

**Example**:
```haskell
product' [1, 2, 3, 4] -- 24
```

---

### **7. `count'`**
Counts the number of elements in a list that satisfy a predicate.
```haskell
count' :: (a -> Bool) -> [a] -> Int
count' _ [] = 0             -- Base case: No elements in an empty list.
count' p (x:xs)
    | p x       = 1 + count' p xs -- Increment count if predicate is satisfied.
    | otherwise = count' p xs     -- Skip otherwise.
```

**Example**:
```haskell
count' even [1, 2, 3, 4] -- 2
```

---

### **8. `compose'`**
Composes two functions.
```haskell
compose' :: (b -> c) -> (a -> b) -> (a -> c)
compose' f g = \x -> f (g x) -- Return a function that applies g, then f.
```

**Example**:
```haskell
let f = (*2)   -- Doubles a number.
let g = (+3)   -- Adds 3 to a number.
compose' f g 5 -- (f . g) 5 = f (g 5) = (*2) ((+3) 5) = 16
```

---


