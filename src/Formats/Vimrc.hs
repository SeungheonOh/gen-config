{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveGeneric #-}
module Formats.Vimrc where

import qualified Data.HashMap.Lazy as HM
import Data.Text
import qualified Data.List as L
import Dhall

import Formats.Formats

data Vimrc = Vimrc
  { set :: HM.HashMap Text Text
  , binding :: HM.HashMap Text (HM.HashMap Text Text)
  , raw :: Text
  } deriving (Generic, Show)
instance FromDhall Vimrc

genSet :: HM.HashMap Text Text -> String
genSet m = L.intercalate "\n" $ mkSet <$> HM.toList m
  where
    mkSet :: (Text,Text) -> String
    mkSet (k, v) = "set " ++ unpack k ++ if v == "" then "" else "="++unpack v

getBind :: HM.HashMap Text (HM.HashMap Text Text) -> String
getBind m = L.intercalate "\n" $ mkSubBind <$> HM.toList m
  where
    mkSubBind :: (Text, HM.HashMap Text Text) -> String
    mkSubBind (t, bt) = L.intercalate "\n" $ mkBind (unpack t) <$> HM.toList bt
    mkBind :: String -> (Text, Text) -> String
    mkBind t (b1, b2) = t ++ " " ++ unpack b1 ++ " " ++ unpack b2

instance ConfigGenerator Vimrc where
  generate Vimrc {..} = L.intercalate "\n" [genSet set, getBind binding, unpack raw]
