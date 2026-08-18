{ pkgs, ... }:
{

  programs.uwsm.enable = true;

  # enable hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;  # Not always enough, see following block comment
    xwayland.enable = true;
  };

  ###
  # For fixing issues with starting dms on boot add the following
  # scripts that start up the graphic session for the dms service
  #
  # hl.on("hyprland.start", function()
  #     hl.exec_cmd("systemctl --user start hyprland-session.target")
  # end)
  #
  # hl.on("hyprland.shutdown", function()
  #     os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
  #     -- uses a blocking exec function and sleeps a bit to give things time to close
  #     -- you might also want to kill troublesome/crashing non-systemd background services here:
  #     -- os.execute("pkill wallpaperthing; systemctl --user stop hyprland-session.target && sleep 0.1")
  # end)

  # part of plex fix
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  # Services used by a variety of Desktop shells
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

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

  # Basic utilities for a functioning hyprland session.
  environment.systemPackages = with pkgs; [
    kitty 	# terminal
    wofi 	# session manager?
    brightnessctl playerctl 	# required for keybinds
    hyprshot 	# screenshot utility
    hyprlauncher  # application launcher
  ];

  programs.yazi.enable = true;

}
