-----------------------------------------------------------------------------
--
-- Module      :  Main
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

module Main (
    main
) where

import qualified Main.Test as Test
import qualified Main.Calculator as Calc
import Test.HUnit
import Control.Monad

main = do
   forM Test.tests $ \test -> runTestTT test

--main = putStrLn $ show $ Calc.add "\n1\n2"
