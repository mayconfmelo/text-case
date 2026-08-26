use std::io::Cursor;
use serde::{Deserialize, Serialize};
use textcase::{CaseMode, GermanMode, SubtitleSeparatorStyle};
use ciborium::{de::from_reader, ser::into_writer};
use inflections::case::{
    to_camel_case,
    to_kebab_case,
    to_train_case,
    to_snake_case,
    to_pascal_case,
    to_constant_case,
};

// CBOR decode
pub fn decode<T>(input: &[u8]) -> Result<T, String>
where
    T: for<'de> Deserialize<'de>,
{
    from_reader(Cursor::new(input))
        .map_err(|error| format!("textcase: invalid CBOR input: {error}"))
}

// CBOR encode
pub fn encode<T>(value: &T) -> Result<Vec<u8>, String>
where
    T: Serialize,
{
    let mut output = Vec::new();

    into_writer(value, &mut output)
        .map_err(|error| format!("textcase: failed to encode CBOR: {error}"))?;

    Ok(output)
}

/// Manages misc text cases not related to `textcase` crate
pub fn simpler_cases(text: &str, mode: &str) -> Option<String> {
    match mode {
        "lower" => Some(text.to_lowercase()),
        "upper" => Some(text.to_uppercase()),
        
        "camel" => Some(to_camel_case(text)),
        "pascal" => Some(to_pascal_case(text)),
        "kebab" => Some(to_kebab_case(text)),
        "train" => Some(to_train_case(text)),
        "snake" => Some(to_snake_case(text)),
        "constant" => Some(to_constant_case(text)),
        
        "unknown" => Some(text.to_string()),
        
        _ => None,
    }
}

// Enum parsers

// Mode enum
pub fn parse_mode(mode: &str) -> Result<CaseMode, String> {
    match mode {
        "sentence" => Ok(CaseMode::Sentence),
        "sentence-title" => Ok(CaseMode::SentenceTitle),
        "title" => Ok(CaseMode::Title),
        other => Err(format!("textcase: invalid mode '{other}'; expected 'sentence', 'sentence-title', or 'title'")),
    }
}

// SubtitleSeparatorStyle enum
pub fn parse_subtitle_separator_style(style: &str) -> Result<SubtitleSeparatorStyle, String> {
    match style {
        "preserve" => Ok(SubtitleSeparatorStyle::Preserve),
        "colon-space" => Ok(SubtitleSeparatorStyle::ColonSpace),
        "space-dash-space" => Ok(SubtitleSeparatorStyle::SpaceDashSpace),
        "em-dash-space" => Ok(SubtitleSeparatorStyle::EmDashSpace),
        other => Err(format!("textcase: invalid subtitle-separator-style '{other}'; expected 'preserve', 'colon-space', 'space-dash-space', or 'em-dash-space'")),
    }
}
 
// GermanMode enum
pub fn parse_german_mode(mode: &str) -> Result<GermanMode, String> {
    match mode {
        "conservative" => Ok(GermanMode::Conservative),
        "balanced" => Ok(GermanMode::Balanced),
        "aggressive" => Ok(GermanMode::Aggressive),
        other => Err(format!("textcase: invalid german-mode '{other}'; expected 'conservative', 'balanced', or 'aggressive'")),
    }
}
