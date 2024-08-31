{ pkgs, ... }:
{
  config = {
    map-syntax = [
      "*.jenkinsfile:Groovy"
      "*.props:Java Properties"
    ];
    pager = "less -FR";
    # theme = "Catppuccin Mocha";
  };

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  # plugins
  extraPackages = with pkgs.bat-extras; [
    # batdiff
    # batman
    batgrep
    # batwatch
  ];

  # add themes
  themes = {
    dracula = {
      src = pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "sublime"; # Bat uses sublime syntax for its themes
        rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
        sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
      };
      file = "Dracula.tmTheme";
    };
  };

  # add syntax
  syntaxes = {
    gleam = {
      src = pkgs.fetchFromGitHub {
        owner = "molnarmark";
        repo = "sublime-gleam";
        rev = "2e761cdb1a87539d827987f997a20a35efd68aa9";
        hash = "sha256-Zj2DKTcO1t9g18qsNKtpHKElbRSc9nBRE2QBzRn9+qs=";
      };
      file = "syntax/gleam.sublime-syntax";
    };
  };
}
