{
  description = "A cleaner, idiomatic Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-deprecated, ... }@inputs:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Define overlays to inject unstable and deprecated packages safely
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    };

    overlay-deprecated = final: prev: {
      deprecated = import nixpkgs-deprecated {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    };

    mkSystem = { system ? "x86_64-linux", username, modules }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = modules ++ [
          {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            nixpkgs.hostPlatform = system;
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [ overlay-unstable overlay-deprecated ];
          }
        ];
      };

  in
  {
    nixosConfigurations = {
      lenny = mkSystem {
        username = "derrix";
        modules = [
          ./hosts/lenny/configuration.nix
          ./modules/desktop/hyprland.nix
          ./modules/desktop/caelestia.nix
          ./modules/core.nix
          ./modules/shell.nix
          ./modules/development.nix
          ./modules/media.nix
          ./modules/gaming.nix
          ./modules/nixld.nix
        ];
      };

      holly = mkSystem {
        username = "derrick";
        modules = [
          ./hosts/holly/configuration.nix
          ./modules/desktop/kde.nix
          ./modules/core.nix
          ./modules/shell.nix
          ./modules/development.nix
          ./modules/media.nix
          ./modules/nixld.nix
        ];
      };
    };
  };
}
