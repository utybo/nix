let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  unstable = unstable;
}
