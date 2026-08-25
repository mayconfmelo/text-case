#import "/src/lib.typ": detect-case

#set page(width: auto, height: auto, margin: 0pt)

// Text cases
#assert.eq("title",          detect-case("The Lord of the Rings: The Two Towers") )
#assert.eq("sentence",       detect-case("The lord of the rings: the two towers") )
#assert.eq("sentence-title", detect-case("The lord of the rings: The two towers") )
#assert.eq("lower",          detect-case("the lord of the rings: the two towers") )
#assert.eq("upper",          detect-case("THE LORD OF THE RINGS: THE TWO TOWERS") )

// String cases
#assert.eq("camel",          detect-case("theLordOfTheRingsTheTwoTowers")        )
#assert.eq("pascal",         detect-case("TheLordOfTheRingsTheTwoTowers")        )
#assert.eq("kebab",          detect-case("the-lord-of-the-rings-the-two-towers") )
#assert.eq("train",          detect-case("The-Lord-Of-The-Rings-The-Two-Towers") )
#assert.eq("snake",          detect-case("the_lord_of_the_rings_the_two_towers") )
#assert.eq("constant",       detect-case("THE_LORD_OF_THE_RINGS_THE_TWO_TOWERS") )