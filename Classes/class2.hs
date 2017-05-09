import Data.Maybe
import Data.List

-- 2.1 Propositional Logic

data Proposition = Var String
                  | Proposition :&: Proposition
                  | Proposition :|: Proposition
                  | Not Proposition
  deriving (Eq, Show)

-- | Rreturns a list of the variables in a proposition.
vars :: Proposition -> [String]
vars (Var x) = [x]
vars (a :&: b) = vars a `union` vars b
vars (a :|: b) = vars a `union` vars b
vars (Not a)   = vars a

-- | Determines whether the proposition is true when the variables have
--   the values given
truthValue :: Proposition -> [(String,Bool)] -> Bool
truthValue (Var x) val = fromJust $ lookup x val
truthValue (a :&: b) val = truthValue a val && truthValue b val
truthValue (a :|: b) val = truthValue a val || truthValue b val
truthValue (Not a) val = not $ truthValue a val

allVals :: [String] -> [[(String,Bool)]]
allVals []     = [[]]
allVals (x:xs) = [ (x,b):val | val <- allVals xs, b <- [False,True] ]

-- | Returns true if the proposition holds for all values of the variables
--   appearing in it
tautology :: Proposition -> Bool
tautology a = and [ truthValue a val | val <- allVals (vars a) ]


-- 2.6 Type derivation
(.)(:) :: (a1 -> a) -> a1 -> [a] -> [a]

* Couldn't match expected type `[a]'
              with actual type `(b0 -> c0) -> (a0 -> b0) -> a0 -> c0'
* Probable cause: `(.)' is applied to too few arguments
  In the second argument of `(:)', namely `(.)'
  In the expression: (: (.))

((.):)
  :: [(b -> c) -> (a -> b) -> a -> c]
     -> [(b -> c) -> (a -> b) -> a -> c]

((:):) :: [a -> [a] -> [a]] -> [a -> [a] -> [a]]

(.)(.) :: (a1 -> b -> c) -> a1 -> (a -> b) -> a -> c

(8-) :: Num a => a -> a

(+0).(0+) :: Num c => c -> c

(($)$($)) :: (a -> b) -> a -> b

([]>>=)(\_->[(>=)]) :: Ord a => [a -> a -> Bool]
