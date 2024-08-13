{ pkgs, ... }:
{
  # NixVim
  enable = false;
  colorschemes.gruvbox.enable = true;
  plugins.lightline.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    vim-nix
  ];

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
  };

  keymaps = [
    {
      key = ";";
      action = ":";
    }
    {
      mode = "n";
      key = "<leader>m";
      options.silent = true;
      action = "<cmd>!make<CR>";
    }
  ];
}
