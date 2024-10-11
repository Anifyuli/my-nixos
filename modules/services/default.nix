{ pkgs, ...}:

{
  # Apache2 server
  services.httpd = {
    enable = true;
    adminAddr = "localhost";
    enablePHP = true;
    group = "users";
    phpPackage = pkgs.php;
    phpOptions = ''
      date.timezone = "Asia/Jakarta";
      display_errors = on;
      upload_max_filesize = "100M";
      post_max_size = "100M";
    '';
    user = "anifyuli";
    virtualHosts."htdocs" = {
      documentRoot = "/home/anifyuli/Developments/Web/htdocs";
      locations."/".index = "index.php index.html";
    };
  };

  # MariaDB server
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # PostgreSQL server
  services.postgresql = {
    enable = false;
    package = pkgs.postgresql_15;
  };

  # Setup PHP FPM
  services.phpfpm.phpOptions = ''
    display_errors = on;
  '';
  
  # Enable GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # direnv setup
  programs.direnv.enable = true;

  # Enable Flatpak support
  services.flatpak.enable =  true;
  xdg.portal.enable = true;

  # Enable touchegg for X11 gesture support
  services.touchegg.enable = true;

  # Enable fwupd for updating firmware
  services.fwupd.enable = true;

  # Enable thermald for CPU temperature auto handling
  services.thermald.enable = true;

  # Enable throttled.service for fix Intel CPU throttling
  services.throttled.enable = true;

  # Enable earlyoom for handling OOM conditions
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 2;
    freeSwapThreshold = 3;
  };

  # Enable CUPS to document printings
  services.printing.enable = true;

  # Pipewire support
  services.pipewire = {
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable the X11 windowing system & Xterm as login session
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  # Enable the GNOME Desktop Environment & Dconf configurations
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.desktop.peripherals.touchpad]
      tap-to-click=true
    ''; # Enable tap-to-click on GDM
    extraGSettingsOverridePackages = with pkgs; [
      gsettings-desktop-schemas # for org.gnome.desktop
      gnome-shell # for org.gnome.shell
    ];
  };

  # Evolution data server
  services.gnome.evolution-data-server.enable = true;

  # Enable touchpad support (enabled default in most desktopManager)
  services.libinput.enable = true;

  # Exclude packages from the X server
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Enable systemd services which is not configured from services options
  systemd = {
    packages = with pkgs; [
      cloudflare-warp
    ];
    targets.multi-user.wants = [
      "warp-svc.service"
    ];
  };
}
