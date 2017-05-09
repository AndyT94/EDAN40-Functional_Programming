module Main where

import Lib
import Control.Monad
import System.IO
import Control.Applicative

main :: IO ()
main = forever $ do
    hSetBuffering stdout NoBuffering
    putStr "First string: "
    s <- getLine
    putStr "Second string: "
    t <- getLine
    putStr ("Score is: " ++ show (similarityScore' s t) ++ "\nAlignments:\n")
    outputOptAlignments s t
    putStr "\n***************************\n"
