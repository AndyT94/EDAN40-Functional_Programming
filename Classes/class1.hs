import Data.Ord
import Data.List

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


-- Factors
smallestFactor :: Int -> Int
smallestFactor n = nextFactor 2 n

nextFactor :: Int -> Int -> Int
nextFactor k n
  | k >= n = n
  | mod n k == 0 = k
  | otherwise = nextFactor (k+1) n

numFactors :: Int -> Int
numFactors n = length [x | x <- [1..n], mod n x == 0]


-- Defining Types
type Month = Int
data Date = Date Int Month Int

daysInMonth :: Month -> Int -> Int
daysInMonth m y
  | m <= 0 || m > 12 = 0
  | m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12 = 31
  | m == 4 || m == 6 || m == 9 || m == 11 = 30
  | mod y 4 == 0 = 29
  | otherwise = 28

validDate :: Date -> Bool
validDate (Date y m d) = d > 0 && daysInMonth m y >= d


-- Multiplying List Elements
multiply :: Num a => [a] -> a
multiply = foldl1 (*)


-- Substitution
substitute :: Eq a => a -> a -> [a] -> [a]
substitute a b [] = []
substitute a b (x:xs)
  | a == x = b:(substitute a b xs)
  | otherwise = x:(substitute a b xs)


-- Avoiding duplicates
duplicates :: Eq a => [a] -> Bool
duplicates [] = False
duplicates (x:xs)
  | elem x xs = True
  | otherwise = duplicates xs

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs)
  | elem x xs = removeDuplicates xs
  | otherwise = x: removeDuplicates xs

prop_duplicatesRemoved :: [Int] -> Bool
prop_duplicatesRemoved xs = not (duplicates (removeDuplicates xs))


-- Comprehensions
pythagorean :: Int -> [(Int, Int, Int)]
pythagorean n = [(a, b, c) | a <- [1..n], b <- [1..n], c <- [1..n], a^2 + b^2 == c^2]


-- Permutations
isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation [] [] = True
isPermutation _ [] = False
isPermutation [] _ = False
isPermutation (x:xs) ys
  | elem x ys = isPermutation xs (remove x ys)
  | otherwise = False

remove :: Eq a => a -> [a] -> [a]
remove _ [] = []
remove y (x:xs)
 | y == x = xs
 | otherwise = x:(remove y xs)


--Shortest and Longest
shortestAndLongest :: [String] -> (String, String)
shortestAndLongest [] = ([], [])
shortestAndLongest list = (shortest list, longest list)

shortest :: [String] -> String
shortest xs = minimumBy (comparing length) xs

longest :: [String] -> String
longest xs = maximumBy (comparing length) xs


-- Mystery
mystery xs = foldr (++) [] (map (\y -> [y]) xs)
