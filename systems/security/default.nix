{
  polkit = {
    enable = true;
  };

  # register package to pam services
  pam.services = {
    swaylock = {};
  };
}
