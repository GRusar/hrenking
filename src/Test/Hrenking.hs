module Test.Hrenking where

import Control.Monad.State

import Test.Hrenking.Types

runStep :: Step a -> StateT a IO (Log, TestResult)
runStep (Given _ action) = do
  state <- get
  resultEither <- lift $ action state
  case resultEither of
    Right s -> do
      put s
      return ([], Passed)
    Left  e -> error "Error"
