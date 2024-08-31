# github-cli dashboard
{
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "teal";
  };
  settings = {
    prSections = [{
      title = "My Pull Requests";
      filters = "is:open author:@me";
    }];
  };
}
