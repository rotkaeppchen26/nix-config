{ pkgs, ... }:
{

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
    ppsspp
    pcsx2
    dolphin-emu
    mgba
    mesen

    # Installers & Launchers
    umu-launcher
    faugus-launcher
    lutris
    heroic
  ];
}
