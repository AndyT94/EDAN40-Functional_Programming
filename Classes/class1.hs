-- The Maximum Function
maxi :: Ord a => a -> a -> a
maxi x y
  | x >= y    = x
  | otherwise = y
