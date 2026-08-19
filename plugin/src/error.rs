use serde::Serialize;

#[derive(Debug, Serialize)]
pub struct PluginError {
    pub code: String,
    pub message: String,
}

impl PluginError {
    pub fn new(
        code: impl Into<String>,
        message: impl Into<String>,
    ) -> Self {
        Self {
            code: code.into(),
            message: message.into(),
        }
    }
}
