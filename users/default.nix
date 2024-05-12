{ pkgs, ... }: {
  users.users = {
    fmway = import ./fmway.nix { inherit pkgs; };
  }; 
}
