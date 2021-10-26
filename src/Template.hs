{-# Language TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Template where

import SumTypes.TH
import Language.Haskell.TH
import Language.Haskell.TH.Syntax
import Control.Monad
  
-- get a list of instances
getInstances :: Name -> Q [Name]
getInstances typ = do
  inst <- reify typ 
  return $ t . a <$> c inst
  where
    c (ClassI _ inst) = inst
    a (InstanceD _ _ app _) = app
    t (AppT _ (ConT tg)) = tg

getConstructors :: Name -> Q[Name]
getConstructors typ = do
  inst <- reify typ
  return $ cn <$> c inst 
  where
    c (TyConI (DataD _ _ _ _ cons _)) = cons
    cn (NormalC n _) = n

transformT :: Name -> Name -> Q Clause 
transformT targ cname = do
  x <- newName "x"
  return $ Clause 
    [ConP cname [VarP x]] 
    (NormalB (AppE (VarE targ) (VarE x))) 
    []

genTransform :: String -> Name -> Q [Name] -> Q [Dec]
genTransform name targ types = do
  ts <- types
  cs <- forM ts $ transformT targ
  return [FunD (mkName name) cs]

genSumType :: String -> Q [Name] -> Q [Dec]
genSumType s n = n >>= constructSumType s defaultSumTypeOptions

showInstances :: Name -> Q Exp
showInstances typ = do
  ins <- getConstructors typ
  return . LitE . stringL $ show ins