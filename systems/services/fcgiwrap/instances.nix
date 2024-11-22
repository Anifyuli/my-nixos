{ config, data, ... }:
{
  "${data.defaultUser}" = {
    socket = {
      group = config.services.caddy.group;
      user = config.users.users.${data.defaultUser}.name;
      mode = "0666";
    };
    process = {
      user = config.users.users.${data.defaultUser}.name;
      group = config.users.groups.users.name;
    };
  };
}
