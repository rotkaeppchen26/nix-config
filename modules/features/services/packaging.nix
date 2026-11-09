{ ... }:
{
  flake.nixosModules.feature-service-packaging = { lib, config, pkgs, ... }: let
    cfg = config.features.services;
  in {
    # Define multiple options cleanly
    options.features.services = {
      appimage.enable = lib.mkEnableOption "enables appimage support";
      flatpak.enable = lib.mkEnableOption "enables flatpak support";
    };

    # Combine multiple conditional blocks using lib.mkMerge
    config = lib.mkMerge [
      (lib.mkIf cfg.appimage.enable {
        programs.appimage = {
          enable = true;
          binfmt = true;
        };
      })

      (lib.mkIf cfg.flatpak.enable {
        services.flatpak.enable = true;
      })
    ];
  };
}
