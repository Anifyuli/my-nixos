{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd # nix lsp
    waydroid-script
    # rnix-lsp # this too 
    # nil # this too
    oha # http load generator
    hyperfine # for benchmarking
    parallel # multi threading in shell
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
    fx # jq like but tui 
    # prs # tui for view PR (Pull Request)
    # speechd
    # neovim-maximal
    wget # who knows?
    agenix # secret.age
    doas # alternative sudo
    # mint # mint-lang?
    pup # for scraping html
    # gitui # alternative lazygit
    argc # for generate completion
    # calcurse # tui calendar viewer
    # ranger # tui file manager
    # joshuto # ranger alternative
    # neomutt # tui mail client
    # aerc # neomutt alternative
    # frogmouth # tui markdown viewer. awesome but, very lag
    # manix # nix options search
    extra.encore # awesome tools for developing go and typescript
    nix-init # automate builder nix derivation
    # nurl # ?
    rclone
    cachix # unofficial binary cache server (another binary cache in cache.nixos.org)
    nixfmt-rfc-style # fmt for nix
    nmap # hem...
    ttyper # monkeytype in terminal
    # wayvnc # vnc for wayland / especially wlroots
    flyctl # fly.io management in terminal
    wrangler # cloudflare worker management in terminal
    devbox # alternative docker for development
    devenv # also this
    systemctl-tui # management systemd using tui
    # nixpacks # this is simplify docker with toml configuration
    du-dust # du alternative
    fzf # fuzzy search
    # appimage-run # to run AppImage
    yq # yaml and toml parser
    zip #....
    unzip #....
    ffmpeg-full #...
    fwupd #...
    tree #...
    httpie # tools for consume http and https / alternative curl 
    waypipe # piping wayland / xhost in wayland / run gui in ssh over wayland
    babelfish # for run bash code in fish
  ] ++ (with fishPlugins; [
    zoxide-fish # integration zoxide in fish (faster than general)
    fzf-fish # fuzzy finder in fish
    git-abbr # abbreviation / autocomplete git
    pisces # autoclose brackets parenthesis and quote
  ]);
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.git.enable = true;
}
