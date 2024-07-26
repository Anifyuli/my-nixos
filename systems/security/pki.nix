{ config, pkgs }:
{
  # register your ssl cert
  certificateFiles = [
    # "${pkgs.certs.anu-cert}/cert.crt"
  ];
}
