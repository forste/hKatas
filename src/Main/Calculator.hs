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
add input = sum $ parse input defaultDelims

defaultDelims = [',','\n']

parse :: String -> [Char] -> [Int]
parse ('/':'/':delimiter:xs) delims = parse' xs $ delimiter:delims
parse x d =  parse' x d


parse' x delims = map (\str -> read str)
                    $ filter (\num -> not $ num == "")
                    $ splitWhen (\c -> isDelim c delims) x
            where
                isDelim c list = or $ map (\delim -> delim == c) list

