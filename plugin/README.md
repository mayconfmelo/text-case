# Rust Typst Plugin
```typst
#let wasm = plugin("plugin.wasm")

#let start = datetime(year: 2023, month: 5, day: 5)
#let end = datetime.today()

#cbor(
  wasm.date_difference(
    bytes(start.display("[year]-[month]-[day]")),
    bytes(end.display("[year]-[month]-[day]")),
  )
)
```

This is a Typst plugin written in Rust and compiled to WebAssembly.
It calculates the number of years, months, and days between two dates.

## Build

Using `just` from inside _nexus-tools_ project:
```bash
just plugin
```

Or manually:
```bash
rustup target add wasm32-unknown-unknown
cargo build --release --target wasm32-unknown-unknown
cp target/wasm32-unknown-unknown/release/plugin.wasm .
```