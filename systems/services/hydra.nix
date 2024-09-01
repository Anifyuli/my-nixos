{
  enable = false;
  port = 9898;
  hydraURL = "https://hydra.local"; # externally visible URL
  notificationSender = "admin@hydra.local"; # e-mail of Hydra service
  # a standalone Hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
  buildMachinesFiles = [];
  # you will probably also want, otherwise *everything* will be built from scratch
  useSubstitutes = true;
}
