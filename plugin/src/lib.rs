mod options;
mod util;

use crate::util::*;
use wasm_minimal_protocol::*;
use crate::options::{ConvertOptions, SimpleOptions};
use textcase::{
    convert as textcase_convert,
    sentence_case as textcase_sentence_case,
    sentence_case_title as textcase_sentence_case_title,
    CaseOptions,
};
use inflections::case::{
    is_camel_case,
    is_kebab_case,
    is_train_case,
    is_snake_case,
    is_pascal_case,
    is_constant_case,
};

initiate_protocol!();

/// Convert text to sentence case.
/// Input is CBOR-encoded SimpleOptions; output is CBOR-encoded string.
#[wasm_func]
pub fn sentence_case(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: SimpleOptions = decode(input)?;

    let output = textcase_sentence_case(&input.text, &input.locale);

    encode(&output)
}

/// Convert text to sentence-title case.
/// Input is CBOR-encoded SimpleOptions; output is CBOR-encoded string.
#[wasm_func]
pub fn sentence_case_title(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: SimpleOptions = decode(input)?;

    let output = textcase_sentence_case_title(&input.text, &input.locale);

    encode(&output)
}

/// General textcase conversion.
/// Input is CBOR-encoded SimpleOptions; output is CBOR-encoded string.
#[wasm_func]
pub fn convert(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: ConvertOptions = decode(input)?;
    let mut options = CaseOptions::for_locale(&input.locale);

    options.mode = parse_mode(&input.mode)?;
    options.subtitle_separator_style = parse_subtitle_separator_style(&input.subtitle_separator_style)?;
    options.capitalize_after_subtitle_separator = input.capitalize_after_subtitle_separator;
    options.preserve_acronyms = input.preserve_acronyms;
    options.preserve_mixed_case = input.preserve_mixed_case;
    options.preserve_known_proper_nouns = input.preserve_known_proper_nouns;
    options.preserve_existing_capitals = input.preserve_existing_capitals;
    options.normalize_whitespace = input.normalize_whitespace;
    options.german_mode = parse_german_mode(&input.german_mode)?;
    
    let output = textcase_convert(&input.text, &options);
    
    encode(&output)
}


/// Detects string case---naming conventions used in code.
/// Input is CBOR-encoded String; output is CBOR-encoded String.
#[wasm_func]
pub fn detect_case(input: &[u8]) -> Result<Vec<u8>, String> {
  let input: String = decode(input)?;
  let mut output = String::new();
  
  if is_camel_case(&input) {output.push_str("camel")}
  else if is_pascal_case(&input) {output.push_str("pascal")}
  else if is_kebab_case(&input) {output.push_str("kebab")}
  else if is_train_case(&input) {output.push_str("train")}
  else if is_snake_case(&input) {output.push_str("snake")}
  else if is_constant_case(&input) {output.push_str("constant")}
  else {output.push_str("unknown")}
  
  encode(&output)
}