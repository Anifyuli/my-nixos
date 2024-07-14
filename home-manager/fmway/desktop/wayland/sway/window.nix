let
  floating_fn = { app_id ? [ ], class ? [ ], title ? [ ] }:
    builtins.foldl' (acc: elem: acc + ''for_window [app_id="${elem}"] floating enable'' + ''''\n'') "" app_id +
    builtins.foldl' (acc: elem: acc + ''for_window [class="${elem}"] floating enable'' + ''''\n'') "" class +
    builtins.foldl' (acc: elem: acc + ''for_window [title="${elem}"] floating enable'' + ''''\n'') "" title; 
  fullscreen_fn = { app_id ? [ ], class ? [ ], title ? [ ] }:
    builtins.foldl' (acc: elem: acc + ''for_window [app_id="${elem}"] fullscreen enable'' + ''''\n'') "" app_id +
    builtins.foldl' (acc: elem: acc + ''for_window [class="${elem}"] fullscreen enable'' + ''''\n'') "" class +
    builtins.foldl' (acc: elem: acc + ''for_window [title="${elem}"] fullscreen enable'' + ''''\n'') "" title; 
  window = { fullscreen ? {}, floating ? {} }: floating_fn floating + fullscreen_fn fullscreen;

in window {
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
