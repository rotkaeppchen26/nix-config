{pkgs, username, ...}:
{

  # set fish as default
  users.users.${username}.shell = pkgs.fish;

  # enable fish, starship prompt and other cli utils
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.zoxide = {
  	enable = true;
  	flags = [ "--cmd cd" ];
  };

  # enable direnv for easier dev shells
  programs.direnv.enable = true;
}
