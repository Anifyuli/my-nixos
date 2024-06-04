{
  # Enable doas
  # security.sudo.enable = false;
  security.doas = {
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

  # security.doas.enable = true;
  security.polkit = {
    enable = true;
  };


  # add pam services
  security.pam.services = {
    swaylock = {};
  };
}
