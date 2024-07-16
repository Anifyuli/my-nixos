{ pkgs, ... }:
{
  enable = true;
  userName = "fmway";
  userEmail = "fm18lv@gmail.com";
  aliases = {
    a = "add";
    cm = "commit";
    ch = "checkout";
    s = "status";
  };
  extraConfig = {
    hub.protocol = "ssh";
    credential.helper = "${
      pkgs.custom.git
    }/bin/git-credential-libsecret";
    };
}
