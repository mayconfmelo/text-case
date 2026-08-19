#import "/src/lib.typ": contextual

#set page(width: auto, height: auto, margin: 1em)

#set text(lang: "es")

#contextual.sentence-case("spanish sentence case")\
#contextual.sentence-case-title("spanish sentence case title: subtitle")\
#contextual.title-case("spanish title case: subtitle")\
#contextual.convert("spanish title case: subtitle", mode: "title")