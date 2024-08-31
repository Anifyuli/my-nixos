{ pkgs, ... }:
(with pkgs.nur.repos.rycee.firefox-addons; [
  metamask
  multi-account-containers
  greasemonkey
  react-devtools
  search-by-image
  firefox-color
  vue-js-devtools
]) ++ (with pkgs.fmpkgs.firefoxAddons; [
  what-font
  wakatime
  stayfree
  firefox-relay
  preact-devtools
])
