module Test.HrenkingSpec (spec) where

import Test.Hspec

import Control.Monad 
import Control.Monad.State

import Test.Hrenking
import Test.Hrenking.Types

spec :: Spec
spec = do
  describe "runStep" $ do
    context "Int state" $ do
      it "return new state of Int type" $ do
        let step = Given "" $ return >=> return (+ 1)
        execStateT (runStep step) 1 `shouldReturn` 2 

    context "String state" $ do
      it "return new state of String type" $ do
        let step = Given "" (\s -> return (Right $ s <> " world"))
        execStateT (runStep step) "hello" `shouldReturn` "hello world" 
