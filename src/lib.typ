/** #v(1fr) #outline() #v(1.2fr) #pagebreak()
= Quick Start
```typ
#import "@preview/textcase:0.1.0": convert
#convert()
```

= Description

= Options
:convert:
**/






#let _plugin = plugin("plugin.wasm")


/// Convert text to sentence case.
///
/// ```
/// #sentence-case("hello WORLD. this is a TEST.")
/// ```
///
/// Returns:
/// `Hello WORLD. This is a TEST.`
#let sentence-case(
  text,
  locale: "en",
) = {
  assert(
    type(text) == str,
    message: "textcase: `text` must be a string",
  )

  assert(
    type(locale) == str,
    message: "textcase: `locale` must be a string",
  )

  str(
    _plugin.sentence_case(
      bytes(text),
      bytes(locale),
    ),
  )
}


/// Convert text to sentence-title case.
///
/// ```
/// #sentence-case-title(
///   "the album - remastered",
/// )
/// ```
///
/// Returns:
/// `The album - Remastered`
#let sentence-case-title(
  text,
  locale: "en",
) = {
  assert(
    type(text) == str,
    message: "textcase: `text` must be a string",
  )

  assert(
    type(locale) == str,
    message: "textcase: `locale` must be a string",
  )

  str(
    _plugin.sentence_case_title(
      bytes(text),
      bytes(locale),
    ),
  )
}


/// General textcase conversion.
///
/// `mode` can be:
///
/// - `"sentence"`
/// - `"sentence-title"`
/// - `"title"`
///
/// `subtitle-separator-style` can be:
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
) = {
  assert(
    type(text) == str,
    message: "textcase: `text` must be a string",
  )

  assert(
    type(locale) == str,
    message: "textcase: `locale` must be a string",
  )

  assert(
    type(mode) == str,
    message: "textcase: `mode` must be a string",
  )

  assert(
    type(subtitle-separator-style) == str,
    message: "textcase: `subtitle-separator-style` \
must be a string",
  )

  assert(
    type(capitalize-after-subtitle-separator) == bool,
    message: "textcase: `capitalize-after-subtitle-separator` \
must be boolean",
  )

  assert(
    type(preserve-acronyms) == bool,
    message: "textcase: `preserve-acronyms` \
must be boolean",
  )

  assert(
    type(preserve-mixed-case) == bool,
    message: "textcase: `preserve-mixed-case` \
must be boolean",
  )

  assert(
    type(preserve-known-proper-nouns) == bool,
    message: "textcase: `preserve-known-proper-nouns` \
must be boolean",
  )

  assert(
    type(preserve-existing-capitals) == bool,
    message: "textcase: `preserve-existing-capitals` \
must be boolean",
  )

  assert(
    type(normalize-whitespace) == bool,
    message: "textcase: `normalize-whitespace` \
must be boolean",
  )

  str(
    _plugin.convert(
      bytes(text),
      bytes(locale),
      bytes(mode),
      bytes(subtitle-separator-style),
      bytes(repr(capitalize-after-subtitle-separator)),
      bytes(repr(preserve-acronyms)),
      bytes(repr(preserve-mixed-case)),
      bytes(repr(preserve-known-proper-nouns)),
      bytes(repr(preserve-existing-capitals)),
      bytes(repr(normalize-whitespace)),
    ),
  )
}
