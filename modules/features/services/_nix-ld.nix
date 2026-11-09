{ ... }:
{
  flake.nixosModules.feature-service-containers = {
    lib, config, pkgs, ...
  }: let
    cfg = config.features.services.nix-ld;
  in {
    options.features.services.nix-ld = {
      enable = lib.mkEnableOption "enables container support via podman";
    };

    config = lib.mkIf cfg.enable {

    };

  };
}
