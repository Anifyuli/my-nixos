{
  # enableFishIntegration = true; # see note on other shells below
  nix-direnv.enable = true;
  stdlib = ''
    session_name() {
      export TMUX_SESSION_NAME="''${*:?session_name needs a name as argument}"
    }
  '';
}
