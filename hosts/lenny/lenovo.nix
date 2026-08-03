{pkgs, username, ...}:
{
  users.groups.lenovoctl = {};
  users.users.${username}.extraGroups = [ "lenovoctl" ];

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="platform", DRIVER=="ideapad_acpi", GROUP="lenovoctl", MODE="0664"
  '';
}
