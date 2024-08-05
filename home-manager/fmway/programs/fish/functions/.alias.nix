{ matchers, parseFish, ... }: let
in [{
  match = matchers.extension "fish";
  alias = body: parseFish body;
}]
