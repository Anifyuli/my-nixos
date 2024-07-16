{ config, ... }:
{
  fmway = {
    socket = {
      group = config.services.caddy.group;
      mode = "0666";
    };
    process = {
      user = config.users.users.fmway.name;
      group = config.users.groups.users.name;
    };
  };
}
