# taken from https://github.com/WolfangAukang/nixpkgs/commit/3c6f251f75a48281195c413a75f1ff9607726e69
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  xcfg = config.services.xserver;
  dmcfg = xcfg.displayManager;
  cfg = dmcfg.ly;
  xEnv = config.systemd.services.display-manager.environment;
  sessionData = config.services.displayManager.sessionData;

  mk_save = cfg.defaultUser != null;
  tty = "tty${toString xcfg.tty}";

  save_file =
    if !mk_save
    then ""
    else
      pkgs.writeText "ly-prefs" ''
        ${cfg.defaultUser}
        ${toString cfg.defaultSessionIndex}
      '';

  lyconfig = ''
    # As these settings cannot be patched, we will set them as default
    xsessions = /etc/ly/xsessions
    waylandsessions = /etc/ly/wayland-sessions
    wayland_cmd = /etc/ly/wsetup.sh
    mcookie_cmd = /etc/ly/bin/mcookie
    # An empty path variable will prevent ly from setting it
    path =
    # We will rely on the save_file
    save = true
    save_file = /etc/ly/ly-prefs 
    load = ${
      if mk_save
      then "true"
      else "false"
    }
    tty = ${toString xcfg.tty}
    x_cmd = /etc/ly/bin/xserver-wrapper
    x_cmd_setup = /etc/ly/xsetup.sh 
    xauth_cmd = /etc/ly/bin/xauth

    shutdown_cmd = systemctl poweroff
    term_reset_cmd = tput reset
    # Terminal restore cursor command
    term_restore_cursor_cmd = tput cnorm

    animate = true
    animation = 0

    vi_mode = true


    ${cfg.extraConfig}
  '';

  xsetup = pkgs.writeShellScript "xsetup.sh" ''
  # Xsession - run as user
  # Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>

  # This file is extracted from kde-workspace (kdm/kfrontend/genkdmconf.c)
  # Copyright (C) 2001-2005 Oswald Buddenhagen <ossi@kde.org>

  # Note that the respective logout scripts are not sourced.
  case $SHELL in
    */bash)
      [ -z "$BASH" ] && exec $SHELL $0 "$@"
      set +o posix
      [ -f /etc/profile ] && . /etc/profile
      if [ -f $HOME/.bash_profile ]; then
        . $HOME/.bash_profile
      elif [ -f $HOME/.bash_login ]; then
        . $HOME/.bash_login
      elif [ -f $HOME/.profile ]; then
        . $HOME/.profile
      fi
      ;;
    */zsh)
      [ -z "$ZSH_NAME" ] && exec $SHELL $0 "$@"
      [ -d /etc/zsh ] && zdir=/etc/zsh || zdir=/etc
      zhome=''${ZDOTDIR:-$HOME}
      # zshenv is always sourced automatically.
      [ -f $zdir/zprofile ] && . $zdir/zprofile
      [ -f $zhome/.zprofile ] && . $zhome/.zprofile
      [ -f $zdir/zlogin ] && . $zdir/zlogin
      [ -f $zhome/.zlogin ] && . $zhome/.zlogin
      emulate -R sh
      ;;
    */csh|*/tcsh)
      # [t]cshrc is always sourced automatically.
      # Note that sourcing csh.login after .cshrc is non-standard.
      xsess_tmp=`mktemp /tmp/xsess-env-XXXXXX`
      $SHELL -c "if (-f /etc/csh.login) source /etc/csh.login; if (-f ~/.login) source ~/.login; /bin/sh -c 'export -p' >! $xsess_tmp"
      . $xsess_tmp
      rm -f $xsess_tmp
      ;;
    */fish)
      [ -f /etc/profile ] && . /etc/profile
      xsess_tmp=`mktemp /tmp/xsess-env-XXXXXX`
      $SHELL --login -c "/bin/sh -c 'export -p' > $xsess_tmp"
      . $xsess_tmp
      rm -f $xsess_tmp
      ;;
    *) # Plain sh, ksh, and anything we do not know.
      [ -f /etc/profile ] && . /etc/profile
      [ -f $HOME/.profile ] && . $HOME/.profile
      ;;
  esac

  [ -f /etc/xprofile ] && . /etc/xprofile
  [ -f $HOME/.xprofile ] && . $HOME/.xprofile

  # run all system xinitrc shell scripts.
  if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for i in /etc/X11/xinit/xinitrc.d/* ; do
    if [ -x "$i" ]; then
      . "$i"
    fi
    done
  fi

  # Load Xsession scripts
  # OPTIONFILE, USERXSESSION, USERXSESSIONRC and ALTUSERXSESSION are required
  # by the scripts to work
  xsessionddir="/etc/X11/Xsession.d"
  OPTIONFILE=/etc/X11/Xsession.options
  USERXSESSION=$HOME/.xsession
  USERXSESSIONRC=$HOME/.xsessionrc
  ALTUSERXSESSION=$HOME/.Xsession

  if [ -d "$xsessionddir" ]; then
      for i in `ls $xsessionddir`; do
          script="$xsessionddir/$i"
          echo "Loading X session script $script"
          if [ -r "$script"  -a -f "$script" ] && expr "$i" : '^[[:alnum:]_-]\+$' > /dev/null; then
              . "$script"
          fi
      done
  fi

  if [ -d /etc/X11/Xresources ]; then
    for i in /etc/X11/Xresources/*; do
      [ -f $i ] && xrdb -merge $i
    done
  elif [ -f /etc/X11/Xresources ]; then
    xrdb -merge /etc/X11/Xresources
  fi
  [ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources
  [ -f $XDG_CONFIG_HOME/X11/Xresources ] && xrdb -merge $XDG_CONFIG_HOME/X11/Xresources

  if [ -f "$USERXSESSION" ]; then
    . "$USERXSESSION"
  fi

  if [ -z "$*" ]; then
      exec xmessage -center -buttons OK:0 -default OK "Sorry, $DESKTOP_SESSION is no valid session."
  else
      exec $@
  fi
  '';

  wsetup = pkgs.writeShellScript "wsetup.sh" ''
  # wayland-session - run as user
  # Copyright (C) 2015-2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>

  # This file is extracted from kde-workspace (kdm/kfrontend/genkdmconf.c)
  # Copyright (C) 2001-2005 Oswald Buddenhagen <ossi@kde.org>

  # Note that the respective logout scripts are not sourced.
  case $SHELL in
    */bash)
      [ -z "$BASH" ] && exec $SHELL $0 "$@"
      set +o posix
      [ -f /etc/profile ] && . /etc/profile
      if [ -f $HOME/.bash_profile ]; then
        . $HOME/.bash_profile
      elif [ -f $HOME/.bash_login ]; then
        . $HOME/.bash_login
      elif [ -f $HOME/.profile ]; then
        . $HOME/.profile
      fi
      ;;
  */zsh)
      [ -z "$ZSH_NAME" ] && exec $SHELL $0 "$@"
      [ -d /etc/zsh ] && zdir=/etc/zsh || zdir=/etc
      zhome=''${ZDOTDIR:-$HOME}
      # zshenv is always sourced automatically.
      [ -f $zdir/zprofile ] && . $zdir/zprofile
      [ -f $zhome/.zprofile ] && . $zhome/.zprofile
      [ -f $zdir/zlogin ] && . $zdir/zlogin
      [ -f $zhome/.zlogin ] && . $zhome/.zlogin
      emulate -R sh
      ;;
    */csh|*/tcsh)
      # [t]cshrc is always sourced automatically.
      # Note that sourcing csh.login after .cshrc is non-standard.
      wlsess_tmp=`mktemp /tmp/wlsess-env-XXXXXX`
      $SHELL -c "if (-f /etc/csh.login) source /etc/csh.login; if (-f ~/.login) source ~/.login; /bin/sh -c 'export -p' >! $wlsess_tmp"
      . $wlsess_tmp
      rm -f $wlsess_tmp
      ;;
    */fish)
      [ -f /etc/profile ] && . /etc/profile
      xsess_tmp=`mktemp /tmp/xsess-env-XXXXXX`
      $SHELL --login -c "/bin/sh -c 'export -p' > $xsess_tmp"
      . $xsess_tmp
      rm -f $xsess_tmp
      ;;
    *) # Plain sh, ksh, and anything we do not know.
      [ -f /etc/profile ] && . /etc/profile
      [ -f $HOME/.profile ] && . $HOME/.profile
      ;;
  esac

  exec "$@"
  '';

  # Ly's config.ini doesn't support long lines, so we will create a
  # script for it.
  xserverWrapper = pkgs.writeShellScript "xserver-wrapper" ''
    ${concatMapStrings (n: "export ${n}=\"${getAttr n xEnv}\"\n") (attrNames xEnv)}
    exec ${dmcfg.xserverBin} ${toString dmcfg.xserverArgs} -keepty vt7 -verbose 2 -logfile /tmp/x11.log "$@"
  '';
