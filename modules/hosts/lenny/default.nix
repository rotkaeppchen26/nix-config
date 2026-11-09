{
  self,
  inputs,
  ...
}: {

  flake.nixosConfigurations.lenny = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      system features home hostConfiguration
      ./_hardware-configuration.nix
      ./_shell.nix
      inputs.nixos-hardware.nixosModules.lenovo-legion-16iah7h
      {
        networking.hostName = "lenny";
        system.stateVersion = "25.05";

        home.derrix = {
          enable = true;
          admin = true;
        };

        features.desktop = "kde";

        features.hardware.kone-aimo.enable = true;

        features.apps = {
          gaming.enable = true;
          media.enable = true;
        };

        features.development.enable = true;

        features.services = {
          podman.enable = true;
          appimage.enable = true;
          flatpak.enable = true;
        };

      }
    ];
  };


}
