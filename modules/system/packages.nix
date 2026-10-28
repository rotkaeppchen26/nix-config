{ ... }:
{
  flake.nixosModules.packages = {pkgs, ...}: {

    environment.systemPackages = with pkgs; [
      zen-browser
      keepassxc
      thunderbird
      obsidian
      discord-canary
    ];

  };
}
