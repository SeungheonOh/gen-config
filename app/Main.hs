{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import System.IO ( openFile, hGetContents, IOMode(ReadMode) )
import qualified Data.ByteString.Lazy.UTF8 as BLU
import Data.Maybe
import Control.Exception

import qualified Data.HashMap.Lazy as HM
import qualified Data.Text as T

import Dhall

import Formats

main :: IO ()
main = do
  (try (input auto "./test/test.dhall") :: IO (Either SomeException [Config]))
    >>= \case
      Left ex -> putStrLn $ "failed" ++ show ex
      Right o -> mapM_ putStrLn $ generateConfig <$> o
