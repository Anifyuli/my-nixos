{ pkgs, ... }:
{
  default = "Bing"; # default search engine
  privateDefault = "DuckDuckGo"; # default search engine in private mode
  force = true; # Force replace the existing search configuration

  # list search engines
  engines = {
    "Github" = {
      urls = [{
        template = "https://github.com/{searchTerms}";
      }];

      icon = ./github.svg;
      definedAliases = [ "@gh" ];
    };
    # https://github.com/search?q=asu&type=repositories
    "Github Search" = {
      urls = [{
        template = "https://github.com/search";
        params = [
          { name = "q"; value = "{searchTerms}"; }
          { name = "type"; value = "repositories"; }
        ];
      }];
      icon = ./github.svg;
      definedAliases = [ "@gs" ];
    };
    "Github Topics" = {
      urls = [{
        template = "https://github.com/search";
        params = [
          { name = "q"; value = "{searchTerms}"; }
          { name = "type"; value = "topics"; }
        ];
      }];
      icon = ./github.svg;
      definedAliases = [ "@gt" ];
    };
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

    "Bing".metaData.alias = "b";
    "Wikipedia".metaData.alias = "w";
    "DuckDuckGo".metaData.alias = "d";
    "Google".metaData.alias = "g"; # builtin engines only support specifying one additional alias
  };
  # order = [
  #   "Bing"
  #   "Google"
  #   "DuckDuckGo"
  #   "NixOS Search"
  #   "Nixos Options"
  #   "Home Manager Options"
  # ];
}
