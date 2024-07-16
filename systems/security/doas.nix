{
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
}
