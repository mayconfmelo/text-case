# Text Case

<div align="center">

<p class="hidden">
  Simple, multilingual solution for capitalization formatting
</p>

<p class="hidden">
  <a href="https://typst.app/universe/package/textcase">
    <img alt="Typst Universe version" src="https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Ftypst.app%2Funiverse%2Fpackage%2Ftextcase&query=%2Fhtml%2Fbody%2Fdiv%2Fmain%2Fdiv%5B2%5D%2Faside%2Fsection%5B2%5D%2Fdl%2Fdd%5B3%5D&logo=typst&label=Universe&color=%23239DAE&labelColor=%23353c44" /></a>
  <a href="https://github.com/mayconfmelo/textcase/tree/dev/">
    <img alt="GitHub development branch version" src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmayconfmelo%2Ftextcase%2Frefs%2Fheads%2Fdev%2Ftypst.toml&query=%24.package.version&logo=github&label=Development&logoColor=%2397978e&color=%23239DAE&labelColor=%23353c44" /></a>
</p>

[![Get Manual](https://img.shields.io/badge/Manual-%23353c44)](https://raw.githubusercontent.com/mayconfmelo/textcase/refs/tags/0.1.0/docs/manual.pdf)
[![Example PDF](https://img.shields.io/badge/Example-.pdf-%23777?labelColor=%23353c44)](https://raw.githubusercontent.com/mayconfmelo/textcase/refs/tags/0.1.0/docs/example.pdf)
[![Example source code](https://img.shields.io/badge/Example-.typ-%23777?labelColor=%23353c44)](https://github.com/mayconfmelo/textcase/blob/0.1.0/docs/example/main.typ)
[![Changelog file](https://img.shields.io/badge/Changelog-%23353c44)](https://github.com/mayconfmelo/textcase/blob/0.1.0/docs/changelog.md)
[![Contribute with development](https://img.shields.io/badge/Contribute-%23353c44)](https://github.com/mayconfmelo/textcase/blob/0.1.0/docs/contributing.md)

<p class="hidden">
  <a href="https://github.com/mayconfmelo/textcase/actions/workflows/tests.yml">
    <img alt ="General tests badge" src="https://github.com/mayconfmelo/textcase/actions/workflows/tests.yml/badge.svg"></a>
  <a href="https://github.com/mayconfmelo/textcase/actions/workflows/build.yml">
    <img alt="Build test badge" src="https://github.com/mayconfmelo/textcase/actions/workflows/build.yml/badge.svg"></a>
  <a href="https://github.com/mayconfmelo/textcase/actions/workflows/spellcheck.yml">
    <img alt ="Spellcheck test badge" src="https://github.com/mayconfmelo/textcase/actions/workflows/spellcheck.yml/badge.svg"></a>
 <a href="https://github.com/mayconfmelo/textcase/actions/workflows/plugin.yml">
    <img alt ="Plugin build badge" src="https://github.com/mayconfmelo/textcase/actions/workflows/plugin.yml/badge.svg"></a>
</p>

**This project is an unofficial implementation of the [*textcase* crate](https://crates.io/crates/textcase), and its developers have no affiliation with it.**

</div>


## Quick Start

```typst
#import "@preview/textcase:0.1.0": contextual

// Sentence case text.
#contextual.sentence-case("sentence case text.")

// Sentence case title: Subtitle
#contextual.sentence-case-title("sentence case title: subtitle")

// Title Case: Subtitle
#contextual.title-case("title case: subtitle)
```

The `#textcase.contextual` module allows obtaining the language from `#text.lang`.
The same commands are available directly without this functionality.


## Description

Multilingual sentence and title recasing for Latin-script languages.
This recases text whose capitalization is wrong or missing — lowercase
feeds, SHOUTED titles, Title Cased Prose — while preserving capitalization
that carries information. It works without any external data.

This package aims to implement an API that closely mirrors the original
crate while adhering to Typst's coding standards. An additional
`#title-case` command is also provided for convenience.


## Feature List

- Sentence case text
- Sentence-case titles and subtitles
- Title-case text
- Advanced capitalization
  - Set subtitle separator character
  - Capitalize subtitles
  - Preserve acronyms
  - Preserve mixed case text
  - Preserve known proper nouns
  - Preserve proper names (capitalized)
  - Normalize additional whitespace
  - Capitalization mode for german language
- Automatic contextual locale (`#text.lang`)