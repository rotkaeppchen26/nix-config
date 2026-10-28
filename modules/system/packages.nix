{ inputs, ... }:
{
  flake.nixosModules.packages = {pkgs, ...}: {

    environment.systemPackages = with pkgs; [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      keepassxc
      thunderbird
      obsidian
      discord-canary
    ];

  };
}
