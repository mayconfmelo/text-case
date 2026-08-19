#import "/src/lib.typ": sentence-case-title

#set page(width: auto, height: auto, margin: 0pt)

#assert.eq("Sentence title: Subtitle",  sentence-case-title("sentence title: subtitle") )
#assert.eq("Sentence title - Subtitle", sentence-case-title("sentence title - subtitle"))
#assert.eq("Sentence title — Subtitle", sentence-case-title("sentence title — subtitle"))