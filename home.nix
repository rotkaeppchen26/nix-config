{ config, pkgs, username, osConfig, ... }:
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  imports = [
    ./home/lenny  # TODO: make it follow hostname; change hostnames from 'nixos' to lenny/holly
  ];

  #home.packages = with pkgs; [ ripgrep fd bat eza ];
}
