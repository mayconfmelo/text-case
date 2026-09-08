#import "/src/lib.typ": string-case

#set page(width: auto, height: auto, margin: 0pt)

#assert.eq("camelCase", string-case("Camel case", mode: "camel"))
#assert.eq("PascalCase", string-case("pascal_case", mode: "pascal"))
#assert.eq("kebab-case", string-case("Kebab Case", mode: "kebab"))
#assert.eq("Train-Case", string-case("train case", mode: "train"))
#assert.eq("snake_case", string-case("Snake-Case", mode: "snake"))
#assert.eq("CONSTANT_CASE", string-case("constant-case", mode: "constant"))

//#string-case("Invalid string case mode", mode: "title"))