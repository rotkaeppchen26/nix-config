{ ... }:
{
  flake.nixosModules.feature-desktop-kde = {
    lib, config, pkgs, ...
  }: {
    config = lib.mkIf (config.features.desktop == "kde") {
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      services.desktopManager.plasma6.enable = true;

      environment.systemPackages = with pkgs; [
        kdePackages.dolphin
        kdePackages.yakuake
        kdePackages.filelight
      ];
    };
  };
}
