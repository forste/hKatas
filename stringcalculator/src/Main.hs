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
import Test.HUnit.Tools
import Control.Monad

main = do
   tests <- Test.tests
   forM tests $ \test -> runVerboseTests test

--main = putStrLn $ show $ Calc.add "\n-2"
