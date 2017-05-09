module Lib
    (
        similarityScore
      , maximaBy
      , optAlignments
      , outputOptAlignments
      , similarityScore'
      , optAlignments'
    ) where

import Data.List
import Control.Arrow

scoreMatch = 0
scoreMismatch = -1
scoreSpace = -1

-- | Returns the score of the optimal alignment of two strings.
--   scoreMatch, scoreMisMatch, scoreSpace is the used parameters
--   for measuring "optimalness".
similarityScore :: String -> String -> Int
similarityScore [] ts = scoreSpace * length ts
similarityScore ss [] = scoreSpace * length ss
similarityScore alls@(s:ss) allt@(t:ts) = maximum [keepLetters, spaceS, spaceT]
    where keepLetters = score s t + similarityScore ss ts
          spaceS      = scoreSpace + similarityScore alls ts
          spaceT      = scoreSpace + similarityScore ss allt

-- | Returns the score associated by matching the characters x and y.
--   The matching parameters(scoreMatch, scoreMisMatch, scoreSpace) are
--   used.
score :: Char -> Char -> Int
score x y
  | x == '-' || y == '-' = scoreSpace
  | x == y               = scoreMatch
  | otherwise            = scoreMismatch

-- | Takes two elements and a list of pairs where each pair consists of two lists.
--   The first element is prepended to the first list of all pairs. The second
--   element is prepended to the second list of all pairs. The modified pairs
--   are returned as a list.
attachHeads :: a -> a -> [([a],[a])] -> [([a],[a])]
attachHeads h1 h2 aList = [(h1:xs,h2:ys) | (xs,ys) <- aList]

-- | Takes a list of elements and returns all the "maximum" elements.
--   The elements are compared using the provided function.
--
--   Examples:
--
--   >>> maximaBy length ["hej", "fisk", "ksif", "he"]
--   ["fisk","ksif"]
maximaBy :: Ord b => (a -> b) -> [a] -> [a]
maximaBy valueFcn xs = [x | x <- xs, valueFcn x == maximum (map valueFcn xs)]

type AlignmentType = (String, String)

-- | Takes two strings s and t and returns all optimal alignments of
--   the two strings.
optAlignments :: String -> String -> [AlignmentType]
optAlignments [] t = [(replicate (length t) '-', t)]
optAlignments s [] = [(s, replicate (length s) '-')]
optAlignments alls@(s:ss) allt@(t:ts) = concat $ maximaBy (compScore.head) alignments
  where alignments  = [keepLetters, spaceS, spaceT]
        keepLetters = attachHeads s t $ optAlignments ss ts
        spaceS      = attachHeads '-' t $ optAlignments alls ts
        spaceT      = attachHeads s '-' $ optAlignments ss allt
        compScore   = uncurry $ (sum .) . zipWith score

-- | Takes two strings s and t and prints all optimal alignments of
--   the two strings.
outputOptAlignments :: String -> String -> IO ()
outputOptAlignments s t = do
  let alignments = optAlignments' s t
  putStrLn ("\nThere are " ++ show (length alignments) ++ " optimal alignments:\n")
  sequence_ [putStrLn (intersperse ' ' a ++ "\n" ++ intersperse ' ' b ++ "\n") | (a, b) <- alignments]
  putStrLn ("There were " ++ show (length alignments) ++ " optimal alignments!")

-- Same as similarityScore just faster
similarityScore' :: String -> String -> Int
similarityScore' ss ts = simScore (length ss) $ length ts
  where simScore i j = simTable!!i!!j
        simTable = [[simEntry i j | j <- [0..]] | i <- [0..]]

        simEntry :: Int -> Int -> Int
        simEntry 0 j = scoreSpace * j
        simEntry i 0 = scoreSpace * i
        simEntry i j  = maximum [keepLetters, spaceS, spaceT]
          where keepLetters     = score s t + simScore (i-1) (j-1)
                spaceS          = scoreSpace + simScore i (j-1)
                spaceT          = scoreSpace + simScore (i-1) j
                s               = ss!!(i-1)
                t               = ts!!(j-1)

-- Same as optAlignments just faster
optAlignments' :: String -> String -> [AlignmentType]
optAlignments' ss ts = map (reverse *** reverse) $ snd $ optAl (length ss) $ length ts
  where optAl i j = optTable!!i!!j
        optTable = [[optEntry i j | j <- [0..]] | i <- [0..]]

        optEntry :: Int -> Int -> (Int, [AlignmentType])
        optEntry 0 j = (scoreSpace*j, [(replicate j '-', take j ts)])
        optEntry i 0 = (scoreSpace*i, [(take i ss, replicate i '-')])
        optEntry i j = (fst $ head entryAl, concatMap snd entryAl)
          where entryAl     = maximaBy fst [keepLetters, spaceS, spaceT]
                keepLetters = ((+ score s t) *** attachHeads s t) $ optAl (i-1) (j-1)
                spaceS      = ((+ scoreSpace) *** attachHeads '-' t) $ optAl i (j-1)
                spaceT      = ((+ scoreSpace) *** attachHeads s '-') $ optAl (i-1) j
                s               = ss!!(i-1)
                t               = ts!!(j-1)
