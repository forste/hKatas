-----------------------------------------------------------------------------
--
-- Module      :  Main.Calculator
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Main.Calculator (
    add
) where

import Data.List.Split

add :: String -> Int
add "" = 0
add input = sum $ parse input

parse :: String -> [Int]
parse x =  map (\str -> read str) $ splitWhen (\c -> c == ',') x
