{ pkgs, ... }:
{
  enable = false;
  package = pkgs.sambaFull;
  settings.global = {
    "workgroup" = "WORKGROUP";
    "server string" = "smbnix";
    "netbios name" = "smbnix";
    "security" = "user ";
    # "use sendfile" = "yes";
    # "max protocol" = "smb2";
    # note: localhost is the ipv6 localhost ::1
    "hosts allow" = "192.168. 127.0.0.1 localhost";
    # "hosts deny" = "0.0.0.0/0";
    "guest account" = "nobody";
    "map to guest" = "bad user";
  };
  securityType = "user";
  openFirewall = true;
}
