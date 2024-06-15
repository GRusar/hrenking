{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}

module Test.Hrenking.Types  where

import Data.Ord (compare)
import Data.Map (Map)

import Prelude ((==), (++), (<>), Either, Eq, IO, Ord, Show, String, show)

-- | Log = [String]
type Log = [String]
data TestResult = Passed | Skipped String | Failed | Pending deriving (Eq, Show)
type TestResults a =  Map FeatureName (Feature a, TestResult, Log)

type Error = String
class Hrenkenable a where
  takeUnit :: a -> a

data Feature a
  = Feature {fName :: FeatureName, fDescr :: Description, fDeps :: DepsList, fContexts :: [Context a]}

type FeatureName = String
type Description = String
type DepsList = [String]

data Context a  = Context   String [Scenario a] | Background [Step a]
data Scenario a = Scenario  String [Step a] | Before [Step a]
data Step a     = Given     String (a -> IO (Either Error a))
                | When      String (a -> IO (Either Error a))
                | When_     String (a -> IO (Either Error ()))
                | Then      String (a -> IO ())

deriving anyclass instance Eq (Feature a)
deriving anyclass instance Ord (Feature a)
deriving anyclass instance Show (Feature a)
