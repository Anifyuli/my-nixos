{ lib
, stdenv
}:
let
  version = "2.7.6";
in
stdenv.mkDerivation rec {
  pname = "caddy";
  inherit version;

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 ${pname} $out/bin/${pname}
  '';

  meta = with lib; {
    homepage = "https://caddyserver.com";
    description = "Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS";
    license = licenses.asl20;
    mainProgram = "caddy";
    maintainers = with maintainers; [ Br1ght0ne emilylange techknowlogick ];
  };
}
