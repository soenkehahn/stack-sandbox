{-# LANGUAGE CPP #-}
module Tinc.GhcPkgSpec (spec) where

import           Helper

import           Tinc.GhcPkg
import           Tinc.Install
import           Package

spec :: Spec
spec = do
  describe "listPackages" $ beforeAll_ ensureCache $ do
    it "lists packages from specified package database" $ do
      packageDB <- findPackageDB getoptGenericsSandbox
      packages <- listPackages [packageDB]
      packages `shouldMatchList` getoptGenericsPackages

    it "accepts multiple package databases" $ do
      packageDBs <- mapM findPackageDB [getoptGenericsSandbox, setenvSandbox]
      packages <- listPackages packageDBs
      packages `shouldMatchList` (setenv : getoptGenericsPackages)

  describe "listGlobalPackages" $ do
    it "lists packages from global package database" $ do
      packages <- listGlobalPackages
      map packageName packages `shouldMatchList` [
          "array"
        , "base"
        , "binary"
        , "bin-package-db"
        , "bytestring"
        , "Cabal"
        , "containers"
        , "deepseq"
        , "directory"
        , "filepath"
        , "ghc"
        , "ghc-prim"
        , "hoopl"
        , "hpc"
        , "integer-gmp"
        , "pretty"
        , "process"
        , "rts"
        , "template-haskell"
        , "time"
        , "unix"
        , "haskeline"
        , "terminfo"
        , "transformers"
        , "xhtml"
#if __GLASGOW_HASKELL__ < 710
        , "haskell2010"
        , "haskell98"
        , "old-locale"
        , "old-time"
#endif
        ]
