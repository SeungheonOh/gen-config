{-# LANGUAGE GADTs #-}
module Formats.Formats where

class ConfigGenerator a where
  generate :: a -> String

data ConfigGenerator_ where
  ConfigGenerator_ :: (ConfigGenerator a) => a -> ConfigGenerator_

toConfigGenerator  :: (ConfigGenerator a) => a -> ConfigGenerator_
toConfigGenerator = ConfigGenerator_