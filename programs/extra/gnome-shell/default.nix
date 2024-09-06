# gdm with background
# place your background to /etc/current-background
{ super, self, ... }:
super.gnome-shell.overrideAttrs (old: {
  patches = (old.patches or []) ++ [
    ./bg.patch
  ];
})
