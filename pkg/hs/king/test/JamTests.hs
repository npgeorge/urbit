module JamTests (tests) where

import Ur.Arvo.Event
import Ur.Noun.Conversions
import Ur.Noun.Cue
import Ur.Noun.Jam
import Ur.Prelude

import GHC.Natural            (Natural(..))
import Test.QuickCheck        hiding ((.&.))
import Test.QuickCheck.Gen
import Test.QuickCheck.Random
import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.TH

instance Arbitrary Natural where
  arbitrary = arbitrarySizedNatural

prop_cueJamAtom :: Atom -> Bool
prop_cueJamAtom a = Right (Atom a) == cue (jam (Atom a))

prop_cueJamNoun :: Noun -> Bool
prop_cueJamNoun n = Right n == cue (jam n)

tests :: TestTree
tests = $(testGroupGenerator)

