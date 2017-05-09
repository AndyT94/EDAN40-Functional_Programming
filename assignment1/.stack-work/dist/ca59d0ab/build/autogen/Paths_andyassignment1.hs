{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_andyassignment1 (
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

bindir     = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\.stack-work\\install\\63bf7b30\\bin"
libdir     = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\.stack-work\\install\\63bf7b30\\lib\\x86_64-windows-ghc-8.0.2\\andyassignment1-0.1.0.0-KEs0Ng7CFVRAYpqFMpnDcj"
dynlibdir  = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\.stack-work\\install\\63bf7b30\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\.stack-work\\install\\63bf7b30\\share\\x86_64-windows-ghc-8.0.2\\andyassignment1-0.1.0.0"
libexecdir = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\.stack-work\\install\\63bf7b30\\libexec"
sysconfdir = "C:\\Users\\Andy\\Desktop\\EDAN40-FunctionalProgramming\\.stack-work\\install\\63bf7b30\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "andyassignment1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "andyassignment1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "andyassignment1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "andyassignment1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "andyassignment1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "andyassignment1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
