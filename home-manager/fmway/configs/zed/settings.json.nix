{ pkgs, ... }:
''
{
  "ui_font_size": 16,
  "buffer_font_size": 16,
  "vim_mode": true,
  "theme": "Catppuccin Macchiato",
  "auto_update": false,
  "relative_line_numbers": true,
  "lsp": {
    "gopls": {
      "binary": {
        "path": "${pkgs.gopls}/bin/gopls"
      },
    },
    "rust-analyzer": {
      "initialization_options": {
        "completion": {
          "snippets": {
            "Arc::new": {
                "postfix": "arc",
                "body": ["Arc::new(''${receiver})"],
                "requires": "std::sync::Arc",
                "scope": "expr"
            },
            "Some": {
                "postfix": "some",
                "body": ["Some(''${receiver})"],
                "scope": "expr"
            },
            "Ok": {
                "postfix": "ok",
                "body": ["Ok(''${receiver})"],
                "scope": "expr"
            },
          },
        },
        "rust": {
          "analyzerTargetDir": true,
        },
        "check": {
          "command": "clippy"
        }
      },
      "binary": {
        "path": "${pkgs.rust-analyzer}/bin/rust-analyzer"
      }
    }
  }
}
''
