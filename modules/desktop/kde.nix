{ pkgs, ... }:
{

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.yakuake
    kdePackages.filelight
  ];

}
