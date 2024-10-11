{ config, pkgs, ... }:

{
  # Set your timezone
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n = {
     defaultLocale = "en_US.UTF-8";
     extraLocaleSettings = {
       LC_ADDRESS = "id_ID.UTF-8";
       LC_IDENTIFICATION = "id_ID.UTF-8";
       LC_MEASUREMENT = "id_ID.UTF-8";
       LC_MONETARY = "id_ID.UTF-8";
       LC_NAME = "id_ID.UTF-8";
       LC_NUMERIC = "id_ID.UTF-8";
       LC_PAPER = "id_ID.UTF-8";
       LC_TELEPHONE = "id_ID.UTF-8";
       LC_TIME = "id_ID.UTF-8";
   };
 }; 
  
  # Enable rtkit for addition audio configurations
  security.rtkit.enable = true; 

  # Enable GTK icon cache
  gtk.iconCache.enable = true;

  # Qt configurations
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  # Enable polkit for security reason
  security.polkit.enable = true; 

  # bindfs for Flatpak fonts & icons integration.
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "bind" "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [
        #libsForQt5.breeze-qt5  # for plasma
        gnome-themes-extra
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };
}
