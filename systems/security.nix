# { inputs, lib, ... }:
let
  # basic fingerprint pam
  # fprint = ''
  #   # Account management.
  #   account required pam_unix.so
  #
  #   # Authentication management.
  #   auth sufficient pam_unix.so   likeauth try_first_pass nullok
  #   auth sufficient ${inputs.fingerprint-sensor.localPackages.fprintd-clients}/lib/security/pam_fprintd.so
  #   auth required pam_deny.so
  #
  #   # Password management.
  #   password sufficient pam_unix.so nullok sha512
  #
  #   # Session management.
  #   session required pam_env.so conffile=/etc/pam/environment readenv=0
  #   session required pam_unix.so
  # '';
in {
  polkit = {
    enable = true;
  };

  # register package to pam services
  pam.services = {
    swaylock = {};
    # login.fprintAuth = true;
    # sudo.fprintAuth = true;
  };

  # doas
  doas = {
    enable = true;
    extraRules = [
    {
      groups = [ "users" ];
      keepEnv = true;
      persist = true;
      setEnv = [
        "PATH"
      ];
    }
    ];
  };
}
