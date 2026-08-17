{ pkgs, unstable, ... }:
{
  unstable.programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };
}
