{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveGeneric #-}
module Formats where

import Template

import Dhall

import SumTypes.TH
import Formats.Formats
import Formats.Vimrc
import Formats.Toml

$(genSumType "Config" $ getInstances ''ConfigGenerator) 
$(genTransform "transform" 'toConfigGenerator $ getConstructors ''Config)
deriving instance Generic Config
instance FromDhall Config

generateConfig :: Config -> String 
generateConfig c = runGenerator $ transform c
  where 
    runGenerator (ConfigGenerator_ c) = generate c