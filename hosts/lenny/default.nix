{ pkgs, ... }:
{
  imports = [
    ./configuration.nix # basic config
    ./packages.nix  # odd host specific packages that don't necessitate their own module
  ];
}
