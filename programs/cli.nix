{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # vim
    neovim
    speechd
    # neovim-maximal
    wget
    doas
    starship
    zip
    unzip
    ffmpeg-full
    fwupd
    tree
    btop
    waypipe
  ];

  programs = {
    fish.enable = true;
    # Nano
    nano = {
      enable = true;
      nanorc = ''
        set nowrap
        set tabstospaces
        set tabsize 2
        set linenumbers
        set autoindent
        set mouse
      '';
    };

    # nix-ld for handling dynamic lib
    # nix-ld = {
      # enable = true;
      # libraries = with pkgs; [
        # glibc
        # openssl
        # gcc.cc.lib
      # ];
    # };

    
    # NixVim
    # nixvim = {
    #   enable = true;
    #   colorschemes.gruvbox.enable = true;
    #   plugins.lightline.enable = true;
    #   extraPlugins = with pkgs.vimPlugins; [
    #     vim-nix
    #   ];

    #   opts = {
    #     number = true;
    #     relativenumber = true;
    #     shiftwidth = 2;
    #   };

    #   keymaps = [
    #     {
    #       key = ";";
    #       action = ":";
    #     }
    #     {
    #       mode = "n";
    #       key = "<leader>m";
    #       options.silent = true;
    #       action = "<cmd>!make<CR>";
    #     }
    #   ];
    # };
  };
}
