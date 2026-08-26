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
#[wasm_func]
pub fn sentence_case(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: SimpleOptions = decode(input)?;

    let output = textcase_sentence_case(&input.text, &input.locale);

    encode(&output)
}

/// Convert text to sentence-title case.
#[wasm_func]
pub fn sentence_case_title(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: SimpleOptions = decode(input)?;

    let output = textcase_sentence_case_title(&input.text, &input.locale);

    encode(&output)
}

/// General textcase conversion.
#[wasm_func]
pub fn convert(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: ConvertOptions = decode(input)?;
    let mut options = CaseOptions::for_locale(&input.locale);
    
    // Manages then `input.mode` values are not related to `textcase` crate
    if let Some(output) = simpler_cases(&input.text, &input.mode) {
        return encode(&output);
    }
    
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
#[wasm_func]
pub fn detect_case(input: &[u8]) -> Result<Vec<u8>, String> {
    let input: String = decode(input)?;

    let output = if is_camel_case(&input) {
        "camel"
    } else if is_pascal_case(&input) {
        "pascal"
    } else if is_kebab_case(&input) {
        "kebab"
    } else if is_train_case(&input) {
        "train"
    } else if is_snake_case(&input) {
        "snake"
    } else if is_constant_case(&input) {
        "constant"
    } else if input == input.to_lowercase() && input != input.to_uppercase() {
        "lower"
    } else if input == input.to_uppercase() && input != input.to_lowercase() {
        "upper"
    } else {
        "unknown"
    };

    encode(&output)
}