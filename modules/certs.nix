{ config, lib, pkgs, ... }: let
  cfg = config.services.certs;
  tls-cert = {  alt ? [], cname ? "localhost" }:
  pkgs.runCommand "selfSignedCert" { buildInputs = [ pkgs.openssl ]; } ''
    mkdir -p $out
    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -days 365 -nodes \
      -keyout $out/cert.key -out $out/cert.crt \
      -subj "/CN=${cname}" -addext "subjectAltName=DNS:localhost,${builtins.concatStringsSep "," (["IP:127.0.0.1"] ++ alt)}"
  '';
  inherit (builtins) length attrNames foldl';
  inherit (lib) mkIf mkOption types recursiveUpdate;
in {
  options.certs = mkOption {
    type = types.attrs;
    default = {};
  };
  options.services.certs = mkOption {
    type = types.attrsOf (types.submodule ({ config, ... }: { options = {
      cname = mkOption {
        type = types.str;
        default = "localhost";
        description = "cname for the cert";
        example = ''cname = "download.mikrotik.com";'';
      }; 
      alt = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "alternative selain cname";
        example = ''alt = [ "DNS:download.mikrotik.com" ];'';
      };
    };}));
    default = {};
  };
  config = let
    names = attrNames cfg;
  in mkIf (length names != 0) rec {
    certs = foldl' (acc: key: recursiveUpdate acc {
      "${key}" = tls-cert cfg.${key};
    }) {} names;

    # register to pki
    security.pki.certificateFiles = map (x: let
      certed = certs.${x};
    in "${certed}/cert.crt") names;
  };
}
