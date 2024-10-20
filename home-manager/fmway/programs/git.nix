{ pkgs, ... }:
{
  userName = "fmway";
  userEmail = "fm18lv@gmail.com";
  # delta.enable = true; # enable git diff with delta
  # difftastic.enable = true; # git diff with difftastic
  # diff-so-fancy.enable = true; # git diff with diff-so-fancy
  aliases = {
    a = "add";
    cm = "commit";
    ch = "checkout";
    s = "status";
  };
  extraConfig = {
    hub.protocol = "ssh";
    url."https://github.com/".insteadOf = "gh:";
    url."https://gitlab.com/".insteadOf = "gl:";
    url."https://codeberg.org/".insteadOf = "cb:";
    url."https://github.com/fmway/".insteadOf = "fm:";
    credential.helper = "${
      pkgs.custom.git
    }/bin/git-credential-libsecret";
    };
}
