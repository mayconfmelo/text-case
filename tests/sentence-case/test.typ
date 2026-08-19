#import "/src/lib.typ": sentence-case

#set page(width: auto, height: auto, margin: 0pt)

#assert.eq("Sentence case. Sentence case",         sentence-case("sentence case. sentence case")        )
#assert.eq("Proper names like Bob are preserved",  sentence-case("proper names like Bob are preserved") )
#assert.eq("Acronyms like NASA are preserved",     sentence-case("acronyms like NASA are preserved")    )
#assert.eq("Mixed cases like eBook are preserved", sentence-case("mixed cases like eBook are preserved"))