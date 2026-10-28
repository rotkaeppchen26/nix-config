{
  name,
  description ? name,
  groups ? [],
  packages ? (pkgs: []),
  ...
}: {
  lib, config, pkgs, ...
}: let
  cfg = config.home.${name};
in {
  options.home.${name} = {
    enable = lib.mkEnableOption "user ${name}";
    admin = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Grant sudo access via the wheel group.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${name} = {
      inherit description;
      isNormalUser = true;
      extraGroups =
        ["networkManager"]
        ++ groups
        ++ lib.optional cfg.admin "wheel";
        #++ lib.optional cfg.features.services.docker.enable "docker";
      packages = packages pkgs;
    };
  };
}
