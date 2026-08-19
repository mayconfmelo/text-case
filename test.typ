#import "src/lib.typ": sentence-case, sentence-case-title, convert, title-case, contextual

#set page(width: auto, height: auto, margin: 1em)

// Sentence case
#assert.eq("Sentence case. Sentence case",         sentence-case("sentence case. sentence case")        )
#assert.eq("Proper names like Bob are preserved",  sentence-case("proper names like Bob are preserved") )
#assert.eq("Acronyms like NASA are preserved",     sentence-case("acronyms like NASA are preserved")    )
#assert.eq("Mixed cases like eBook are preserved", sentence-case("mixed cases like eBook are preserved"))

// Sentence-cased titles
#assert.eq("Sentence title: Subtitle",  sentence-case-title("sentence title: subtitle") )
#assert.eq("Sentence title - Subtitle", sentence-case-title("sentence title - subtitle"))
#assert.eq("Sentence title — Subtitle", sentence-case-title("sentence title — subtitle"))

// Title case
#assert.eq("Title Case: Subtitle",  title-case("title case: subtitle") )
#assert.eq("Title Case - Subtitle", title-case("title case - subtitle"))
#assert.eq("Title Case — Subtitle", title-case("title case — subtitle"))

// Text case conversion mode
#assert.eq("Sentence case",            convert("sentence case")                                   )
#assert.eq("Sentence title: Subtitle", convert("sentence title: subtitle", mode: "sentence-title"))
#assert.eq("Title Case: Subtitle",     convert("title case: subtitle", mode: "title")             )

// Change subtitle separator
#assert.eq("Sentence title: Subtitle",  convert("sentence title - subtitle", mode: "sentence-title", subtitle-separator-style: "colon-space")    )
#assert.eq("Sentence title - Subtitle", convert("sentence title: subtitle", mode: "sentence-title", subtitle-separator-style: "space-dash-space"))
#assert.eq("Sentence title — Subtitle", convert("sentence title: subtitle", mode: "sentence-title", subtitle-separator-style: "em-dash-space")   )

#assert.eq("Acronyms like nasa are not preserved",     convert("acronyms like NASA are NOT preserved", preserve-acronyms: false)      )
#assert.eq("Mixed cases like ebook are not preserved", convert("mixed cases like eBook are not preserved", preserve-mixed-case: false))

// Localization
#assert.eq("Portuguese sentence case",         convert("Portuguese sentence case", locale: "pt"))
#assert.eq("Text in deutscher selfatzschreibung", convert("text in deutscher selfatzschreibung", locale: "de"))
#assert.eq("Text in deutscher Selfatzschreibung", convert("text in deutscher selfatzschreibung", locale: "de", german-mode: "balanced"))
#assert.eq("Text in deutscher Selfatzschreibung", convert("text in deutscher selfatzschreibung", locale: "de", german-mode: "aggressive"))

#set text(lang: "es")

// Localization from #text.lang
#contextual.sentence-case("spanish sentence case")\
#contextual.sentence-case-title("spanish sentence case title: subtitle")\
#contextual.convert("spanish title case: subtitle", mode: "title")