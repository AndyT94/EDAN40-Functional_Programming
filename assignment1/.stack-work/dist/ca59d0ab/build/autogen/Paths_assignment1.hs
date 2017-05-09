{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_assignment1 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\assignment1\\.stack-work\\install\\63bf7b30\\bin"
libdir     = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\assignment1\\.stack-work\\install\\63bf7b30\\lib\\x86_64-windows-ghc-8.0.2\\assignment1-0.1.0.0-2RzjC4JpVbO6M4vQTQJu9q"
dynlibdir  = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\assignment1\\.stack-work\\install\\63bf7b30\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\assignment1\\.stack-work\\install\\63bf7b30\\share\\x86_64-windows-ghc-8.0.2\\assignment1-0.1.0.0"
libexecdir = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\assignment1\\.stack-work\\install\\63bf7b30\\libexec"
sysconfdir = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\assignment1\\.stack-work\\install\\63bf7b30\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "assignment1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "assignment1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "assignment1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "assignment1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "assignment1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "assignment1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
