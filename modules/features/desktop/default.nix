{ ... }: {
  flake.nixosModules.feature-desktop = {
    lib, config, ...
  }: {
    options.features.desktop = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["kde" "gnome"]);
      default = null;
      description = "DE for this host or null for headless";
    };

    config = lib.mkIf (config.features.desktop  != null) {
      services.xserver.enable = true;
    };
  };
}
