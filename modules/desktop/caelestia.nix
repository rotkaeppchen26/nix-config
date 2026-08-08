{ pkgs, inputs, username, ... }:
{
  environment.systemPackages = [
    inputs.caelestia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
