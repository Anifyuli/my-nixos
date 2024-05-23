{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "gendesk";
  version = "1.0.9";

  src = fetchFromGitHub {
    owner = "xyproto";
    repo = "gendesk";
    rev = version;
    hash = "sha256-S0vJd7xGFLRP72XJg3bsxbB2ynkMuDGj/ixzjxKsi24=";
  };

  vendorHash = null;

  ldflags = [ "-s" "-w" ];

  meta = with lib; {
    description = "Herb: Generate .desktop files and download .png icons by specifying a minimum of information";
    homepage = "https://github.com/xyproto/gendesk";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "gendesk";
  };
}
