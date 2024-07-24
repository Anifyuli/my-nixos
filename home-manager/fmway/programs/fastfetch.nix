{
  enable = true;
  settings = {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    display = {
      separator = " ";
    };
    modules = [
      {
        type = "host";
        key = "╭─󰌢";
        keyColor = "green";
      }
      {
        type = "cpu";
        key = "├─󰻠";
        keyColor = "green";
      }
      {
        type = "gpu";
        key = "├─󰍛";
        keyColor = "green";
      }
      {
        type = "disk";
        key = "├─";
        keyColor = "green";
      }
      {
        type = "memory";
        key = "├─󰑭";
        keyColor = "green";
      }
      {
        type = "swap";
        key = "├─󰓡";
        keyColor = "green";
      }
      {
        type = "display";
        key = "╰─󰍹";
        keyColor = "green";
      }
      "break"
      {
        type = "shell";
        key = "╭─";
        keyColor = "yellow";
      }
      {
        type = "terminal";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "terminalfont";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "de";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "wm";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "theme";
        key = "├─󰉼";
        keyColor = "yellow";
      }
      {
        type = "icons";
        key = "╰─󰀻";
        keyColor = "yellow";
      }
      "break"
      {
        type = "title";
        key = "╭─";
        format = "{1}@{2}";
        keyColor = "blue";
      }
      {
        type = "os";
        key = "├─";
        keyColor = "blue";
      }
      {
        type = "kernel";
        key = "├─";
        format = "{1} {2}";
        keyColor = "blue";
      }
      {
        type = "packages";
        key = "├─󰏖";
        keyColor = "blue";
      }
      {
        type = "uptime";
        key = "╰─󰅐";
        keyColor = "blue";
      }
    ];
  };
}
