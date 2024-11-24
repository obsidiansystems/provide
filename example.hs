import Data.Proxy
import Data.Vinyl

import Control.Provide
import Control.Provide.ARec

----------------------------------------------------------------------
-- Write a library that uses some implicit arguments
----------------------------------------------------------------------

data A
type instance ValueType _ A = Int

data B
type instance ValueType _ B = Bool

needsA
  :: p `Provides` A
  => Proxy p
  -> IO ()
needsA p = putStrLn $ "A is " <> show (providedP @A p)

needsB
  :: p `Provides` B
  => Proxy p
  -> IO ()
needsB p = putStrLn $ "B is " <> show (providedP @B p)

needsBoth
  :: ( p `Provides` A
     , p `Provides` B
     )
  => Proxy p
  -> IO ()
needsBoth p = do
  needsA p
  needsB p

----------------------------------------------------------------------
-- Invoke functions from the library using an application-specific
-- provider based on a `vinyl` record
----------------------------------------------------------------------

main :: IO ()
main = do
  let provider =
        ProviderField @_ @A 5 :&
        ProviderField @_ @B True :&
        RNil
  provideARec provider $ \p -> do
    needsA p
    needsB p
    needsBoth p
