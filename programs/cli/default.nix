{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # vim
    neovim
    # speechd
    # neovim-maximal
    wget
    agenix
    doas
    gh
    pup
    lazygit
    nix-prefetch
    argc
    jq
    nix-search-cli
    nixd
    manix
    translate-shell
    yt-dlp
    extra.encore
    nix-init
    nurl
    cachix
    nixfmt-rfc-style
    ripgrep
    nmap
    ttyper
    wayvnc
    flyctl
    wrangler
    devbox
    devenv
    du-dust
    fzf
    # rnix-lsp
    nil
    eza
    bat
    appimage-run
    zellij
    yq
    starship
    zip
    unzip
    ffmpeg-full
    fwupd
    tree
    httpie
    btop
    waypipe
  ];
}
