-- The Maximum Function
maxi :: Ord a => a -> a -> a
maxi x y
  | x >= y = x
  | otherwise = y


-- Sum of squares recursion
sumsq :: Int -> Int
sumsq n
  | n <= 0 = 0
  | otherwise = n * n + sumsq (n-1)


-- Sum of squares mapping
sumsqMap :: Int -> Int
sumsqMap n
  | n <= 0 = 0
  | otherwise = foldl (+) 0 (map (^2) [1..n])


-- The Towers of Hanoi
hanoi :: Int -> Int
hanoi n
  | n <= 0 = 0
  | otherwise = 1 + 2 * hanoi (n - 1)
