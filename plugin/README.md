# Rust Typst Plugin
```typst
#let wasm = plugin("plugin.wasm")

#cbor(
  wasm.sentence_case(
    cbor.encode((
      text: "text",
      locale: "en",
    ))
  )
)

#cbor(
  wasm.sentence_case_title(
    cbor.encode((
      text: text,
      locale: locale,
    ))
  )
)

#cbor(
  wasm.convert(
    cbor.encode((
      text: text,
      locale: locale,
      mode: mode,
      subtitle_separator_style: subtitle-separator-style,
      capitalize_after_subtitle_separator: capitalize-after-subtitle-separator,
      preserve_acronyms: preserve-acronyms,
      preserve_mixed_case: preserve-mixed-case,
      preserve_known_proper_nouns: preserve-known-proper-nouns,
      preserve_existing_capitals: preserve-existing-capitals,
      normalize_whitespace: normalize-whitespace,
      german_mode: german-mode,
    ))
  )
)
```

This is a Typst plugin written in Rust and compiled to WebAssembly.
It allows typst to access the features of the [*textcase*](https://crates.io/crates/textcase)
Rust crate.

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

------

This code was generated with the help of AI.