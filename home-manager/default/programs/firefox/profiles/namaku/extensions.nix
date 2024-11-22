{ pkgs, ... }:
(with pkgs.nur.repos.rycee.firefox-addons; [
  metamask
  multi-account-containers
  greasemonkey
  gesturefy
  tree-style-tab
  react-devtools
  search-by-image
  firefox-color
  vue-js-devtools
]) ++ (with pkgs.fmpkgs.firefox-addons; [
  xdm_v8
  what-font
  wakatime
  stayfree
  firefox-relay
  preact-devtools
])
