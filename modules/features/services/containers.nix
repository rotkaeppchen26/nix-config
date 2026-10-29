{ ... }:
{
  flake.nixosModules.feature-service-containers = {
    lib, config, pkgs, ...
  }: let
    cfg = config.features.services.containers.podman;
  in {
    options.features.services.containers.podman = {
      enable = lib.mkEnableOption "enables container support via podman";
    };

    config = lib.mkIf cfg.enable {

      # Enable common container config files in /etc/containers
      virtualisation.containers.enable = true;
      virtualisation = {
        podman = {
          enable = true;

          # Create a `docker` alias for podman, to use it as a drop-in replacement
          dockerCompat = true;

          # Required for containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };
      };

    };
  };
}
