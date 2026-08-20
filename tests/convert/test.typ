#import "/src/lib.typ": convert

#set page(width: auto, height: auto, margin: 0pt)

#assert.eq("Sentence case",            convert("sentence case")                                   )
#assert.eq("Sentence title: Subtitle", convert("sentence title: subtitle", mode: "sentence-title"))
#assert.eq("Title Case: Subtitle",     convert("title case: subtitle", mode: "title")             )

// Change subtitle separator
#assert.eq("Sentence title: Subtitle",  convert("sentence title - subtitle", mode: "sentence-title", subtitle-separator-style: "colon-space")    )
#assert.eq("Sentence title - Subtitle", convert("sentence title: subtitle", mode: "sentence-title", subtitle-separator-style: "space-dash-space"))
#assert.eq("Sentence title — Subtitle", convert("sentence title: subtitle", mode: "sentence-title", subtitle-separator-style: "em-dash-space")   )

#assert.eq("Acronyms like NASA are preserved",         convert("acronyms like NASA are preserved", preserve-acronyms: true)           )
#assert.eq("Acronyms like nasa are not preserved",     convert("acronyms like NASA are NOT preserved", preserve-acronyms: false)      )

#assert.eq("Mixed cases like eBook are preserved",     convert("mixed cases like eBook are preserved", preserve-mixed-case: true)         )
#assert.eq("Mixed cases like ebook are not preserved", convert("mixed cases like eBook are not preserved", preserve-mixed-case: false))

#assert.eq("The title: The subtitle", convert("the title: the subtitle", capitalize-after-subtitle-separator: true, mode: "sentence-title"))\
#assert.eq("The title: the subtitle", convert("the title: the subtitle", capitalize-after-subtitle-separator: false, mode: "sentence-title"))\

#assert.eq("Preserve Capitals", convert("preserve Capitals", preserve-existing-capitals: true))\
#assert.eq("No capitals", convert("no Capitals", preserve-existing-capitals: false))\

#assert.eq("Preserve   whitespace", convert("preserve   whitespace", normalize-whitespace: false))\
#assert.eq("Normalize whitespace",  convert("normalize   whitespace", normalize-whitespace: true))\

#assert.eq("Transform known nouns: GitHub", convert("transform known nouns: github", preserve-known-proper-nouns: true))\
#assert.eq("Preserve known nouns: github", convert("preserve known nouns: github", preserve-known-proper-nouns: false))\

// Localization
#assert.eq("Portuguese sentence case",            convert("Portuguese sentence case", locale: "pt"))
#assert.eq("Text in deutscher selfatzschreibung", convert("text in deutscher selfatzschreibung", locale: "de"))
#assert.eq("Text in deutscher Selfatzschreibung", convert("text in deutscher selfatzschreibung", locale: "de", german-mode: "balanced"))
#assert.eq("Text in deutscher Selfatzschreibung", convert("text in deutscher selfatzschreibung", locale: "de", german-mode: "aggressive"))