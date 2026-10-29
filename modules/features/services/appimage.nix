{ ... }:
{
  flake.nixosModules.feature-service-appimage = {
    lib, config, pkgs, ...
  }: let
    cfg = config.features.services.appimage;
  in {
    options.features.services.appimage = {
      enable = lib.mkEnableOption "enables appimage support";
    };

    config = lib.mkIf cfg.enable {

      programs.appimage = {
        enable = true;
        binfmt = true;
      };

    };
  };
}
