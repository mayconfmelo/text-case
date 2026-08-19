use textcase::{
    convert as textcase_convert,
    sentence_case as textcase_sentence_case,
    sentence_case_title as textcase_sentence_case_title,
    CaseMode,
    CaseOptions,
    SubtitleSeparatorStyle,
};

use wasm_minimal_protocol::*;


initiate_protocol!();


/* -------------------------------------------------------------------------
 * Helpers
 * ---------------------------------------------------------------------- */

fn utf8(bytes: &[u8]) -> Result<&str, String> {
    std::str::from_utf8(bytes)
        .map_err(|error| format!("invalid UTF-8 input: {error}"))
}

fn string(value: String) -> Vec<u8> {
    value.into_bytes()
}


/* -------------------------------------------------------------------------
 * sentence-case
 * ---------------------------------------------------------------------- */

/// Convert text to sentence case.
///
/// Arguments:
///     text
///     locale
///
/// Example:
///     sentence_case("hello WORLD. this is RUST.", "en")
///
/// Result:
///     "Hello WORLD. This is RUST."
#[wasm_func]
pub fn sentence_case(
    text: &[u8],
    locale: &[u8],
) -> Result<Vec<u8>, String> {
    let text = utf8(text)?;
    let locale = utf8(locale)?;

    Ok(string(
        textcase_sentence_case(text, locale),
    ))
}


/* -------------------------------------------------------------------------
 * sentence-case-title
 * ---------------------------------------------------------------------- */

/// Convert text to sentence-title case.
///
/// Arguments:
///     text
///     locale
///
/// Example:
///     sentence_case_title(
///         "the album - remastered",
///         "en"
///     )
///
/// Result:
///     "The album - Remastered"
#[wasm_func]
pub fn sentence_case_title(
    text: &[u8],
    locale: &[u8],
) -> Result<Vec<u8>, String> {
    let text = utf8(text)?;
    let locale = utf8(locale)?;

    Ok(string(
        textcase_sentence_case_title(text, locale),
    ))
}


/* -------------------------------------------------------------------------
 * convert
 * ---------------------------------------------------------------------- */

/// General textcase conversion.
///
/// Arguments:
///
///     text
///     locale
///     mode
///     subtitle_separator_style
///     capitalize_after_subtitle_separator
///     preserve_acronyms
///     preserve_mixed_case
///     preserve_known_proper_nouns
///     preserve_existing_capitals
///     normalize_whitespace
///
/// The arguments are passed as UTF-8 byte buffers because that is the
/// interface used by Typst plugins.
///
/// `mode`:
///
///     sentence
///     sentence-title
///     title
///
/// `subtitle_separator_style`:
///
///     preserve
///     colon-space
///     dash-space
///     em-dash-space
///
/// Boolean options:
///
///     true
///     false
#[wasm_func]
pub fn convert(
    text: &[u8],
    locale: &[u8],
    mode: &[u8],
    subtitle_separator_style: &[u8],
    capitalize_after_subtitle_separator: &[u8],
    preserve_acronyms: &[u8],
    preserve_mixed_case: &[u8],
    preserve_known_proper_nouns: &[u8],
    preserve_existing_capitals: &[u8],
    normalize_whitespace: &[u8],
) -> Result<Vec<u8>, String> {
    let text = utf8(text)?;
    let locale = utf8(locale)?;
    let mode = utf8(mode)?;
    let subtitle_separator_style =
        utf8(subtitle_separator_style)?;

    let capitalize_after_subtitle_separator =
        parse_bool(
            utf8(capitalize_after_subtitle_separator)?,
            "capitalize-after-subtitle-separator",
        )?;

    let preserve_acronyms =
        parse_bool(
            utf8(preserve_acronyms)?,
            "preserve-acronyms",
        )?;

    let preserve_mixed_case =
        parse_bool(
            utf8(preserve_mixed_case)?,
            "preserve-mixed-case",
        )?;

    let preserve_known_proper_nouns =
        parse_bool(
            utf8(preserve_known_proper_nouns)?,
            "preserve-known-proper-nouns",
        )?;

    let preserve_existing_capitals =
        parse_bool(
            utf8(preserve_existing_capitals)?,
            "preserve-existing-capitals",
        )?;

    let normalize_whitespace =
        parse_bool(
            utf8(normalize_whitespace)?,
            "normalize-whitespace",
        )?;

    let mut options = CaseOptions::for_locale(locale);

    options.mode = parse_mode(mode)?;

    options.subtitle_separator_style =
        parse_subtitle_separator_style(
            subtitle_separator_style,
        )?;

    options.capitalize_after_subtitle_separator =
        capitalize_after_subtitle_separator;

    options.preserve_acronyms =
        preserve_acronyms;

    options.preserve_mixed_case =
        preserve_mixed_case;

    options.preserve_known_proper_nouns =
        preserve_known_proper_nouns;

    options.preserve_existing_capitals =
        preserve_existing_capitals;

    options.normalize_whitespace =
        normalize_whitespace;

    Ok(string(
        textcase_convert(text, &options),
    ))
}


/* -------------------------------------------------------------------------
 * Parsers
 * ---------------------------------------------------------------------- */

fn parse_bool(
    value: &str,
    name: &str,
) -> Result<bool, String> {
    match value {
        "true" => Ok(true),
        "false" => Ok(false),

        _ => Err(format!(
            "{name} must be `true` or `false`, got `{value}`"
        )),
    }
}


fn parse_mode(
    value: &str,
) -> Result<CaseMode, String> {
    match value {
        "sentence" => Ok(CaseMode::Sentence),

        "sentence-title" => {
            Ok(CaseMode::SentenceTitle)
        }

        "title" => Ok(CaseMode::Title),

        _ => Err(format!(
            "unknown case mode `{value}`; \
             expected `sentence`, \
             `sentence-title`, or `title`"
        )),
    }
}


fn parse_subtitle_separator_style(
    value: &str,
) -> Result<SubtitleSeparatorStyle, String> {
    match value {
        "preserve" => {
            Ok(SubtitleSeparatorStyle::Preserve)
        }

        "colon-space" => {
            Ok(SubtitleSeparatorStyle::ColonSpace)
        }

        /*"dash-space" => {
            Ok(SubtitleSeparatorStyle::DashSpace)
        }*/

        "em-dash-space" => {
            Ok(SubtitleSeparatorStyle::EmDashSpace)
        }

        _ => Err(format!(
            "unknown subtitle separator style `{value}`; \
             expected `preserve`, `colon-space`, \
             `dash-space`, or `em-dash-space`"
        )),
    }
}
