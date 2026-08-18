{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    plex-desktop
    haruna
  ];

  xdg.portal = {
    # Plex login fix
    enable = true;
    xdgOpenUsePortal = true;
  };
}
