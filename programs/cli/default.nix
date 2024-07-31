{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    comma # nix shell alternative :VVVVVVVVV
    fmpkgs.scribd-downloader # scribd downloader 😱
    # vim
    neovim # best text editor :)
    # speechd
    # neovim-maximal
    wget # who knows?
    fd # alternative find
    agenix # secret.age
    doas # alternative sudo
    gh # github-cli
    mint # mint-lang?
    pup # for scraping html
    lazygit # awesome git tools
    argc # for generate completion
    jq # json parser
    nix-search-cli 
    nixd # nixlang lsp
    manix # nix options search
    translate-shell # google or bing translate in terminal
    yt-dlp # all in one video downloader
    extra.encore # awesome tools for developing go and typescript
    nix-init # automate builder nix derivation
    nurl # ?
    cachix # unofficial binary cache server (another binary cache in cache.nixos.org)
    nixfmt-rfc-style # fmt for nix
    ripgrep # alternative grep
    nmap # hem...
    ttyper # monkeytype in terminal
    wayvnc # vnc for wayland 
    flyctl # fly.io management in terminal
    wrangler # cloudflare worker management in terminal
    devbox # alternative docker for development
    devenv # also this
    du-dust # alternative du
    fzf # fuzzy search
    # rnix-lsp
    # nil
    eza # alternative ls
    bat # alternative cat
    appimage-run # to run AppImage
    zellij # alternative tmux
    yq # yaml and toml parser
    starship # awesome prompt theme
    zip #....
    unzip #....
    ffmpeg-full #...
    fwupd #...
    tree #...
    httpie # tools for consume http and https / alternative curl 
    btop # alternative top
    waypipe # piping wayland / xhost in wayland / run gui in ssh over wayland
  ] ++ (with fishPlugins; [
    fzf-fish # fuzzy finder in fish
    git-abbr # abbreviation / autocomplete git
    pisces # autoclose brackets parenthesis and quote
  ]);
}
