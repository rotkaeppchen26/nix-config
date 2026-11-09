{ ... }: {
  # Define flake part nixosModule "hostConfiguration" and pass in arch specific pkgs
  flake.nixosModules.hostConfiguration = {config, pkgs, ...}: {
    # Normal nix code within module, add git to systemPackages
    environment.systemPackages = with pkgs; [
      lshw  # hardware listener
      stow  # symlink farm
      p7zip
      qpwgraph
      edopro
      unstable.wowup-cf
    ];

    ###
    # HARDWARE CONFIG
    ###
    # enable lenovo_ideapad specific conservation mode
    systemd.tmpfiles.rules = [
      "w /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode - - - - 1"
    ];

    boot = {
      extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
      kernelModules = [ "legion-laptop" ];
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware.opentabletdriver.enable = true;
    services.printing.enable = true;

    # Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "derrix";

  };
}
