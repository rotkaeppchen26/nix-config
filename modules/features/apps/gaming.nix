{ ... }:
{
  flake.nixosModules.feature-gaming = {
    lib, config, pkgs, ...
  }: let
    cfg = config.features.apps.gaming;
    sub = name: default:
      lib.mkOption {
        type = lib.types.bool;
        inherit default;
        description = "Enable ${name}.";
      };
  in {
    options.features.apps.gaming = {
      enable = lib.mkEnableOption "gaming launchers and tooling";
    };

    config = lib.mkIf cfg.enable {

      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      programs.gamemode.enable = true;

      environment.systemPackages = with pkgs; [
        gamescope
        protonplus

        # Emulators
        # ppsspp
        # pcsx2
        # dolphin-emu
        # mgba
        # mesen

        # Installers & Launchers
        umu-launcher
        faugus-launcher
        lutris
        heroic
      ];

    };
  };
}
