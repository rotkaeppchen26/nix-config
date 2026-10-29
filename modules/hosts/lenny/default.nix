{
  self,
  inputs,
  pkgs,
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

        features.desktop = "kde";
        #features.services.nix-ld.enable = true;
        # features.hardware = {
        #   bluetooth.enable = true;
        #   laptop.enable = true;
        # };

        features.apps = {
          gaming.enable = true;
          media.enable = true;
        };

        features.development.enable = true;

        features.services.appimage.enable = true;

        home.derrix = {
          enable = true;
          admin = true;
        };

      }
    ];
  };


}
