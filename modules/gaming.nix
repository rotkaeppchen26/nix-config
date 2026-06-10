{ pkgs, ... }:
{
  # # temporary lutris fix
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     openldap = prev.openldap.overrideAttrs (old: {
  #       doCheck = false;
  #     });
  #   })
  # ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    gamescope
    protonplus
    edopro
    osu-lazer

    ppsspp
    pcsx2
    dolphin-emu
    mgba

    umu-launcher
    faugus-launcher
    lutris
    heroic
  ];
}
