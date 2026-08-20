#import "@preview/textcase:0.1.0"

#set page(width: 17cm, height: auto)
#set text(font: "Arial", size: 12pt)

// Visualize code and evaluate result
#show raw.where(lang: "eg"): it => {
  import "@preview/min-manual:0.3.0": example
  set text(font: "libertinus serif")
  example(
    scope: dictionary(textcase), it.text
  )
}


= Sentence case

````eg
#sentence-case(
  ```
  this is a sentence.
  Preserves MiXeD-case and ACRONYMS.
  NORMALIZES SHOUTED SENTENCES.
  builtin proper nouns: github
  ```
)
````

= Sentence case title

````eg
#sentence-case-title(
  ```
  this is a title: this is the subtitle
  this is a title - this is the subtitle
  this is a title — this is the subtitle
  ```
)
````

= Title case

````eg
#title-case("this is a title")
````

= Fine-tunned case conversions

```eg
#convert("title case", mode: "title")\
#convert("no MiXeD-case", preserve-mixed-case: false)\
#convert("no ACRONYMS", preserve-acronyms: false)\
#convert("title: lower case", capitalize-after-subtitle-separator: false)\
#convert("title: subtitle", subtitle-separator-style: "em-dash-space")\
#convert("no Capitals", preserve-existing-capitals: false)\
#convert("preserve   whitespace", normalize-whitespace: false)\
#convert("just github", preserve-known-proper-nouns: false)\
```
