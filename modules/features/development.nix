{ ... }:
{
  flake.nixosModules.feature-development = {
    lib, config, pkgs, ...
  }: let
    cfg = config.features.development;
  in {
    options.features.development = {
      enable = lib.mkEnableOption "development stuff";
    };

    config = lib.mkIf cfg.enable {

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

    };
  };
}
