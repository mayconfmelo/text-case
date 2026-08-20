mod options;
mod utils;

use crate::utils::*;
use wasm_minimal_protocol::*;
use crate::options::{ConvertOptions, SimpleOptions};
use textcase::{
    convert as textcase_convert,
    sentence_case as textcase_sentence_case,
    sentence_case_title as textcase_sentence_case_title,
    CaseOptions,
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
