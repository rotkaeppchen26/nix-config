{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    home-manager

    kdePackages.dolphin

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    keepassxc

    thunderbird
  ];
}
