{ pkgs, ... }:
{
  name = "namaku";
  id = 0;
  search = {
    default = "Google";
    engines = {
      "Nix Packages" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "type"; value = "packages"; }
            { name = "channel"; value = "unstable"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "Nix Options" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "type"; value = "packages"; }
            { name = "channel"; value = "unstable"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
      };

      "Home Manager Options" = {
        urls = [{
          template = "https://home-manager-options.extranix.com/";
          params = [
            { name = "type"; value = "packages"; }
            { name = "release"; value = "master"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        definedAliases = [ "@hm" ];
      };

      "NixOS Wiki" = {
        urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
        iconUpdateURL = "https://wiki.nixos.org/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@nw" ];
      };

      "Bing".metaData.hidden = true;
      "Google".metaData.alias = "g"; # builtin engines only support specifying one additional alias
    };
  };

  userChrome = ''
    @import "${pkgs.fmpkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
  '';

  userContent = ''
    @import "${pkgs.fmpkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
  '';
}
