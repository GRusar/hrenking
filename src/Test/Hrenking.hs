module Test.Hrenking where


import Control.Monad
import Control.Monad.State

import Test.Hrenking.Types

runStep :: Step a -> StateT a IO (Log, TestResult)
runStep (Given description action) = do
  let stepLog = [description]
  get >>=  (lift . action >=> \case
    Right s -> do
      put s
      return (stepLog, Passed)
    Left _ -> error "Error")

runStep _ = undefined
