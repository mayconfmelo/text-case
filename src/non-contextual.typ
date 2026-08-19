
/* =========================================================================
 * sentence-case
 * ========================================================================= */

/// Convert a string to sentence case.
///
/// #example
///
/// ```typst
/// #sentence-case(
///   "hello WORLD. this is a TEST.",
/// )
/// ```
///
/// ```text
/// Hello WORLD. This is a TEST.
/// ```
#let sentence-case(
  text,
  locale: "en",
) = {
  assert(type(text) == str, message: "textcase: `text` must be a string")
  assert(type(locale) == str, message: "textcase: `locale` must be a string")
  
  let wasm = plugin("plugin.wasm")
  
  return cbor(
    wasm.sentence_case(
      cbor.encode((
        text: text,
        locale: locale,
      ))
    )
  )
}


/* =========================================================================
 * sentence-case-title
 * ========================================================================= */

/// Convert a string to sentence-title case.
///
/// #example
///
/// ```typst
/// #sentence-case-title(
///   "the album - remastered",
/// )
/// ```
///
/// ```text
/// The album - Remastered
/// ```
#let sentence-case-title(
  text,
  locale: "en",
) = {
  assert(type(text) == str, message: "textcase: `text` must be a string")
  assert(type(locale) == str, message: "textcase: `locale` must be a string")

  let wasm = plugin("plugin.wasm")
  
  return cbor(
    wasm.sentence_case_title(
      cbor.encode((
        text: text,
        locale: locale,
      ))
    )
  )
}


/* =========================================================================
 * convert
 * ========================================================================= */

/// General text case conversion.
///
/// Supported modes:
///
/// - `"sentence"`
/// - `"sentence-title"`
/// - `"title"`
///
/// Supported subtitle separator styles:
///
/// - `"preserve"`
/// - `"colon-space"`
/// - `"dash-space"`
/// - `"em-dash-space"`
#let convert(
  text,
  locale: "en",
  mode: "sentence",
  subtitle-separator-style: "preserve",
  capitalize-after-subtitle-separator: true,
  preserve-acronyms: true,
  preserve-mixed-case: true,
  preserve-known-proper-nouns: true,
  preserve-existing-capitals: true,
  normalize-whitespace: true,
  german-mode: "conservative",
) = {
  assert(type(text) == str, message: "textcase: `text` must be a string")
  assert(type(locale) == str, message: "textcase: `locale` must be a string")
  assert(type(mode) == str, message: "textcase: `mode` must be a string")
  assert(type(subtitle-separator-style) == str, message: "textcase: `subtitle-separator-style` must be a string")
  assert(type(capitalize-after-subtitle-separator) == bool, message: "textcase: `capitalize-after-subtitle-separator` must be boolean")
  assert(type(preserve-acronyms) == bool, message: "textcase: `preserve-acronyms` must be boolean")
  assert(type(preserve-mixed-case) == bool, message: "textcase: `preserve-mixed-case` must be boolean")
  assert(type(preserve-known-proper-nouns) == bool, message: "textcase: `preserve-known-proper-nouns` must be boolean")
  assert(type(preserve-existing-capitals) == bool, message: "textcase: `preserve-existing-capitals` must be boolean")
  assert(type(normalize-whitespace) == bool, message: "textcase: `normalize-whitespace` must be boolean")
  assert(type(german-mode) == str, message: "textcase: `german-mode` must be a string")

  let wasm = plugin("plugin.wasm")
  
  return cbor(
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
}


#let title-case(
  text,
  locale: "en",
) = convert(text, locale: locale, mode: "title")