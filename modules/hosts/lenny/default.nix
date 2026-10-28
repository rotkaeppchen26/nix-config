{
  self,
  inputs,
  ...
}: {

  flake.nixosConfigurations.lenny = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      system features home
      ./_hardware-configuration.nix
      ./_configuration.nix
      ./_packages.nix
      ./_shell.nix
      ./_development.nix
      inputs.nixos-hardware.nixosModules.lenovo-legion-16iah7h
      {
        networking.hostName = "lenny";
        system.stateVersion = "25.05";

        features.desktop = "kde";
        features.services.nix-ld.enable = true;
        features.hardware = {
          bluetooth.enable = true;
          laptop.enable = true;
        };

        home.derrix = {
          enable = true;
          admin = true;
        };
      }
    ];
  };


}
