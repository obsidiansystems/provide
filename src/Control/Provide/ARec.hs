module Control.Provide.ARec where

import Control.Lens
import Data.Reflection
import Data.Proxy
import Data.Vinyl hiding (Dict)
import Data.Vinyl.ARec
import Data.Vinyl.TypeLevel
import Data.Kind (Type)

import Control.Provide

data ARecProvider tctx recVal
type instance ProviderTypeContext (ARecProvider tctx recVal) = tctx

newtype ProviderField tctx (key :: Type) = ProviderField { unProviderField :: ValueType tctx key }

instance (Reifies recVal (ARec (ProviderField tctx) items), RecElem ARec key key items items (RIndex key items)) => ARecProvider tctx recVal `Provides` key where
  provided = unProviderField $ reflect (Proxy @recVal) ^. rlens @key

provideARec
  :: forall tctx items r
  .  ( NatToInt (RLength items)
     , ToARec items
     )
  => Rec (ProviderField tctx) items
  -> (forall (recVal :: Type). Reifies recVal (ARec (ProviderField tctx) items) => Proxy (ARecProvider tctx recVal) -> r)
  -> r
provideARec items r = reify (toARec items) $ \(Proxy :: Proxy recVal) -> r (Proxy @(ARecProvider tctx recVal))
