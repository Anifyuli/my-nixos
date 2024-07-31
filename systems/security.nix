{
  polkit = {
    enable = true;
  };

  # register package to pam services
  pam.services = {
    swaylock = {};
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
