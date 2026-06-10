{ pkgs, ... }:
{

  # enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # part of plex fix
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  # Noctalia services
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # hyprland specific
  programs.steam.gamescopeSession.enable = true;
  programs.yazi.enable = true;

  # set console keyboard layout
  console.keyMap = "de-latin1-nodeadkeys";

  # fix steam ui scaling
  environment.variables = {
    GDK_SCALE = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };

  # more keyboard fixing
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XKB_DEFAULT_LAYOUT = "at";
    XKB_DEFAULT_VARIANT = "nodeadkeys";
  };

  environment.systemPackages = with pkgs; [
    kitty 	# terminal
    wofi 	# session manager?
    #waybar 	# task bar (optional due to noctalia)
    noctalia-shell
    brightnessctl playerctl 	# required for keybinds
    hyprshot 	# screenshot utility
  ];

}
