{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    keepassxc

    thunderbird
  ];
}
