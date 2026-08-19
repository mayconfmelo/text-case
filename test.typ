#import "src/lib.typ": *

/* =========================================================================
 * sentence-case
 * ========================================================================= */

#assert(
  sentence-case(
    "hello world. this is a test.",
  )
  == "Hello world. This is a test."
)


#assert(
  sentence-case(
    "yesterday Alice met Bob in Paris. we had fun",
  )
  == "Yesterday Alice met Bob in Paris. We had fun"
)


#assert(
  sentence-case(
    "the NASA probe landed.",
  )
  == "The NASA probe landed."
)


/* =========================================================================
 * sentence-case-title
 * ========================================================================= */

#assert(
  sentence-case-title(
    "the album - remastered",
  )
  == "The album - Remastered"
)


#assert(
  sentence-case-title(
    "the rise of github - inside rust tooling",
  )
  == "The rise of GitHub - Inside rust tooling"
)


/* =========================================================================
 * convert / sentence
 * ========================================================================= */

#assert(
  convert(
    "hello WORLD. this is a TEST.",
    mode: "sentence",
  )
  == "Hello WORLD. This is a TEST."
)


/* =========================================================================
 * convert / sentence-title
 * ========================================================================= */

#assert(
  convert(
    "the rise of github - inside rust tooling",
    mode: "sentence-title",
  )
  == "The rise of GitHub - Inside rust tooling"
)


/* =========================================================================
 * convert / title
 * ========================================================================= */

#assert(
  convert(
    "the lord of the rings",
    mode: "title",
  )
  == "The Lord of the Rings"
)


/* =========================================================================
 * subtitle separator
 * ========================================================================= */

#assert(
  convert(
    "the rise of github - inside rust tooling",
    mode: "sentence-title",
    subtitle-separator-style: "colon-space",
  )
  == "The rise of GitHub: Inside rust tooling"
)


#assert(
  convert(
    "the rise of github: inside rust tooling",
    mode: "sentence-title",
    subtitle-separator-style: "space-dash-space",
  )
  == "The rise of GitHub - Inside rust tooling"
)


#assert(
  convert(
    "the rise of github: inside rust tooling",
    mode: "sentence-title",
    subtitle-separator-style: "em-dash-space",
  )
  == "The rise of GitHub — Inside rust tooling"
)


/* =========================================================================
 * preserve acronyms
 * ========================================================================= */

#assert(
  convert(
    "the NASA probe landed",
    preserve-acronyms: true,
  )
  == "The NASA probe landed"
)


/* =========================================================================
 * mixed case
 * ========================================================================= */

#assert(
  convert(
    "the iPhone uses LaTeX",
    preserve-mixed-case: true,
  )
  == "The iPhone uses LaTeX"
)


/* =========================================================================
 * Portuguese
 * ========================================================================= */

#assert(
  sentence-case(
    "este é um teste. outro teste.",
    locale: "pt",
  )
  == "Este é um teste. Outro teste."
)


/* =========================================================================
 * German
 * ========================================================================= */

#assert(
  convert(
    "ich mag die wissenschaft",
    locale: "de",
    german-mode: "balanced",
  )
  == "Ich mag die Wissenschaft"
)


[Testing complete.]
