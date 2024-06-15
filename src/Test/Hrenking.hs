module Test.Hrenking where

import Control.Monad.State

import Test.Hrenking.Types

runStep :: Step a -> StateT (a, Log, TestResult) IO ()
runStep (Given _ action) = do
  (state, log, result) <- get
  result <- lift $ action state
  case result of
    Right s -> put (s, log, Passed)
    Left  e -> error "Error"
