module Test.HrenkingSpec (spec) where

import Test.Hspec

import Control.Monad.State

import Test.Hrenking
import Test.Hrenking.Types

spec :: Spec
spec = do
  describe "runStep" $ do
    context "Int state" $ do
      it "return new state of Int type" $ do
        let step = Given "" $ return . return . (1 +)
        execStateT (runStep step) (1 :: Integer) `shouldReturn` (2 :: Integer)

    context "String state" $ do
      it "return new state of String type" $ do
        let step = Given "" $ return . return . (<> " world")
        execStateT (runStep step) "hello" `shouldReturn` "hello world" 
