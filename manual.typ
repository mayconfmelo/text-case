#import "@preview/min-manual:0.3.0": manual, url

#show: manual.with(
  title: "Text Case",
  logo: image("docs/assets/manual-logo.png"),
  manifest: toml("typst.toml"),
  from-comments: read("src/non-contextual.typ")
)


= Locales

The crate has dedicated profiles for `"en"`, `"de"`, `"fr"`, `"es"`, `"pt"`, `"it"`, `"nl"`, `"sv"`, `"da"`, `"no"`, `"fi"`, `"tr"`, `"az"`, and `"lt"`
languages. A profile contributes stop words and lowercase particles (title mode), abbreviation classes (sentence splitting), contraction tails
(don't, O'Brien), and elision prefixes (d'affaires → d'Affaires). Any other locale gets a neutral profile that assumes nothing beyond a few Latin
abbreviations.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.