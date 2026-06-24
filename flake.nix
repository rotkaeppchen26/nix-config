{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixpkgs-deprecated.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-deprecated, nixos-hardware, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "derrix";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

    pkgs-deprecated = import nixpkgs-deprecated {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

  in
  {

    nixosConfigurations = {
      lenny = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system username inputs pkgs-unstable; };

        modules = [
          ./hosts/lenny/configuration.nix
          ./modules/desktop/hyprland.nix
          ./modules/core.nix
          ./modules/shell.nix
          ./modules/development.nix
          ./modules/media.nix
          ./modules/gaming.nix
        ];
      };

      holly = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system inputs pkgs-unstable pkgs-deprecated; };

        modules = [
          ./hosts/holly/configuration.nix
          ./modules/desktop/kde.nix
          ./modules/core.nix
          ./modules/development.nix
        ];
      };
    };

  };
}
