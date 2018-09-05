{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Stack.Types.PackageDump
    ( InstalledCache(..)
    , InstalledCacheInner(..)
    , InstalledCacheEntry(..)
    , installedCacheVC
    ) where

import Data.Store
import Data.Store.Version
import Stack.Prelude
import Stack.Types.GhcPkgId

-- | Cached information on whether package have profiling libraries and haddocks.
newtype InstalledCache = InstalledCache (IORef InstalledCacheInner)
newtype InstalledCacheInner = InstalledCacheInner (Map GhcPkgId InstalledCacheEntry)
    deriving (Store, Generic, Eq, Show, Data, Typeable)

-- | Cached information on whether a package has profiling libraries and haddocks.
data InstalledCacheEntry = InstalledCacheEntry
    { installedCacheProfiling :: !Bool
    , installedCacheHaddock :: !Bool
    , installedCacheSymbols :: !Bool
    , installedCacheIdent :: !PackageIdentifier }
    deriving (Eq, Generic, Show, Data, Typeable)
instance Store InstalledCacheEntry

installedCacheVC :: VersionConfig InstalledCacheInner
installedCacheVC = storeVersionConfig "installed-v2" "eHLVmgbOWvPSm1X3wLfclM-XiXc="
