#import "src/lib.typ": *

#let check(input, expected) = {
  let output = sentence-case(input)

  assert(
    output == expected,
    message: (
      "expected: " + expected +
      "\nactual: " + output
    ),
  )
}

#check(
  "hello world. this is a test.",
  "Hello world. This is a test.",
)

#check(
  "yesterday Alice met Bob in Paris. we had fun",
  "Yesterday Alice met Bob in Paris. We had fun",
)

#check(
  "the NASA probe landed.",
  "The NASA probe landed.",
)

#assert(
  sentence-case-title(
    "the album - remastered"
  )
  == "The album - Remastered"
)

#assert(
  convert(
    "the lord of the rings",
    mode: "title",
  )
  == "The Lord of the Rings"
)

#assert(
  convert(
    "the rise of github - inside rust tooling",
    mode: "sentence-title",
    subtitle-separator-style: "colon-space",
  )
  == "The rise of GitHub: Inside rust tooling"
)

#text[All tests passed.]
