{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # editors
    vim
    vscode
    msedit
    unstable.zed-editor-fhs

    # web stuff
    wget
    curl
    git
    gh

    # build+
    jq
    gnumake

    # lsp
    nixd
    nil
    rust-analyzer

  ];

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

}
