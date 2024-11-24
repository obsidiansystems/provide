module Control.Provide where

import Data.Proxy
import Data.Kind (Type)

-- | The "type context" of a provider.  Think of this as an open record of
-- types, whose members can influence the types of values in the provider.
type family ProviderTypeContext provider

type family ValueType (t :: Type) (a :: Type) :: Type

-- | A class indicating that the given provider type provides a value for a
-- given key.  The key is typically an empty datatype declared inside the
-- library which receives values using this key.
class provider `Provides` key where
  provided :: ValueType (ProviderTypeContext provider) key
infix 4 `Provides`

providedP :: forall key provider. provider `Provides` key => Proxy provider -> ValueType (ProviderTypeContext provider) key
providedP _ = provided @provider @key
