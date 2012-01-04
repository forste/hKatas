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

tester :: (Eq result, Show result) => (input -> String) -> (input -> result) -> (input, result) -> Test
tester fnPrefix fn (input, expected) = TestCase $ assertEqual
                                            (fnPrefix input)
                                            expected
                                            $ fn input

addTester :: (String,Int) -> Test
addTester = tester (\input -> "(add "++input++")") $ Calc.add

--tester :: String -> a -> a -> Assertion
--tester prefix expected actual = assertEqual prefix expected actual
--
--
--addTester = tester  Calc.add mbNum1 mbNum2
--
--
--addTests = addTester 1 2

addTests :: [(String,Int)]
addTests = [("",0), ("2",2), ("-5",-5),("2,5",7),("-2,5",3),("-5,2",-3),("2,-5",-3),("5,-2",3),("-2,-5",-7)]

mkAddTests :: Test
mkAddTests = TestList $ map (\(input,expected) -> addTester (input, expected)) addTests

tests :: [Test]
tests = [mkAddTests]
