/** #v(1fr) #outline() #v(1.2fr) #pagebreak()
= Quick Start
```typst
#import "@preview/textcase:0.1.0": contextual

// Sentence case text.
#contextual.sentence-case("sentence case text.")

// Sentence case title: Subtitle
#contextual.sentence-case-title("sentence case title: subtitle")

// Title Case: Subtitle
#contextual.title-case("title case: subtitle)
```

= Description

*This project is an unofficial implementation of the~#crate("textcase")
crate, and its developers have no affiliation with it.*

Multilingual sentence and title recasing for Latin-script languages.
This recases text whose capitalization is wrong or missing — lowercase
feeds, SHOUTED titles, Title Cased Prose — while preserving
capitalization that carries information. It works without any external
data.

This package aims to implement an API that closely mirrors the original
crate while adhering to Typst's coding standards. An additional
`#title-case` command is also provided for convenience.

= Sentence case
:sentence-case:
Transforms texts to conform to sentence capitalization rules.
**/
#let sentence-case(
  text, /// <- string
    /// Text to be transformed. |
  locale: "en", /// <- string
    /// Language for capitalization rules. |
    /// The `#contextual.sentence-case` command automatically retrieve the locale from `#text.lang`.
) = {
  if type(text) == content and text.func() == raw {text = text.text}
  
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


/**
= Sentence case title
:sentence-case-title:
Transforms title texts to conform to sentence capitalization rules, with automatic subtitle detection and capitalization.
**/
#let sentence-case-title(
  text, /// <- string
    /// Text to be trabsformed. |
  locale: "en", /// <- string
    /// Language for capitalization rules. |
    /// The `#contextual.sentence-case-title` command automatically retrieve the locale from `#text.lang`.
) = {
  if type(text) == content and text.func() == raw {text = text.text}
  
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


/**
= Convert text case
:convert:
Performs text case transformation with support for fine-tuning the process.
This command provides access to advanced text transformation options.
**/
#let convert(
  text, /// <- string
    /// Text to be transformed. |
  locale: "en", /// <- string
    /// Language for capitalization rules. |
  mode: "sentence", /// <- string
    /// Text conversion mode: #(`"sentence"`, `"sentence-title"`, `"title"`).map(underline).join(", "). |
  subtitle-separator-style: "preserve", /// <- string
    /// Subtitle separator conversion: #(`"preserve"`, `"colon-space"`, `"space-dash-space"`, `"em-dash-space"`).map(underline).join(", "). |
  capitalize-after-subtitle-separator: true, /// <- boolean
    /// Whether to capitalize subtitles. |
  preserve-acronyms: true, /// <- boolean
    /// Preserve upper case acronyms. |
  preserve-mixed-case: true,  /// <- boolean
    /// Preserve mixed case (lower and upper case) as is. |
  preserve-known-proper-nouns: true, /// <- boolean
    /// Transform proper nouns internally known by _textcase._ |
  preserve-existing-capitals: true, /// <-boolean
    /// Preserve capitalized mid-sentence words in sentence case. |
  normalize-whitespace: true, /// <- boolean
    /// Collapse additional whitespace characters. |
  german-mode: "conservative", /// <- boolean
    /// Special~#url("https://github.com/Pajn/textcase/blob/main/docs/german.md")[handling] for German language: #(`"conservative"`, `"balanced"`, `"aggressive"`).map(underline).join(", "). |
) = {
  /// The `#contextual.convert` command automatically retrieve the locale from `#text.lang`.
  if type(text) == content and text.func() == raw {text = text.text}
   
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


/**
= Title case
:title-case:
Transforms title texts to conform to title case capitalization rules, with automatic subtitle detection and capitalization.
This is an additional command provided for better semantics and convenience.
**/
#let title-case(
  text, /// <- string
    /// Text to be transformed. |
  locale: "en", /// <- string
    /// Language for capitalization rules. |
    /// The `#contextual.text-case` command automatically retrieve the locale from `#text.lang`.
) = convert(text, locale: locale, mode: "title")