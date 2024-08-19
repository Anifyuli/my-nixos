{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd # nix lsp
    # rnix-lsp # this too 
    # nil # this too
    oha # http load generator
    # adbtuifm # file-manager adb
    # isync
    # himalaya # email client...🤔
    # nix-index # nix-index is suck, fuck it
    # comma # also this, very suck
    # fmpkgs.scribd-downloader # scribd downloader 😱, tai
    # nh # wrapper nixos-rebuild & home-manager with nvd + nix-output-monitor
    nvd # nix diff
    nix-output-monitor # nix beautiful output
    # nix-du
    # ctop # top for container
    # kdash # dashboard kubernetes
    # lazydocker # management docker for lazier man
    # jqp # tui for jq
    lazysql # tui for sql
    # prs # tui for view PR (Pull Request)
    # speechd
    # neovim-maximal
    wget # who knows?
    fd # alternative find, more wuss wuss
    agenix # secret.age
    doas # alternative sudo
    gh # github-cli
    mint # mint-lang?
    pup # for scraping html
    # gitui # alternative lazygit
    argc # for generate completion
    jq # json parser
    # calcurse # tui calendar viewer
    # ranger # tui file manager
    # joshuto # ranger alternative
    # neomutt # tui mail client
    # aerc # neomutt alternative
    # frogmouth # tui markdown viewer. awesome but, very lag
    manix # nix options search
    translate-shell # google or bing translate in terminal
    yt-dlp # all in one video downloader
    extra.encore # awesome tools for developing go and typescript
    nix-init # automate builder nix derivation
    # nurl # ?
    rclone
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
    # nixpacks # this is simplify docker with toml configuration
    du-dust # alternative du
    fzf # fuzzy search
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
