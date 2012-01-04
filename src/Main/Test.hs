-----------------------------------------------------------------------------
--
-- Module      :  Main.Test
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

module Main.Test (
    tests
) where

import Test.HUnit
import Control.Monad
import qualified Main.Calculator as Calc

-- general tests

tests :: [Test]
tests = [mkAddTests]

tester :: (Eq result, Show result) => (input -> String) -> (input -> result) -> (input, result) -> Test
tester fnPrefix fn (input, expected) = TestCase $ assertEqual
                                            (fnPrefix input)
                                            expected
                                            $ fn input

-- add tests

addTester :: (String,Int) -> Test
addTester = tester (\input -> "(add "++input++")") $ Calc.add

mkAddTests :: Test
mkAddTests = TestList $ map (\(input,expected) -> addTester (input, expected)) addTests

addTests :: [(String,Int)]
addTests = [("",0), ("2",2)
            ,("-5",-5),("2,5",7),("-2,5",3),("-5,2",-3),("2,-5",-3),("5,-2",3),("-2,-5",-7)
            ,("-45,2,3,1,51,6,28,3,2",51),("-35,2,3,1,5,346,-28,3,3,1,5,-62,8,34444, -555",34141)
            ]



