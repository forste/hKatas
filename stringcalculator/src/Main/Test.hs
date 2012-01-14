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
import qualified Test.HUnit.Tools as HUnit.Tools
import Control.Monad
import qualified Main.Calculator as Calc
import Control.Exception (Exception, try)

-- general tests

tests :: IO [Test]
tests = do
        aTests <- mkAddTests
        return [aTests]

tester :: (Eq result, Show result) => (input -> String)
                                    -> (input -> result)
                                    -> (input, result)
                                    -> IO Test
tester fnPrefix fn (input, expected) = return $ TestCase $ assertEqual
                                            (fnPrefix input)
                                            expected
                                            $ fn input

exceptionTester :: (Exception e, Eq e) => (String -> String)
                                            -> (String -> Int)
                                            -> (String, e)
                                            -> IO Test
exceptionTester fnPrefix fn (input, expectedException) = return $ TestCase $ assertRaises
                                                            (fnPrefix input)
                                                            expectedException
                                                            fn
                                                            input

addTester :: (String,Int) -> IO Test
addTester = tester (\input -> "(add "++input++")") $ Calc.add

nNTester :: (String, Calc.NegativeNumberException) -> IO Test
nNTester = exceptionTester (\input -> "(add "++input++")") $ Calc.add

mkAddTests :: IO Test
mkAddTests = do
            addTs <-  mapM (\(input,expected) -> addTester (input, expected)) addTests
            nNTs <-   mapM (\(input,expected) -> nNTester (input, expected)) nNTests
            return $ TestList $ addTs ++ nNTs
            where



addTests :: [(String,Int)]
addTests = [("",0)
            ,("2",2)
            ,("2,5",7)
            ,("2,3,1,51,6,28,3,2",96)
            ,("45\n2,3\n1",51)
            ,("//;\n1\n2", 3) -- 5
            ,("//;\n1;2", 3)
            ,("1033",33)
            ,("999,22",21)
            ,("//[**]\n1**2**3",6)
            ,("//[}}}}]2}}}}5}}}}7",14) --10
            ]
nNTests :: [(String, Calc.NegativeNumberException)]
nNTests =  [("-2,5", Calc.NegativeNumberException [-2]) --11
           ,("-2,5,-3,-4", Calc.NegativeNumberException [-2,-3,-4])
           ,("45\n-2,3\n-1",Calc.NegativeNumberException [-2,-1])
           ]

--helper
assertRaises :: (Control.Exception.Exception e, Show e, Eq e) =>
                String -> e -> (String -> Int) -> String -> IO ()
assertRaises msg selector action input = do
           result <- calcAddIO input
           r <- try $ putStrLn $ show result
           case r of
                  Left e -> do
                    thetest e
                  Right out ->
                    assertFailure $ msg ++ "\nReceived '"++show out++"', but was expecting exception: " ++ (show selector)
     where
          calcAddIO input = return $ action input
          thetest e = if e == selector then return ()
                    else assertFailure $ msg ++ "\nReceived unexpected exception: "
                             ++ (show e) ++ "\ninstead of exception: " ++ (show selector)
