#import "/src/lib.typ": title-case

#set page(width: auto, height: auto, margin: 0pt)

#assert.eq("Title Case: Subtitle",  title-case("title case: subtitle") )
#assert.eq("Title Case - Subtitle", title-case("title case - subtitle"))
#assert.eq("Title Case — Subtitle", title-case("title case — subtitle"))