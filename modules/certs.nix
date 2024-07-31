{ config, lib, pkgs, ... }: let
  cfg = config.services.certs;
  tls-cert = {  alt ? [], cname ? "localhost" }:
  pkgs.runCommand "selfSignedCert" { buildInputs = [ pkgs.openssl ]; } ''
    mkdir -p $out
    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -days 365 -nodes \
      -keyout $out/cert.key -out $out/cert.crt \
      -subj "/CN=${cname}" -addext "subjectAltName=DNS:localhost,${builtins.concatStringsSep "," (["IP:127.0.0.1"] ++ alt)}"
  '';
  inherit (builtins) length attrNames;
  inherit (lib) mkIf mkOption mkBefore types;
in {
  options.certs = mkOption {
    type = types.attrs;
    default = {};
  };
  options.services.certs = mkOption {
    type = types.attrsOf (types.submodule ({ config, ... }: let
      cert = tls-cert { inherit (config) cname alt; };
    in  { options = {
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
      key = mkOption {
        type = types.oneOf [ types.str types.path ];
        default = "${cert}/cert.key";
      };
      cert = mkOption {
        type = types.oneOf [ types.str types.path ];
        default = "${cert}/cert.crt";
      };
    };}));
    default = {};
  };
  config = let
    names = attrNames cfg;
  in mkIf (length names != 0) {
    # register to pki
    security.pki.certificateFiles = mkBefore (map (x: cfg.${x}.cert) names);
  };
}
