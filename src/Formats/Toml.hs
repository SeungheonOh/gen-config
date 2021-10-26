{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveGeneric #-}
module Formats.Toml where

import qualified Data.HashMap.Lazy as HM
import Data.Text
import Dhall
import Formats.Formats

data Toml = Toml
  { a :: Text
  , b :: Text
  } deriving (Generic, Show)
instance FromDhall Toml
instance ConfigGenerator Toml where
  generate Toml {..} = "hello toml!"