{ pkgs, inputs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager

    kdePackages.dolphin

    librewolf
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    keepassxc

    thunderbird
  ];
}
