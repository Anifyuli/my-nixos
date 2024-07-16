{ pkgs, home, ... }: pkgs.genPaths home [
  ".local" # must be ${home}/.local/bin
  ".cargo" # etc
  ".deno"
  ".bun"
  ".foundry"
]
