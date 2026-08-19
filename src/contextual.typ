#let sentence-case(..args) = context {
  import "non-contextual.typ": sentence-case
  
  let localized = sentence-case.with(locale: text.lang)
  
  return localized(..args)
}

#let sentence-case-title(..args) = context  {
  import "non-contextual.typ": sentence-case-title
  
  let localized = sentence-case-title.with(locale: text.lang)
  
  return localized(..args)
}

#let convert(..args) = context {
  import "non-contextual.typ": convert
  
  let localized = convert.with(locale: text.lang)
  
  return localized(..args)
}

#let title-case(..args) = context {
  import "non-contextual.typ": title-case
  
  let localized = title-case.with(locale: text.lang)
  
  return localized(..args)
}