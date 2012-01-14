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

defaultDelims = [",","\n"]

parse :: String -> [String] -> [Int]
parse ('/':'/':'[':xs) delims = parse'
                                    (snd $ take' xs)
                                    $ delims ++ [(fst $ take' xs)]
parse ('/':'/':delimiter:xs) delims = parse' xs $ [delimiter]:delims
parse x d =  parse' x d
    where


take' :: String -> (String,String)
take' (']':xs) = ("",xs)
take' (x:xs)   = (delim, rest)
    where
        rest     = snd take''
        delim    = x:(fst take'')
        take'' = take' xs


parse' :: String -> [String] -> [Int]
parse' x delims = map (\str -> read str)
                    $ filter (\num -> not $ num == "")
                    $ splitOn' x delims

splitOn' :: String -> [String] -> [String]
splitOn' x (del:delims) = concat $ map (\s -> splitOn del s) $ splitOn' x delims
splitOn' x []          = [x]
