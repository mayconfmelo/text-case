use serde::Deserialize;

#[derive(Debug, Deserialize)]
#[serde(default)]
pub struct ConvertOptions {
    pub text: String,
    pub locale: String,
    pub mode: String,
    pub subtitle_separator_style: String,
    pub capitalize_after_subtitle_separator: bool,
    pub preserve_acronyms: bool,
    pub preserve_mixed_case: bool,
    pub preserve_known_proper_nouns: bool,
    pub preserve_existing_capitals: bool,
    pub normalize_whitespace: bool,
    pub german_mode: String,
}

impl Default for ConvertOptions {
    fn default() -> Self {
        Self {
            text: String::new(),
            locale: "en".into(),
            mode: "sentence".into(),
            subtitle_separator_style: "preserve".into(),
            capitalize_after_subtitle_separator: true,
            preserve_acronyms: true,
            preserve_mixed_case: true,
            preserve_known_proper_nouns: true,
            preserve_existing_capitals: true,
            normalize_whitespace: true,
            german_mode: "conservative".into(),
        }
    }
}

#[derive(Debug, Deserialize)]
#[serde(default)]
pub struct SimpleOptions {
    pub text: String,
    pub locale: String,
}

impl Default for SimpleOptions {
    fn default() -> Self {
        Self {
            text: String::new(),
            locale: "en".to_owned(),
        }
    }
}
