{ matchers, ... }:
[
{
  match = matchers.prefix "fastfetch";
  alias = settings: {
    inherit settings;
  };
}
]
