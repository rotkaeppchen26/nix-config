{
  programs.fish.shellAliases = {
    gip = "git pull";
    gus = "git status";
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "derrick";
        email = "drunkenplayer9@gmail.com";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;

      credential.helper = "store";
      "credential \"https://github.com\"" = {
        helper = [
          ""
          "!/run/current-system/sw/bin/gh auth git-credential"
        ];
      };
    };
  };

}
