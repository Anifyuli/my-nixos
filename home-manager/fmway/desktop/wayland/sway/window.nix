let
  inherit (builtins) foldl' attrNames map concatStringsSep;
  template = feature: selection: value: 
    ''for_window [${selection}="${value}"] ${feature} enable
  '';
  func = feature: { ... } @ set : let
    names = attrNames set;
    res = map (selection: let
      list = set.${selection};
      function = acc: elem: (template feature selection elem) + acc;
    in foldl' function "" list) names;
  in concatStringsSep "\n" res; 
  simple-window = { fullscreen ? {}, floating ? {} }:
    func "fullscreen" fullscreen +
    func "floating" floating;
in simple-window {
  fullscreen = {
    app_id = ["fullscreen-window"];
    class = ["fullscreen-window"];
    title = ["fullscreen-window"];
  };
  floating = {
    app_id = [
      "pop-up"
      "buble"
      "task_dialog"
      "Preferences"
      "dialog"
      "menu"
      "connman-gtk"
      "org.telegram*"
      "org.kde.kdeconnect.app"
      "mpv"
      "org.kde.kdenlive"
      "pavucontrol"
      "io.github.celluloid_player.Celluloid"
      "libfm-pref-apps"
      "floating-window"
      "org.kde.filelight"
      "scrcpy"
      "org.twosheds.iwgtk"
    ];

    class = [
      "mpv"
      "floating-window"
    ];

    title = [
      "Picture in Picture"
      "File Operation Progress"
      "Confirm to replace files"
      "Whoops!"
      "Friends List"
    ];
  };
}
