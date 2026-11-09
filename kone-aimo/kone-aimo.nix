{inputs, ...}: {
  flake.nixosModules.feature-kone-aimo = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.features.hardware.kone-aimo;
    kone-aimo = pkgs.callPackage ./_kone-aimo-package.nix {src = inputs.kone-aimo-src;};
  in {
    options.features.hardware.kone-aimo.enable =
      lib.mkEnableOption "the ROCCAT Kone Aimo (Remastered / 16K, USB 1e7d:2e2c) configuration app";

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [
        kone-aimo
        kone-aimo.backup
      ];
      # The rule tags the mouse hidraw node with uaccess, so the local seat user needs no root.
      services.udev.packages = [kone-aimo];
    };
  };
}
