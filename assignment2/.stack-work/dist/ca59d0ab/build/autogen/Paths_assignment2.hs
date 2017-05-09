{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_assignment2 (
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

bindir     = "C:\\Users\\Andy\\Desktop\\EDAN40-P\\andy\\assignment2\\.stack-work\\install\\9320a514\\bin"
libdir     = "C:\\Users\\Andy\\Desktop\\EDAN40-P\\andy\\assignment2\\.stack-work\\install\\9320a514\\lib\\x86_64-windows-ghc-8.0.2\\assignment2-0.1.0.0-E3zHz19BlhKIYINWrcSGO6"
dynlibdir  = "C:\\Users\\Andy\\Desktop\\EDAN40-P\\andy\\assignment2\\.stack-work\\install\\9320a514\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Andy\\Desktop\\EDAN40-P\\andy\\assignment2\\.stack-work\\install\\9320a514\\share\\x86_64-windows-ghc-8.0.2\\assignment2-0.1.0.0"
libexecdir = "C:\\Users\\Andy\\Desktop\\EDAN40-P\\andy\\assignment2\\.stack-work\\install\\9320a514\\libexec"
sysconfdir = "C:\\Users\\Andy\\Desktop\\EDAN40-P\\andy\\assignment2\\.stack-work\\install\\9320a514\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "assignment2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "assignment2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "assignment2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "assignment2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "assignment2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "assignment2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
