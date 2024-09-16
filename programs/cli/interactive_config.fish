abbr -a nofu "$(string join \n -- 'cd /etc/nixos' 'doas nix flake update' 'cd -')"
abbr -a nofl "$(string join \n -- 'cd /etc/nixos' 'doas nix flake lock' 'cd -')"
abbr -a noflu \
  --set-cursor=! \
  "$(string join \n -- 'cd /etc/nixos' 'doas nix flake lock --update-input !' 'cd -')"
abbr -a nfit "nix flake init --template"
