{
  networking.firewall = {
      enable = true;
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
        23253 # Direct BG3 hosting connection
      ];
  };

  services.terraria.openFirewall = true;
  programs.steam = {
    remotePlay.openFirewall = true; # Optional
    dedicatedServer.openFirewall = true; # Optional
  };
}
