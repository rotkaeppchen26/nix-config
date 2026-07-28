{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    # editors
    vim vscode msedit zed-editor

    # web stuff
    wget curl git gh

    # build+
    jq gnumake

    # lsp
    nixd rust-analyzer

  ];

  # Enable Docker daemon
  virtualisation.docker.enable = true;

  # Add your user to the docker group
  users.users.${username}.extraGroups = [ "docker" ];
}
