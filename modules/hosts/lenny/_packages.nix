{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lshw  # hardware listener
    stow  # symlink farm
    p7zip
    qpwgraph
    edopro
  ];
}
