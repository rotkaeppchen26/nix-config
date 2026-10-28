{ inputs, ... }: {
  flake.nixosModules.nix-settings = { ... } : {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;

    nixpkgs.overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
      })
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed $((64 * 1024**3))";
    };

    #registry.nixpkgs.flake = inputs.nixpkgs;

  };
}
