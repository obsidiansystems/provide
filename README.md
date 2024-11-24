# provide

Lightweight dependency injection / namespaced+typed implicit-ish arguments

## Description

In many applications, there are arguments that need to be passed deeply into call hierarchies, which can be annoying.  Implicit arguments are one potential solution to this, but they have a few issues.  Firstly, their names are based on strings, which can be noncomposable e.g. in the case that multiple libraries choose the same name.  Secondly, the type of an implicit argument can be freely chosen wherever it is used, which is more flexibility than most libraries want.  Thirdly, the semantics of implicit variables is somewhat strange with respect to let bindings, etc.

This library instead supports associating an unlimited number of values with a context type.  Although this context type does need to be passed down somehow into the child functions, it's only one argument, not many, and it can be passed as a type or as a Proxy value.  The keys of the context are types, which libraries can provide to designate the context arguments they want.

## Features

- **Namespacing**: No name collisions, e.g. when multiple libraries create implicit arguments with the same name.
- **Specified Types**: Types are specified when the name is created, and don't need to be specified elsewhere.
- **Implicit Argument Management**: Although one (type- or value-) argument is required, many values can be implicitly passed down via it, automatically passing each function (only) what it needs.

## Installation

Add `provide` to your project's dependencies.

## Usage

See [example.hs](example.hs).

## Important Note on `Ord`

The `Ord` instance is based on hash values, not actual values. This improves performance but may result in incorrect ordering if hash collisions occur. The `Eq` instance uses actual values for comparison.

## Testing

Run the test suite using:

```bash
cabal test
```

## License

This project is licensed under the BSD-3-Clause License.

## Author

Ryan Trinkle - [ryan@trinkle.org](mailto:ryan@trinkle.org)
