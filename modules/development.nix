{ pkgs, ... }:
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
}