in {
  meta.maintainers = with maintainers; [wolfangaukang];

  options = {
    services.xserver.displayManager.ly = {
      enable = mkEnableOption "ly as the display manager.";

      package = mkOption {
        type = types.package;
        default = pkgs.ly;
        defaultText = literalExpression "pkgs.ly";
        description = "<option>ly</option> package to use.";
      };

      defaultUser = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = "login";
        description = ''
          The default user to load. If you put a username here you
          get it automatically loaded into the username field, and
          the focus is placed on the password.
        '';
      };

      defaultSessionIndex = mkOption {
        type = lib.types.ints.unsigned;
        default = 0;
        example = 1;
        description = ''
          Index of the default session to load. This session will be
          preselected.
        '';
      };

      extraConfig = mkOption {
        type = types.nullOr types.str;
        default = "";
        example = literalExpression ''
          animate = true
          animation = 0
        '';
        description = ''
          Extra config to be added to the config.ini file. Check an example at
          https://github.com/fairyglade/ly/blob/master/res/config.ini.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = xcfg.enable;
        message = ''
          ly requires services.xserver.enable to be true
        '';
      }
    ];

    services.xserver.displayManager.lightdm.enable = false;
    services.xserver.displayManager.gdm.enable = false;

    environment.systemPackages = [ cfg.package ];
    environment.etc = {
      "ly/config.ini" = {
        mode = "0666";
        text = lyconfig;
      };
      "ly/xsetup.sh".source = xsetup;
      "ly/wsetup.sh".source = wsetup;
      "ly/bin/xserver-wrapper".source = xserverWrapper;
      "ly/xsessions".source = "${sessionData.desktops}/share/xsessions";
      "ly/wayland-sessions".source = "${sessionData.desktops}/share/wayland-sessions";
      "ly/bin/xauth".source = dmcfg.xauthBin;
    };

    

    security.pam.services.ly.text = ''
      auth       substack     login
      account    include      login
      password   substack     login
      session    include      login
    '';

    services.displayManager.execCmd = ''
      exec ${cfg.package}/bin/ly
    '';

    systemd.services."autovt@${tty}".enable = false;

    systemd.services.ly = {
      unitConfig = {
        Wants = [
          "systemd-user-sessions.service"
        ];
        After = [
          "systemd-user-sessions.service"
          "plymouth-quit-wait.service"
          "getty@${tty}.service"
        ];
        Conflicts = [
         "getty@${tty}.service"
        ];
      };

      serviceConfig = {
        Type = "idle";
        ExecStart = "${cfg.package}/bin/ly";
        StandardInput = "tty";
        TTYPath = "/dev/${tty}";
        TTYReset = "yes";
        TTYVHangup = "yes";
      };

      aliases = [
        "display-manager.service"
      ];

      restartIfChanged = false;

      wantedBy = ["graphical.target"];
    };

    systemd.defaultUnit = "graphical.target";

    users.users.ly = {
      isSystemUser = true;
      group = "ly";
    };

    users.groups.ly = {};
  };
}
