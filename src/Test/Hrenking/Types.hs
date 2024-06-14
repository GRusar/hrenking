{-# LANGUAGE ScopedTypeVariables #-}
module Test.Hrenking.Types  where

import Data.Ord (compare)
import Data.Map (Map)


import Prelude ((==), (++), (<>), Either, Eq, IO, Ord, Show, String, show)

-- | Log = [String]
type Log = [String]
data TestResult = Passed | Skipped String | Failed | Pending deriving (Eq, Show)
type TestResults =  Map FeatureName (Feature,TestResult,Log)

type Error = String
class Hrenkenable a where
  takeUnit :: a -> a

type Unit = String



data Feature  = Feature {fName :: FeatureName, fDescr :: Description, fDeps :: DepsList, fContexts :: [Context]}
type FeatureName = String
type Description = String
type DepsList = [String]

data Context  = Context   String [Scenario] | Background [Step]
data Scenario = Scenario  String [Step] | Before [Step]
data Step     = Given     String (Unit -> IO (Either Error Unit))
              | When      String (Unit -> IO (Either Error Unit))
              | When_     String (Unit -> IO (Either Error ()))
              | Then      String (Unit -> IO ())

instance Show Feature where
  show f = "Feature: " ++ f.fName ++ " With deps: " <> show f.fDeps

instance Show Step where
  show _ = show "someStep"
instance Eq Feature where
  f == f2 = f.fName == f2.fName

instance Ord Feature where
  f1 `compare` f2 = f1.fName `compare` f2.fName