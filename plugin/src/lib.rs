mod options;

use std::io::Cursor;

use ciborium::{
    de::from_reader,
    ser::into_writer,
};

use serde::{Deserialize, Serialize};

use textcase::{
    convert as textcase_convert,
    sentence_case as textcase_sentence_case,
    sentence_case_title as textcase_sentence_case_title,
    CaseMode,
    CaseOptions,
    GermanMode,
    SubtitleSeparatorStyle,
};

use wasm_minimal_protocol::*;

use crate::options::ConvertOptions;


initiate_protocol!();


/* =========================================================================
 * CBOR
 * ========================================================================= */

fn decode<T>(
    input: &[u8],
) -> Result<T, String>
where
    T: for<'de> Deserialize<'de>,
{
    from_reader(Cursor::new(input))
        .map_err(|error| {
            format!(
                "textcase: invalid CBOR input: {error}"
            )
        })
}


fn encode<T>(
    value: &T,
) -> Result<Vec<u8>, String>
where
    T: Serialize,
{
    let mut output = Vec::new();

    into_writer(
        value,
        &mut output,
    )
    .map_err(|error| {
        format!(
            "textcase: failed to encode CBOR: {error}"
        )
    })?;

    Ok(output)
}


/* =========================================================================
 * INPUT TYPES
 * ========================================================================= */

#[derive(Debug, Deserialize)]
#[serde(default)]
struct SimpleOptions {
    text: String,
    locale: String,
}

impl Default for SimpleOptions {
    fn default() -> Self {
        Self {
            text: String::new(),
            locale: "en".to_owned(),
        }
    }
}


/* =========================================================================
 * SENTENCE CASE
 * ========================================================================= */

/// Convert text to sentence case.
///
/// Input CBOR:
///
/// {
///     "text": "...",
///     "locale": "en"
/// }
///
/// Output CBOR:
///
/// "Converted text"
#[wasm_func]
pub fn sentence_case(
    input: &[u8],
) -> Result<Vec<u8>, String> {
    let input: SimpleOptions =
        decode(input)?;

    let output =
        textcase_sentence_case(
            &input.text,
            &input.locale,
        );

    encode(&output)
}


/* =========================================================================
 * SENTENCE TITLE CASE
 * ========================================================================= */

/// Convert text to sentence-title case.
///
/// Input CBOR:
///
/// {
///     "text": "...",
///     "locale": "en"
/// }
///
/// Output CBOR:
///
/// "Converted text"
#[wasm_func]
pub fn sentence_case_title(
    input: &[u8],
) -> Result<Vec<u8>, String> {
    let input: SimpleOptions =
        decode(input)?;

    let output =
        textcase_sentence_case_title(
            &input.text,
            &input.locale,
        );

    encode(&output)
}


/* =========================================================================
 * CONVERT
 * ========================================================================= */

/// General textcase conversion.
///
/// Input is a CBOR-encoded ConvertOptions.
///
/// Output is a CBOR-encoded String.
#[wasm_func]
pub fn convert(
    input: &[u8],
) -> Result<Vec<u8>, String> {
    let input: ConvertOptions =
        decode(input)?;

    let mut options =
        CaseOptions::for_locale(
            &input.locale,
        );


    /* ---------------------------------------------------------------------
     * mode
     * ------------------------------------------------------------------ */

    options.mode =
        parse_mode(&input.mode)?;


    /* ---------------------------------------------------------------------
     * subtitle separator
     * ------------------------------------------------------------------ */

    options.subtitle_separator_style =
        parse_subtitle_separator_style(
            &input.subtitle_separator_style,
        )?;


    /* ---------------------------------------------------------------------
     * boolean options
     * ------------------------------------------------------------------ */

    options.capitalize_after_subtitle_separator =
        input.capitalize_after_subtitle_separator;

    options.preserve_acronyms =
        input.preserve_acronyms;

    options.preserve_mixed_case =
        input.preserve_mixed_case;

    options.preserve_known_proper_nouns =
        input.preserve_known_proper_nouns;

    options.preserve_existing_capitals =
        input.preserve_existing_capitals;

    options.normalize_whitespace =
        input.normalize_whitespace;


    /* ---------------------------------------------------------------------
     * German mode
     * ------------------------------------------------------------------ */

    options.german_mode =
        parse_german_mode(
            &input.german_mode,
        )?;


    /* ---------------------------------------------------------------------
     * Actual conversion
     * ------------------------------------------------------------------ */

    let output =
        textcase_convert(
            &input.text,
            &options,
        );


    /* ---------------------------------------------------------------------
     * CBOR output
     * ------------------------------------------------------------------ */

    encode(&output)
}


/* =========================================================================
 * ENUM PARSERS
 * ========================================================================= */

fn parse_mode(
    mode: &str,
) -> Result<CaseMode, String> {
    match mode {
        "sentence" => {
            Ok(CaseMode::Sentence)
        }

        "sentence-title" => {
            Ok(CaseMode::SentenceTitle)
        }

        "title" => {
            Ok(CaseMode::Title)
        }

        other => {
            Err(format!(
                "textcase: invalid mode `{other}`; \
                 expected `sentence`, \
                 `sentence-title`, or `title`"
            ))
        }
    }
}


fn parse_subtitle_separator_style(
    style: &str,
) -> Result<SubtitleSeparatorStyle, String> {
    match style {
        "preserve" => {
            Ok(
                SubtitleSeparatorStyle::Preserve
            )
        }

        "colon-space" => {
            Ok(
                SubtitleSeparatorStyle::ColonSpace
            )
        }

        "space-dash-space" => {
            Ok(
                SubtitleSeparatorStyle::SpaceDashSpace
            )
        }

        "em-dash-space" => {
            Ok(
                SubtitleSeparatorStyle::EmDashSpace
            )
        }

        other => {
            Err(format!(
                "textcase: invalid \
                 subtitle-separator-style `{other}`; \
                 expected `preserve`, \
                 `colon-space`, \
                 `dash-space`, or \
                 `em-dash-space`"
            ))
        }
    }
}


fn parse_german_mode(
    mode: &str,
) -> Result<GermanMode, String> {
    match mode {
        "conservative" => {
            Ok(GermanMode::Conservative)
        }

        "balanced" => {
            Ok(GermanMode::Balanced)
        }

        "aggressive" => {
            Ok(GermanMode::Aggressive)
        }

        other => {
            Err(format!(
                "textcase: invalid german-mode `{other}`; \
                 expected `conservative`, \
                 `balanced`, or `aggressive`"
            ))
        }
    }
}
