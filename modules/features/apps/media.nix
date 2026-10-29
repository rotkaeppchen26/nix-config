{ ... }:
{
  flake.nixosModules.feature-media = {
    lib, config, pkgs, ...
  }: let
    cfg = config.features.apps.media;
    sub = name: default:
      lib.mkOption {
        type = lib.types.bool;
        inherit default;
        description = "Enable ${name}.";
      };
  in {
    options.features.apps.media = {
      enable = lib.mkEnableOption "media players and tooling";
    };

    config = lib.mkIf cfg.enable {

      environment.systemPackages = with pkgs; [
        plex-htpc plex-desktop
        haruna
      ];

      xdg.portal = {
        # Plex login fix
        enable = true;
        xdgOpenUsePortal = true;
      };

    };
  };
}
