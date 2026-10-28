{ ... }:
{
  flake.nixosModules.home-derrix = import ./_mkUser.nix {
    name = "derrix";
    description = "derrix";
    packages = pkgs:
      with pkgs; [

      ];
  };
}
