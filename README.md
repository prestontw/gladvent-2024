# gladvent_2024

[![Package Version](https://img.shields.io/hexpm/v/gladvent_2024)](https://hex.pm/packages/gladvent_2024)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gladvent_2024/)

```sh
gleam add gladvent_2024@1
```
```gleam
import gladvent_2024

pub fn main() {
  // TODO: An example of the project in use
}
```

Further documentation can be found at <https://hexdocs.pm/gladvent_2024>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```

## Improvements

Could be nice to use [`envoy`](https://hexdocs.pm/envoy/)
to detect whether we are running in CI or not, but 
that doesn't solve the problem that the data modules don't exist.
