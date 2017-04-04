-- The Maximum Function
maxi :: Ord a => a -> a -> a
maxi x y
  | x >= y    = x
  | otherwise = y


-- Sum of squares recursion
sumsq :: Int -> Int
sumsq n
  | n <= 0    = 0
  | otherwise = n * n + sumsq (n-1)


-- Sum of squares mapping
sumsqMap :: Int -> Int 
