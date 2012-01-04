module Paths_stringcalculator (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/forste/.cabal/bin"
libdir     = "/home/forste/.cabal/lib/stringcalculator-0.0.1/ghc-7.0.3"
datadir    = "/home/forste/.cabal/share/stringcalculator-0.0.1"
libexecdir = "/home/forste/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "stringcalculator_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "stringcalculator_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "stringcalculator_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "stringcalculator_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
