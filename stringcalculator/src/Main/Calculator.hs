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
{-# LANGUAGE DeriveDataTypeable #-}
module Main.Calculator (
    add

    ,NegativeNumberException (..)
) where

import Data.List.Split
import Data.Typeable (Typeable)
import Control.Exception (throw, Exception)

data NegativeNumberException
    = NegativeNumberException [Int]
    deriving (Show, Typeable, Eq)

instance Exception NegativeNumberException



add :: String -> Int
add "" = 0
add input = case negative of
                [] -> mod (sum parsed) 1000
                _ -> throw $ NegativeNumberException negative
                where
                negative = filter (\n -> n < 0) parsed
                parsed = parse input defaultDelims

defaultDelims = [',','\n']

parse :: String -> [Char] -> [Int]
parse ('/':'/':delimiter:xs) delims = parse' xs $ delimiter:delims
parse x d =  parse' x d


parse' x delims = map (\str -> read str)
                    $ filter (\num -> not $ num == "")
                    $ splitWhen (\c -> isDelim c delims) x
            where
                isDelim c list = or $ map (\delim -> delim == c) list

