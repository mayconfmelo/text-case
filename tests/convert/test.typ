#import "/src/lib.typ": convert

#set page(width: auto, height: auto, margin: 0pt)

// Text case conversion mode.
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