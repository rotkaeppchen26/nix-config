# Plain NixOS module, no flake needed: add ./kone-aimo-standalone.nix to imports in configuration.nix.
{pkgs, ...}: let
  kone-aimo = pkgs.callPackage ./_kone-aimo-package.nix {
    src = pkgs.fetchFromGitHub {
      owner = "phiph-s";
      repo = "roccat-kone-aimo-linux";
      rev = "e3d36feb6ad4677f82580503120c1121722b428f";
      hash = "sha256-S6YafNxdfccGBEI8b0ITmVcUts7IG3obWwMMzKCr4OM=";
    };
  };
in {
  environment.systemPackages = [
    kone-aimo
    kone-aimo.backup
  ];
  services.udev.packages = [kone-aimo];
}
